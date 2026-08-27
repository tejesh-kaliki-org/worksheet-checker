package submissions

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// Store is the persistence seam for the submissions domain, narrowed to the
// queries this domain uses. See internal/auth/store.go for the rationale.
type Store interface {
	// GetClassByID — sql/queries/classes.sql
	GetClassByID(ctx context.Context, id uuid.UUID) (database.Class, error)
	// GetExamByID — sql/queries/exams.sql
	GetExamByID(ctx context.Context, id uuid.UUID) (database.Exam, error)
	// GetExamSubjectByID — sql/queries/exam_subjects.sql
	GetExamSubjectByID(ctx context.Context, id uuid.UUID) (database.ExamSubject, error)
	// GetStudentByID — sql/queries/students.sql
	GetStudentByID(ctx context.Context, id uuid.UUID) (database.Student, error)
	// GetQuestionByID — sql/queries/questions.sql
	GetQuestionByID(ctx context.Context, id uuid.UUID) (database.Question, error)

	// UpsertSubmission — sql/queries/submissions.sql
	UpsertSubmission(ctx context.Context, examSubjectID uuid.UUID, studentID uuid.UUID) (database.Submission, error)
	// ListSubmissionsByExamSubject — sql/queries/submissions.sql
	ListSubmissionsByExamSubject(ctx context.Context, examSubjectID uuid.UUID) ([]database.Submission, error)
	// GetSubmissionByID — sql/queries/submissions.sql
	GetSubmissionByID(ctx context.Context, id uuid.UUID) (database.Submission, error)

	// UpsertAnswer — sql/queries/answers.sql
	UpsertAnswer(ctx context.Context, arg database.UpsertAnswerParams) (database.Answer, error)
	// GetAnswerByID — sql/queries/answers.sql
	GetAnswerByID(ctx context.Context, id uuid.UUID) (database.Answer, error)
	// ListAnswersBySubmission — sql/queries/answers.sql
	ListAnswersBySubmission(ctx context.Context, submissionID uuid.UUID) ([]database.Answer, error)
	// UpdateAnswer — sql/queries/answers.sql
	UpdateAnswer(ctx context.Context, iD uuid.UUID, rawAnswer string) (database.Answer, error)
}

var _ Store = (*database.Queries)(nil)

// NewStore returns a Postgres-backed Store over the shared pool.
func NewStore(pool *pgxpool.Pool) Store { return database.New(pool) }
