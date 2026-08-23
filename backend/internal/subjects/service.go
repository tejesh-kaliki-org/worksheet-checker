// Package subjects exposes the global, fixed Subject catalogue. It is
// read-only: Subjects are seeded by migration (see sql/schema/0007_subjects.sql)
// and never created/edited/deleted through the API.
package subjects

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5/pgxpool"

	gen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/subjects"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

type Service struct {
	store Store
}

func New(pool *pgxpool.Pool) *Service {
	return &Service{store: NewStore(pool)}
}

// Register mounts the generated routes under the given router group. middlewares
// typically includes the auth ScopeAuth so `security: bearerAuth` in the spec is
// enforced (see internal/auth/middleware.go).
func (s *Service) Register(r gin.IRouter, middlewares ...gen.MiddlewareFunc) {
	gen.RegisterHandlersWithOptions(r, s, gen.GinServerOptions{
		Middlewares: middlewares,
	})
}

// ListSubjects implements gen.ServerInterface.
func (s *Service) ListSubjects(c *gin.Context) {
	subjects, err := s.store.ListSubjects(c.Request.Context())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not list subjects"})
		return
	}
	c.JSON(http.StatusOK, gen.SubjectList{Subjects: toAPISubjects(subjects)})
}

func toAPISubject(s database.Subject) gen.Subject {
	return gen.Subject{Id: s.ID, Name: s.Name}
}

func toAPISubjects(subjects []database.Subject) []gen.Subject {
	out := make([]gen.Subject, 0, len(subjects))
	for _, s := range subjects {
		out = append(out, toAPISubject(s))
	}
	return out
}
