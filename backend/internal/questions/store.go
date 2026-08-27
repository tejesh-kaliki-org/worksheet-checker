package questions

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// Store is the persistence seam for the questions domain, narrowed to the
// queries this domain uses. See internal/auth/store.go for the rationale.
type Store interface {
	// GetClassByID — sql/queries/classes.sql
	GetClassByID(ctx context.Context, id uuid.UUID) (database.Class, error)
	// GetExamByID — sql/queries/exams.sql
	GetExamByID(ctx context.Context, id uuid.UUID) (database.Exam, error)
	// GetExamSubjectByID — sql/queries/exam_subjects.sql
	GetExamSubjectByID(ctx context.Context, id uuid.UUID) (database.ExamSubject, error)
	// CreateQuestion — sql/queries/questions.sql
	CreateQuestion(ctx context.Context, arg database.CreateQuestionParams) (database.Question, error)
	// ListQuestionsByExamSubject — sql/queries/questions.sql
	ListQuestionsByExamSubject(ctx context.Context, examSubjectID uuid.UUID) ([]database.Question, error)
	// GetQuestionByID — sql/queries/questions.sql
	GetQuestionByID(ctx context.Context, id uuid.UUID) (database.Question, error)
	// UpdateQuestion — sql/queries/questions.sql
	UpdateQuestion(ctx context.Context, arg database.UpdateQuestionParams) (database.Question, error)
	// DeleteQuestion — sql/queries/questions.sql
	DeleteQuestion(ctx context.Context, id uuid.UUID) error
}

var _ Store = (*database.Queries)(nil)

// NewStore returns a Postgres-backed Store over the shared pool.
func NewStore(pool *pgxpool.Pool) Store { return database.New(pool) }
