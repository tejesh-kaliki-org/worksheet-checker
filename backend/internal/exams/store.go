package exams

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// Store is the persistence seam for the exams domain, narrowed to the
// queries this domain uses. See internal/auth/store.go for the rationale.
type Store interface {
	// GetClassByID — sql/queries/classes.sql
	GetClassByID(ctx context.Context, id uuid.UUID) (database.Class, error)
	// CreateExam — sql/queries/exams.sql (2 params -> positional)
	CreateExam(ctx context.Context, classID uuid.UUID, label string) (database.Exam, error)
	// ListExamsByClass — sql/queries/exams.sql
	ListExamsByClass(ctx context.Context, classID uuid.UUID) ([]database.Exam, error)
	// GetExamByID — sql/queries/exams.sql
	GetExamByID(ctx context.Context, id uuid.UUID) (database.Exam, error)
	// GetSubjectByID — sql/queries/subjects.sql
	GetSubjectByID(ctx context.Context, id uuid.UUID) (database.Subject, error)
	// AddExamSubject — sql/queries/exam_subjects.sql (2 params -> positional)
	AddExamSubject(ctx context.Context, examID uuid.UUID, subjectID uuid.UUID) (database.ExamSubject, error)
	// ListExamSubjectsByExam — sql/queries/exam_subjects.sql
	ListExamSubjectsByExam(ctx context.Context, examID uuid.UUID) ([]database.ExamSubject, error)
}

var _ Store = (*database.Queries)(nil)

// NewStore returns a Postgres-backed Store over the shared pool.
func NewStore(pool *pgxpool.Pool) Store { return database.New(pool) }
