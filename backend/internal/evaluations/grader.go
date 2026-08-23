package evaluations

import (
	"context"
	"encoding/json"
	"fmt"
	"math"
	"strings"
	"time"

	"github.com/google/uuid"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/bifrost"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/questionconfig"
)

// gradeResult is the LLM's holistic judgment of one Answer -- a Raw Score
// and Feedback, per ADR 0005 (no per-criterion breakdown yet).
type gradeResult struct {
	RawScore float64 `json:"raw_score"`
	Feedback string  `json:"feedback"`
}

// llmCallResult carries what the caller needs to log an LLM Call alongside
// the parsed grade.
type llmCallResult struct {
	grade     gradeResult
	model     string
	tokensIn  int32
	tokensOut int32
	latencyMs int32
}

// grade sends one Answer + its Question to Bifrost and parses the graded
// result. Every Question Type is graded uniformly via the LLM, including
// objective types -- see ADR 0008. Only the opaque correlationID and the
// Question/Answer content cross the Bifrost boundary; the Student's name and
// Roll Number are never loaded by this package, let alone sent (see
// CONTEXT.md — Correlation ID, and ADR 0006).
func grade(ctx context.Context, client *bifrost.Client, correlationID uuid.UUID, question database.Question, answer database.Answer) (llmCallResult, error) {
	prompt, err := buildPrompt(question, answer)
	if err != nil {
		return llmCallResult{}, fmt.Errorf("build grading prompt: %w", err)
	}

	start := time.Now()
	resp, err := client.Chat(ctx, bifrost.ChatRequest{
		CorrelationID: correlationID,
		Messages: []bifrost.Message{
			{Role: "system", Content: systemPrompt},
			{Role: "user", Content: prompt},
		},
	})
	latency := time.Since(start)
	if err != nil {
		return llmCallResult{}, fmt.Errorf("bifrost chat: %w", err)
	}

	result, err := parseGradeResponse(resp.Content)
	if err != nil {
		return llmCallResult{}, fmt.Errorf("parse grading response: %w", err)
	}

	out := llmCallResult{grade: result, model: resp.Model, latencyMs: latencyMsInt32(latency)}
	if resp.Usage != nil {
		out.tokensIn = resp.Usage.PromptTokens
		out.tokensOut = resp.Usage.CompletionTokens
	}
	return out, nil
}

// latencyMsInt32 converts an elapsed duration to milliseconds, clamped to
// int32's range so an unexpectedly long call (e.g. a stalled Bifrost
// request) can never overflow the llm_calls.latency_ms column's type.
func latencyMsInt32(d time.Duration) int32 {
	ms := d.Milliseconds()
	switch {
	case ms > math.MaxInt32:
		return math.MaxInt32
	case ms < 0:
		return 0
	default:
		return int32(ms)
	}
}

const systemPrompt = `You are grading a single student answer for a worksheet-checking system.
Score the answer holistically on a scale of 0.00 to 1.00 (raw_score), where
1.00 is fully correct and 0.00 is entirely wrong. Also produce targeted,
student-facing feedback explaining what the answer got right or wrong and
why -- not just "correct" or "incorrect".

Respond with ONLY a JSON object of the exact shape:
{"raw_score": <number between 0 and 1>, "feedback": "<string>"}`

// buildPrompt renders the Question's type, its correct-answer config, and
// the Student's raw answer text into a grading prompt. It never includes a
// Student's name or Roll Number -- those aren't even loaded by this
// package's callers.
func buildPrompt(question database.Question, answer database.Answer) (string, error) {
	cfg, err := questionconfig.Unmarshal(questionconfig.Type(question.Type), question.Config)
	if err != nil {
		return "", err
	}
	cfgJSON, err := json.Marshal(cfg)
	if err != nil {
		return "", err
	}
	maxMarks, err := float64FromNumeric(question.MaximumMarks)
	if err != nil {
		return "", err
	}

	var b strings.Builder
	fmt.Fprintf(&b, "Question type: %s\n", question.Type)
	fmt.Fprintf(&b, "Question config (includes the correct answer / rubric): %s\n", string(cfgJSON))
	fmt.Fprintf(&b, "Maximum marks: %v\n", maxMarks)
	fmt.Fprintf(&b, "Student's answer: %s\n", answer.RawAnswer)
	return b.String(), nil
}

// parseGradeResponse extracts the JSON grade object from the LLM's raw
// response text, tolerating surrounding prose or a markdown code fence.
func parseGradeResponse(content string) (gradeResult, error) {
	start := strings.Index(content, "{")
	end := strings.LastIndex(content, "}")
	if start == -1 || end == -1 || end < start {
		return gradeResult{}, fmt.Errorf("no JSON object found in response")
	}
	var result gradeResult
	if err := json.Unmarshal([]byte(content[start:end+1]), &result); err != nil {
		return gradeResult{}, fmt.Errorf("decode grade JSON: %w", err)
	}
	if result.RawScore < 0 || result.RawScore > 1 {
		return gradeResult{}, fmt.Errorf("raw_score out of range: %v", result.RawScore)
	}
	if result.Feedback == "" {
		return gradeResult{}, fmt.Errorf("feedback is empty")
	}
	return result, nil
}
