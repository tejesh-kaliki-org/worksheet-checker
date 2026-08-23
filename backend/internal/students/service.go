// Package students implements the Student domain: a minimal identity record
// (name + Roll Number) scoped to a single Class (see CONTEXT.md and ADR 0002
// — no cross-class identity; a Student in two Classes is two unrelated
// records).
package students

import (
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"
	"github.com/jackc/pgx/v5/pgxpool"

	gen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/students"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

// uniqueViolation is Postgres' SQLSTATE for a unique constraint violation
// (used here for the (class_id, roll_number) uniqueness constraint).
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
// operation in this domain requires it (all are `security: bearerAuth`).
func userID(c *gin.Context) (uuid.UUID, bool) {
	raw := c.GetString("user_id")
	id, err := uuid.Parse(raw)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "missing or invalid bearer token"})
		return uuid.UUID{}, false
	}
	return id, true
}

// ListStudents implements gen.ServerInterface.
func (s *Service) ListStudents(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsClass(c, classID, uid) {
		return
	}
	list, err := s.store.ListStudentsByClass(c.Request.Context(), classID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not list students"})
		return
	}
	c.JSON(http.StatusOK, gen.StudentList{Students: toAPIStudents(list)})
}

// CreateStudent implements gen.ServerInterface.
func (s *Service) CreateStudent(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsClass(c, classID, uid) {
		return
	}
	var body gen.CreateStudentJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if body.Name == "" || body.RollNumber == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "name and roll_number are required"})
		return
	}
	student, err := s.store.CreateStudent(c.Request.Context(), database.CreateStudentParams{
		ClassID:    classID,
		Name:       body.Name,
		RollNumber: body.RollNumber,
	})
	if err != nil {
		if isUniqueViolation(err) {
			c.JSON(http.StatusConflict, gin.H{"error": "roll_number already used in this class"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not create student"})
		return
	}
	c.JSON(http.StatusCreated, toAPIStudent(student))
}

// GetStudent implements gen.ServerInterface.
func (s *Service) GetStudent(c *gin.Context, classID uuid.UUID, studentID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsClass(c, classID, uid) {
		return
	}
	student, ok := s.scopedStudent(c, classID, studentID)
	if !ok {
		return
	}
	c.JSON(http.StatusOK, toAPIStudent(student))
}

// UpdateStudent implements gen.ServerInterface.
func (s *Service) UpdateStudent(c *gin.Context, classID uuid.UUID, studentID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsClass(c, classID, uid) {
		return
	}
	if _, ok := s.scopedStudent(c, classID, studentID); !ok {
		return
	}
	var body gen.UpdateStudentJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if body.Name == "" || body.RollNumber == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "name and roll_number are required"})
		return
	}
	updated, err := s.store.UpdateStudent(c.Request.Context(), database.UpdateStudentParams{
		ID:         studentID,
		Name:       body.Name,
		RollNumber: body.RollNumber,
	})
	if err != nil {
		if isUniqueViolation(err) {
			c.JSON(http.StatusConflict, gin.H{"error": "roll_number already used in this class"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not update student"})
		return
	}
	c.JSON(http.StatusOK, toAPIStudent(updated))
}

// DeleteStudent implements gen.ServerInterface.
func (s *Service) DeleteStudent(c *gin.Context, classID uuid.UUID, studentID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsClass(c, classID, uid) {
		return
	}
	if _, ok := s.scopedStudent(c, classID, studentID); !ok {
		return
	}
	if err := s.store.DeleteStudent(c.Request.Context(), studentID); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not delete student"})
		return
	}
	c.Status(http.StatusNoContent)
}

// ownsClass verifies the requesting user owns the Class, writing a 404 (never
// a 403) on either a missing Class or an ownership mismatch — mirrors
// internal/classes.Service.ownedClass.
func (s *Service) ownsClass(c *gin.Context, classID, uid uuid.UUID) bool {
	class, err := s.store.GetClassByID(c.Request.Context(), classID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load class"})
			return false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "class not found"})
		return false
	}
	if class.CreatedBy != uid {
		c.JSON(http.StatusNotFound, gin.H{"error": "class not found"})
		return false
	}
	return true
}

// scopedStudent loads a Student and verifies it belongs to the given Class.
func (s *Service) scopedStudent(c *gin.Context, classID, studentID uuid.UUID) (database.Student, bool) {
	student, err := s.store.GetStudentByID(c.Request.Context(), studentID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load student"})
			return database.Student{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "student not found"})
		return database.Student{}, false
	}
	if student.ClassID != classID {
		c.JSON(http.StatusNotFound, gin.H{"error": "student not found"})
		return database.Student{}, false
	}
	return student, true
}

func isUniqueViolation(err error) bool {
	var pgErr *pgconn.PgError
	return errors.As(err, &pgErr) && pgErr.Code == uniqueViolation
}

func toAPIStudent(st database.Student) gen.Student {
	return gen.Student{
		Id:         st.ID,
		ClassId:    st.ClassID,
		Name:       st.Name,
		RollNumber: st.RollNumber,
	}
}

func toAPIStudents(list []database.Student) []gen.Student {
	out := make([]gen.Student, 0, len(list))
	for _, st := range list {
		out = append(out, toAPIStudent(st))
	}
	return out
}
