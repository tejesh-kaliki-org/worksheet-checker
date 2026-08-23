package subjects

import (
	"context"

	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// Store is the persistence seam for the subjects domain, narrowed to the
// queries this domain uses. See internal/auth/store.go for the rationale.
type Store interface {
	// ListSubjects — sql/queries/subjects.sql
	ListSubjects(ctx context.Context) ([]database.Subject, error)
}

var _ Store = (*database.Queries)(nil)

// NewStore returns a Postgres-backed Store over the shared pool.
func NewStore(pool *pgxpool.Pool) Store { return database.New(pool) }
