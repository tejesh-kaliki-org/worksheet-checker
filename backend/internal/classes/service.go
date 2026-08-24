// Package classes implements the Class domain: a group of Students created and
// owned by exactly one User (see CONTEXT.md and ADR 0001 — no organizational
// hierarchy above a Class, single owner only). It also owns Class-Subject
// selection (which catalogue Subjects apply to a Class).
package classes

import (
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	gen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/classes"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

type Service struct {
	store Store
}

func New(pool *pgxpool.Pool) *Service {
	return &Service{store: NewStore(pool)}
}

// Register mounts the generated routes under the given router group.
// middlewares typically includes the auth ScopeAuth so `security: bearerAuth`
// in the spec is enforced (see internal/auth/middleware.go).
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

// ListClasses implements gen.ServerInterface.
func (s *Service) ListClasses(c *gin.Context) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	list, err := s.store.ListClassesByOwner(c.Request.Context(), uid)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not list classes"})
		return
	}
	c.JSON(http.StatusOK, gen.ClassList{Classes: toAPIClasses(list)})
}

// CreateClass implements gen.ServerInterface.
func (s *Service) CreateClass(c *gin.Context) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	var body gen.CreateClassJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if body.Name == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "name is required"})
		return
	}
	class, err := s.store.CreateClass(c.Request.Context(), body.Name, uid)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not create class"})
		return
	}
	c.JSON(http.StatusCreated, toAPIClass(class))
}

// GetClass implements gen.ServerInterface.
func (s *Service) GetClass(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	class, ok := s.ownedClass(c, classID, uid)
	if !ok {
		return
	}
	c.JSON(http.StatusOK, toAPIClass(class))
}

// UpdateClass implements gen.ServerInterface.
func (s *Service) UpdateClass(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedClass(c, classID, uid); !ok {
		return
	}
	var body gen.UpdateClassJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if body.Name == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "name is required"})
		return
	}
	updated, err := s.store.UpdateClass(c.Request.Context(), classID, body.Name)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not update class"})
		return
	}
	c.JSON(http.StatusOK, toAPIClass(updated))
}

// DeleteClass implements gen.ServerInterface.
func (s *Service) DeleteClass(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedClass(c, classID, uid); !ok {
		return
	}
	if err := s.store.DeleteClass(c.Request.Context(), classID); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not delete class"})
		return
	}
	c.Status(http.StatusNoContent)
}

// ListClassSubjects implements gen.ServerInterface.
func (s *Service) ListClassSubjects(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedClass(c, classID, uid); !ok {
		return
	}
	list, err := s.store.ListSubjectsByClass(c.Request.Context(), classID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not list subjects"})
		return
	}
	c.JSON(http.StatusOK, gen.SubjectList{Subjects: toAPISubjects(list)})
}

// AddClassSubject implements gen.ServerInterface.
func (s *Service) AddClassSubject(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedClass(c, classID, uid); !ok {
		return
	}
	var body gen.AddClassSubjectJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	subject, err := s.store.GetSubjectByID(c.Request.Context(), body.SubjectId)
	if err != nil || subject.OwnerID != uid {
		c.JSON(http.StatusNotFound, gin.H{"error": "subject not found"})
		return
	}
	if _, err := s.store.AddClassSubject(c.Request.Context(), classID, body.SubjectId); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not select subject"})
		return
	}
	list, err := s.store.ListSubjectsByClass(c.Request.Context(), classID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not list subjects"})
		return
	}
	c.JSON(http.StatusCreated, gen.SubjectList{Subjects: toAPISubjects(list)})
}

// RemoveClassSubject implements gen.ServerInterface.
func (s *Service) RemoveClassSubject(c *gin.Context, classID uuid.UUID, subjectID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedClass(c, classID, uid); !ok {
		return
	}
	if err := s.store.RemoveClassSubject(c.Request.Context(), classID, subjectID); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not remove subject"})
		return
	}
	c.Status(http.StatusNoContent)
}

// ownedClass loads a Class and verifies the requesting user owns it, writing
// a 404 (never a 403 — existence of another teacher's Class is not
// disclosed) on either a missing Class or an ownership mismatch.
func (s *Service) ownedClass(c *gin.Context, classID, uid uuid.UUID) (database.Class, bool) {
	class, err := s.store.GetClassByID(c.Request.Context(), classID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load class"})
			return database.Class{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "class not found"})
		return database.Class{}, false
	}
	if class.CreatedBy != uid {
		c.JSON(http.StatusNotFound, gin.H{"error": "class not found"})
		return database.Class{}, false
	}
	return class, true
}

func toAPIClass(cl database.Class) gen.Class {
	return gen.Class{
		Id:        cl.ID,
		Name:      cl.Name,
		CreatedBy: cl.CreatedBy,
		CreatedAt: cl.CreatedAt,
	}
}

func toAPIClasses(list []database.Class) []gen.Class {
	out := make([]gen.Class, 0, len(list))
	for _, cl := range list {
		out = append(out, toAPIClass(cl))
	}
	return out
}

func toAPISubject(sub database.Subject) gen.Subject {
	return gen.Subject{Id: sub.ID, Name: sub.Name}
}

func toAPISubjects(list []database.Subject) []gen.Subject {
	out := make([]gen.Subject, 0, len(list))
	for _, sub := range list {
		out = append(out, toAPISubject(sub))
	}
	return out
}
