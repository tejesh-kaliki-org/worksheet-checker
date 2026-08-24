package subjects

import (
	"context"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// Store is the persistence seam for the subjects domain, narrowed to the
// queries this domain uses. See internal/auth/store.go for the rationale.
type Store interface {
	// ListSubjectsByOwner — sql/queries/subjects.sql
	ListSubjectsByOwner(ctx context.Context, ownerID uuid.UUID) ([]database.Subject, error)
	// GetSubjectByID — sql/queries/subjects.sql
	GetSubjectByID(ctx context.Context, id uuid.UUID) (database.Subject, error)
	// CreateSubject — sql/queries/subjects.sql (2 params -> positional)
	CreateSubject(ctx context.Context, name string, ownerID uuid.UUID) (database.Subject, error)
}

var _ Store = (*database.Queries)(nil)

// NewStore returns a Postgres-backed Store over the shared pool.
func NewStore(pool *pgxpool.Pool) Store { return database.New(pool) }
