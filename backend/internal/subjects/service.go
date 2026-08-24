// Package subjects exposes each User's own Subject catalogue (see ADR 0009).
// Every User's catalogue is seeded with a default curriculum list at account
// creation (see SeedDefaults / internal/auth.Service.Signup) and is
// user-editable thereafter.
package subjects

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
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

// userID reads the authenticated user id set by auth.ScopeAuth. Every
// operation in this domain requires it (all are `security: bearerAuth`), so a
// missing/invalid value means the auth middleware wasn't wired.
func userID(c *gin.Context) (uuid.UUID, bool) {
	raw := c.GetString("user_id")
	id, err := uuid.Parse(raw)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "missing or invalid bearer token"})
		return uuid.UUID{}, false
	}
	return id, true
}

// ListSubjects implements gen.ServerInterface.
func (s *Service) ListSubjects(c *gin.Context) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	list, err := s.store.ListSubjectsByOwner(c.Request.Context(), uid)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not list subjects"})
		return
	}
	c.JSON(http.StatusOK, gen.SubjectList{Subjects: toAPISubjects(list)})
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
