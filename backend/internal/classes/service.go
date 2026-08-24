// Package classes implements the Class domain: a group of Students created and
// owned by exactly one User (see CONTEXT.md and ADR 0001 — no organizational
// hierarchy above a Class, single owner only). It also owns Class-Subject
// selection (which catalogue Subjects apply to a Class).
package classes

import (
	"errors"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"
	"github.com/jackc/pgx/v5/pgxpool"

	gen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/classes"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// uniqueViolation is Postgres' SQLSTATE for a unique constraint violation
// (here: the classes (created_by, name) constraint added in
// sql/schema/0009_classes_unique_name.sql). Surfaced as 409, matching how
// internal/students reports a duplicate Roll Number.
const uniqueViolation = "23505"

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
		c.JSON(http.StatusUnauthorized, gin.H{"msg": "missing or invalid bearer token"})
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
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not list classes"})
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
		c.JSON(http.StatusBadRequest, gin.H{"msg": err.Error()})
		return
	}
	name := strings.TrimSpace(body.Name)
	if name == "" {
		c.JSON(http.StatusBadRequest, gin.H{"msg": "name is required"})
		return
	}
	class, err := s.store.CreateClass(c.Request.Context(), name, uid)
	if err != nil {
		if isUniqueViolation(err) {
			c.JSON(http.StatusConflict, gin.H{"msg": "you already have a class with that name"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not create class"})
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
		c.JSON(http.StatusBadRequest, gin.H{"msg": err.Error()})
		return
	}
	name := strings.TrimSpace(body.Name)
	if name == "" {
		c.JSON(http.StatusBadRequest, gin.H{"msg": "name is required"})
		return
	}
	updated, err := s.store.UpdateClass(c.Request.Context(), classID, name)
	if err != nil {
		if isUniqueViolation(err) {
			c.JSON(http.StatusConflict, gin.H{"msg": "you already have a class with that name"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not update class"})
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
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not delete class"})
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
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not list subjects"})
		return
	}
	c.JSON(http.StatusOK, gen.SubjectList{Subjects: toAPISubjects(list)})
}

// BulkSelectClassSubjects implements gen.ServerInterface. This is the single
// path for selecting Subjects on a Class: the whole selection is submitted at
// once. It is additive and idempotent — already-selected Subjects are left
// alone. There is deliberately no single-Subject add endpoint; a one-element
// list covers that case, so there is only one code path to own.
func (s *Service) BulkSelectClassSubjects(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedClass(c, classID, uid); !ok {
		return
	}
	var body gen.BulkSelectClassSubjectsJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"msg": err.Error()})
		return
	}
	if len(body.SubjectIds) == 0 {
		c.JSON(http.StatusBadRequest, gin.H{"msg": "subject_ids must not be empty"})
		return
	}
	if !s.allSubjectsOwned(c, body.SubjectIds, uid) {
		return
	}
	if err := s.store.BulkAddClassSubjects(c.Request.Context(), classID, body.SubjectIds); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not select subjects"})
		return
	}
	list, err := s.store.ListSubjectsByClass(c.Request.Context(), classID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not list subjects"})
		return
	}
	c.JSON(http.StatusCreated, gen.SubjectList{Subjects: toAPISubjects(list)})
}

// allSubjectsOwned verifies every requested Subject is in the caller's own
// catalogue, writing a 404 (never 403) if any is missing or foreign — so a
// partially valid request selects nothing.
func (s *Service) allSubjectsOwned(c *gin.Context, ids []uuid.UUID, uid uuid.UUID) bool {
	unique := make(map[uuid.UUID]struct{}, len(ids))
	for _, id := range ids {
		unique[id] = struct{}{}
	}
	found, err := s.store.CountOwnedSubjectsByIDs(c.Request.Context(), uid, ids)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load subjects"})
		return false
	}
	if found != int64(len(unique)) {
		c.JSON(http.StatusNotFound, gin.H{"msg": "subject not found"})
		return false
	}
	return true
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
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not remove subject"})
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
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load class"})
			return database.Class{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "class not found"})
		return database.Class{}, false
	}
	if class.CreatedBy != uid {
		c.JSON(http.StatusNotFound, gin.H{"msg": "class not found"})
		return database.Class{}, false
	}
	return class, true
}

func isUniqueViolation(err error) bool {
	var pgErr *pgconn.PgError
	return errors.As(err, &pgErr) && pgErr.Code == uniqueViolation
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
