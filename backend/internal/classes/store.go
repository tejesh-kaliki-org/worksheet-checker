package classes

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// Store is the persistence seam for the classes domain, narrowed to the
// queries this domain uses. See internal/auth/store.go for the rationale.
type Store interface {
	// CreateClass — sql/queries/classes.sql (2 params -> positional)
	CreateClass(ctx context.Context, name string, createdBy uuid.UUID) (database.Class, error)
	// ListClassesByOwner — sql/queries/classes.sql
	ListClassesByOwner(ctx context.Context, createdBy uuid.UUID) ([]database.Class, error)
	// GetClassByID — sql/queries/classes.sql
	GetClassByID(ctx context.Context, id uuid.UUID) (database.Class, error)
	// UpdateClass — sql/queries/classes.sql (2 params -> positional)
	UpdateClass(ctx context.Context, id uuid.UUID, name string) (database.Class, error)
	// DeleteClass — sql/queries/classes.sql
	DeleteClass(ctx context.Context, id uuid.UUID) error
	// BulkAddClassSubjects — sql/queries/class_subjects.sql (2 params -> positional)
	BulkAddClassSubjects(ctx context.Context, classID uuid.UUID, subjectIds []uuid.UUID) error
	// RemoveClassSubject — sql/queries/class_subjects.sql (2 params -> positional)
	RemoveClassSubject(ctx context.Context, classID uuid.UUID, subjectID uuid.UUID) error
	// ListSubjectsByClass — sql/queries/class_subjects.sql
	ListSubjectsByClass(ctx context.Context, classID uuid.UUID) ([]database.Subject, error)
	// CountOwnedSubjectsByIDs — sql/queries/subjects.sql (2 params -> positional)
	CountOwnedSubjectsByIDs(ctx context.Context, ownerID uuid.UUID, ids []uuid.UUID) (int64, error)
}

var _ Store = (*database.Queries)(nil)

// NewStore returns a Postgres-backed Store over the shared pool.
func NewStore(pool *pgxpool.Pool) Store { return database.New(pool) }
