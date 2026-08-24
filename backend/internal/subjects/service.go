// Package subjects exposes each User's own Subject catalogue (see ADR 0009).
// Every User's catalogue is seeded with a default curriculum list at account
// creation (see SeedDefaults / internal/auth.Service.Signup) and is
// user-editable thereafter.
package subjects

import (
	"errors"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/jackc/pgerrcode"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"
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
		c.JSON(http.StatusUnauthorized, gin.H{"msg": "missing or invalid bearer token"})
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
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not list subjects"})
		return
	}
	c.JSON(http.StatusOK, gen.SubjectList{Subjects: toAPISubjects(list)})
}

// CreateSubject implements gen.ServerInterface.
func (s *Service) CreateSubject(c *gin.Context) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	var body gen.CreateSubjectJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"msg": err.Error()})
		return
	}
	name := strings.TrimSpace(body.Name)
	if name == "" {
		c.JSON(http.StatusBadRequest, gin.H{"msg": "name is required"})
		return
	}
	subject, err := s.store.CreateSubject(c.Request.Context(), name, uid)
	if err != nil {
		if isUniqueViolation(err) {
			c.JSON(http.StatusConflict, gin.H{"msg": "a subject with that name already exists"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not create subject"})
		return
	}
	c.JSON(http.StatusCreated, toAPISubject(subject))
}

// BulkCreateSubjects implements gen.ServerInterface. Idempotent by name:
// names the caller already has are skipped, never rejected, so re-submitting
// the same list is a no-op rather than a 409 (see the spec description).
func (s *Service) BulkCreateSubjects(c *gin.Context) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	var body gen.BulkCreateSubjectsJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"msg": err.Error()})
		return
	}
	names, ok := cleanNames(c, body.Names)
	if !ok {
		return
	}
	if _, err := s.store.BulkCreateSubjects(c.Request.Context(), uid, names); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not create subjects"})
		return
	}
	list, err := s.store.ListSubjectsByOwner(c.Request.Context(), uid)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not list subjects"})
		return
	}
	c.JSON(http.StatusCreated, gen.SubjectList{Subjects: toAPISubjects(list)})
}

// cleanNames trims each requested name and rejects the request if the list is
// empty or any entry is blank, writing the 400 itself.
func cleanNames(c *gin.Context, raw []string) ([]string, bool) {
	if len(raw) == 0 {
		c.JSON(http.StatusBadRequest, gin.H{"msg": "names must not be empty"})
		return nil, false
	}
	names := make([]string, 0, len(raw))
	for _, n := range raw {
		trimmed := strings.TrimSpace(n)
		if trimmed == "" {
			c.JSON(http.StatusBadRequest, gin.H{"msg": "names must not contain blank entries"})
			return nil, false
		}
		names = append(names, trimmed)
	}
	return names, true
}

// UpdateSubject implements gen.ServerInterface.
func (s *Service) UpdateSubject(c *gin.Context, subjectID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsSubject(c, subjectID, uid) {
		return
	}
	var body gen.UpdateSubjectJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"msg": err.Error()})
		return
	}
	name := strings.TrimSpace(body.Name)
	if name == "" {
		c.JSON(http.StatusBadRequest, gin.H{"msg": "name is required"})
		return
	}
	updated, err := s.store.UpdateSubject(c.Request.Context(), subjectID, name)
	if err != nil {
		if isUniqueViolation(err) {
			c.JSON(http.StatusConflict, gin.H{"msg": "a subject with that name already exists"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not update subject"})
		return
	}
	c.JSON(http.StatusOK, toAPISubject(updated))
}

// DeleteSubject implements gen.ServerInterface. Deleting never cascades: a
// Subject any Class still selects returns 409 so the caller deselects it
// first. Downstream Exam Subject / Question / Answer tables do not exist yet;
// when they do, their reference counts belong in this same check.
func (s *Service) DeleteSubject(c *gin.Context, subjectID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsSubject(c, subjectID, uid) {
		return
	}
	uses, err := s.store.CountClassSubjectsBySubject(c.Request.Context(), subjectID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not check subject usage"})
		return
	}
	if uses > 0 {
		c.JSON(http.StatusConflict, gin.H{"msg": "subject is still selected by one or more classes"})
		return
	}
	if err := s.store.DeleteSubject(c.Request.Context(), subjectID); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not delete subject"})
		return
	}
	c.Status(http.StatusNoContent)
}

// ownsSubject verifies the requesting user owns the given Subject, writing a
// 404 (never a 403 — the existence of another User's Subject is not disclosed)
// on either a missing Subject or an ownership mismatch.
func (s *Service) ownsSubject(c *gin.Context, subjectID, uid uuid.UUID) bool {
	subject, err := s.store.GetSubjectByID(c.Request.Context(), subjectID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load subject"})
			return false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "subject not found"})
		return false
	}
	if subject.OwnerID != uid {
		c.JSON(http.StatusNotFound, gin.H{"msg": "subject not found"})
		return false
	}
	return true
}

func isUniqueViolation(err error) bool {
	var pgErr *pgconn.PgError
	return errors.As(err, &pgErr) && pgErr.Code == pgerrcode.UniqueViolation
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
