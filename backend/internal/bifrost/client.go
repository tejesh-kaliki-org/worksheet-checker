// Package bifrost is a client for Bifrost, the LLM proxy this project grades
// Answers through. Bifrost speaks an OpenAI-compatible chat-completions API.
//
// PII SAFETY: callers must never put a Student's name or Roll Number into a
// Request — only opaque identifiers (the Evaluation Attempt's Correlation
// ID) may cross this boundary. See CONTEXT.md (Correlation ID) and
// ADR 0006.
package bifrost

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"

	"github.com/google/uuid"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/config"
)

// Client sends chat-completion requests to Bifrost.
type Client struct {
	baseURL    string
	apiKey     string
	model      string
	httpClient *http.Client
}

// New builds a Client from BifrostConfig (see internal/config).
func New(cfg config.BifrostConfig) *Client {
	return &Client{
		baseURL:    cfg.BaseURL,
		apiKey:     cfg.APIKey,
		model:      cfg.Model,
		httpClient: &http.Client{Timeout: 60 * time.Second},
	}
}

// Message is a single chat message.
type Message struct {
	Role    string `json:"role"`
	Content string `json:"content"`
}

// ChatRequest is a chat-completion request. CorrelationID is passed as a
// header (x-correlation-id), not in the message body -- it links this call
// and any retries back to a single Evaluation Attempt without ever
// containing PII (see package docs).
type ChatRequest struct {
	Messages      []Message
	CorrelationID uuid.UUID
}

// ChatResponse is the subset of an OpenAI-compatible completion response
// this client cares about.
type ChatResponse struct {
	Content string
	Model   string
	// Usage is nil if Bifrost omitted it.
	Usage *Usage
}

type Usage struct {
	PromptTokens     int32
	CompletionTokens int32
}

type chatCompletionRequestBody struct {
	Model    string    `json:"model"`
	Messages []Message `json:"messages"`
}

type chatCompletionResponseBody struct {
	Model   string `json:"model"`
	Choices []struct {
		Message Message `json:"message"`
	} `json:"choices"`
	Usage *struct {
		PromptTokens     int32 `json:"prompt_tokens"`
		CompletionTokens int32 `json:"completion_tokens"`
	} `json:"usage"`
}

// Chat performs one request/response exchange against Bifrost's
// OpenAI-compatible /v1/chat/completions endpoint.
func (c *Client) Chat(ctx context.Context, req ChatRequest) (ChatResponse, error) {
	body, err := json.Marshal(chatCompletionRequestBody{Model: c.model, Messages: req.Messages})
	if err != nil {
		return ChatResponse{}, fmt.Errorf("bifrost: encode request: %w", err)
	}

	httpReq, err := http.NewRequestWithContext(ctx, http.MethodPost, c.baseURL+"/v1/chat/completions", bytes.NewReader(body))
	if err != nil {
		return ChatResponse{}, fmt.Errorf("bifrost: build request: %w", err)
	}
	httpReq.Header.Set("Content-Type", "application/json")
	if c.apiKey != "" {
		httpReq.Header.Set("Authorization", "Bearer "+c.apiKey)
	}
	// The Correlation ID doubles as the PII-safety boundary and the
	// pipeline-timing correlation key (see CONTEXT.md); it is the only
	// per-Evaluation-Attempt identifier sent to Bifrost.
	httpReq.Header.Set("x-correlation-id", req.CorrelationID.String())

	resp, err := c.httpClient.Do(httpReq)
	if err != nil {
		return ChatResponse{}, fmt.Errorf("bifrost: request failed: %w", err)
	}
	defer func() { _ = resp.Body.Close() }()

	respBody, err := io.ReadAll(resp.Body)
	if err != nil {
		return ChatResponse{}, fmt.Errorf("bifrost: read response: %w", err)
	}
	if resp.StatusCode != http.StatusOK {
		return ChatResponse{}, fmt.Errorf("bifrost: unexpected status %d: %s", resp.StatusCode, string(respBody))
	}

	var parsed chatCompletionResponseBody
	if err := json.Unmarshal(respBody, &parsed); err != nil {
		return ChatResponse{}, fmt.Errorf("bifrost: decode response: %w", err)
	}
	if len(parsed.Choices) == 0 {
		return ChatResponse{}, fmt.Errorf("bifrost: response had no choices")
	}

	out := ChatResponse{Content: parsed.Choices[0].Message.Content, Model: parsed.Model}
	if parsed.Usage != nil {
		out.Usage = &Usage{PromptTokens: parsed.Usage.PromptTokens, CompletionTokens: parsed.Usage.CompletionTokens}
	}
	return out, nil
}
