package students

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// Store is the persistence seam for the students domain, narrowed to the
// queries this domain uses. See internal/auth/store.go for the rationale.
type Store interface {
	// GetClassByID — sql/queries/classes.sql
	GetClassByID(ctx context.Context, id uuid.UUID) (database.Class, error)
	// CreateStudent — sql/queries/students.sql
	CreateStudent(ctx context.Context, arg database.CreateStudentParams) (database.Student, error)
	// BulkCreateStudents — sql/queries/students.sql
	BulkCreateStudents(ctx context.Context, arg database.BulkCreateStudentsParams) ([]database.Student, error)
	// ListStudentsByClass — sql/queries/students.sql
	ListStudentsByClass(ctx context.Context, classID uuid.UUID) ([]database.Student, error)
	// GetStudentByID — sql/queries/students.sql
	GetStudentByID(ctx context.Context, id uuid.UUID) (database.Student, error)
	// UpdateStudent — sql/queries/students.sql
	UpdateStudent(ctx context.Context, arg database.UpdateStudentParams) (database.Student, error)
	// DeleteStudent — sql/queries/students.sql
	DeleteStudent(ctx context.Context, id uuid.UUID) error
}

var _ Store = (*database.Queries)(nil)

// NewStore returns a Postgres-backed Store over the shared pool.
func NewStore(pool *pgxpool.Pool) Store { return database.New(pool) }
