// Package evaluations implements the Evaluation Attempt / Evaluation /
// LLM Call domain: triggering and reading the AI grading pipeline for a
// single Answer (see CONTEXT.md — Evaluation Attempt, Evaluation, LLM
// Call).
package evaluations

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// Store is the persistence seam for the evaluations domain, narrowed to the
// queries this domain uses (see internal/auth/store.go for the rationale).
type Store interface {
	// GetAnswerByID — sql/queries/answers.sql
	GetAnswerByID(ctx context.Context, id uuid.UUID) (database.Answer, error)
	// GetSubmissionByID — sql/queries/submissions.sql
	GetSubmissionByID(ctx context.Context, id uuid.UUID) (database.Submission, error)
	// GetExamSubjectByID — sql/queries/exam_subjects.sql
	GetExamSubjectByID(ctx context.Context, id uuid.UUID) (database.ExamSubject, error)
	// GetExamByID — sql/queries/exams.sql
	GetExamByID(ctx context.Context, id uuid.UUID) (database.Exam, error)
	// GetClassByID — sql/queries/classes.sql
	GetClassByID(ctx context.Context, id uuid.UUID) (database.Class, error)
	// GetQuestionByID — sql/queries/questions.sql
	GetQuestionByID(ctx context.Context, id uuid.UUID) (database.Question, error)

	// CreateEvaluationAttempt — sql/queries/evaluation_attempts.sql
	CreateEvaluationAttempt(ctx context.Context, answerID uuid.UUID, purpose database.EvaluationPurpose) (database.EvaluationAttempt, error)
	// GetEvaluationAttemptByID — sql/queries/evaluation_attempts.sql
	GetEvaluationAttemptByID(ctx context.Context, id uuid.UUID) (database.EvaluationAttempt, error)
	// UpdateEvaluationAttemptStatus — sql/queries/evaluation_attempts.sql
	UpdateEvaluationAttemptStatus(ctx context.Context, arg database.UpdateEvaluationAttemptStatusParams) (database.EvaluationAttempt, error)
	// ListEvaluationAttemptsByAnswer — sql/queries/evaluation_attempts.sql
	ListEvaluationAttemptsByAnswer(ctx context.Context, answerID uuid.UUID) ([]database.EvaluationAttempt, error)

	// CreateEvaluation — sql/queries/evaluations.sql
	CreateEvaluation(ctx context.Context, arg database.CreateEvaluationParams) (database.Evaluation, error)
	// GetEvaluationByAttemptID — sql/queries/evaluations.sql
	GetEvaluationByAttemptID(ctx context.Context, evaluationAttemptID uuid.UUID) (database.Evaluation, error)

	// CreateLLMCall — sql/queries/llm_calls.sql
	CreateLLMCall(ctx context.Context, arg database.CreateLLMCallParams) (database.LlmCall, error)
}

var _ Store = (*database.Queries)(nil)

// NewStore returns a Postgres-backed Store over the shared pool.
func NewStore(pool *pgxpool.Pool) Store { return database.New(pool) }
