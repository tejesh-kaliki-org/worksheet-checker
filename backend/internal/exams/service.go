// Package exams implements the Exam and Exam Subject domains: a term-based
// assessment event belonging to a Class, and its per-Subject pairings (see
// CONTEXT.md). Each Exam Subject owns its own Question catalogue, which is
// implemented separately in internal/questions.
package exams

import (
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/jackc/pgerrcode"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"
	"github.com/jackc/pgx/v5/pgxpool"

	gen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/exams"
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

// userID reads the authenticated user id set by auth.ScopeAuth.
func userID(c *gin.Context) (uuid.UUID, bool) {
	raw := c.GetString("user_id")
	id, err := uuid.Parse(raw)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"msg": "missing or invalid bearer token"})
		return uuid.UUID{}, false
	}
	return id, true
}

// ListExams implements gen.ServerInterface.
func (s *Service) ListExams(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsClass(c, classID, uid) {
		return
	}
	list, err := s.store.ListExamsByClass(c.Request.Context(), classID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not list exams"})
		return
	}
	c.JSON(http.StatusOK, gen.ExamList{Exams: toAPIExams(list)})
}

// CreateExam implements gen.ServerInterface.
func (s *Service) CreateExam(c *gin.Context, classID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsClass(c, classID, uid) {
		return
	}
	var body gen.CreateExamJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"msg": err.Error()})
		return
	}
	if body.Label == "" {
		c.JSON(http.StatusBadRequest, gin.H{"msg": "label is required"})
		return
	}
	exam, err := s.store.CreateExam(c.Request.Context(), classID, body.Label)
	if err != nil {
		if isUniqueViolation(err) {
			c.JSON(http.StatusConflict, gin.H{"msg": "an exam with that label already exists in this class"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not create exam"})
		return
	}
	c.JSON(http.StatusCreated, toAPIExam(exam))
}

// GetExam implements gen.ServerInterface.
func (s *Service) GetExam(c *gin.Context, classID uuid.UUID, examID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownsClass(c, classID, uid) {
		return
	}
	exam, ok := s.scopedExam(c, classID, examID)
	if !ok {
		return
	}
	c.JSON(http.StatusOK, toAPIExam(exam))
}

// ListExamSubjects implements gen.ServerInterface.
func (s *Service) ListExamSubjects(c *gin.Context, examID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownedExam(c, examID, uid) {
		return
	}
	list, err := s.store.ListExamSubjectsByExam(c.Request.Context(), examID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not list exam subjects"})
		return
	}
	c.JSON(http.StatusOK, gen.ExamSubjectList{ExamSubjects: toAPIExamSubjects(list)})
}

// AddExamSubject implements gen.ServerInterface.
func (s *Service) AddExamSubject(c *gin.Context, examID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if !s.ownedExam(c, examID, uid) {
		return
	}
	var body gen.AddExamSubjectJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"msg": err.Error()})
		return
	}
	subject, err := s.store.GetSubjectByID(c.Request.Context(), body.SubjectId)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load subject"})
			return
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "subject not found"})
		return
	}
	// Subjects are a per-user catalogue (ADR 0009): a Subject owned by another
	// User must 404 here exactly as a missing one would — its existence is not
	// disclosed, and it must not be attachable to this User's Exam.
	if subject.OwnerID != uid {
		c.JSON(http.StatusNotFound, gin.H{"msg": "subject not found"})
		return
	}
	examSubject, err := s.store.AddExamSubject(c.Request.Context(), examID, body.SubjectId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not attach subject"})
		return
	}
	c.JSON(http.StatusCreated, toAPIExamSubject(examSubject))
}

// ownsClass verifies the requesting user owns the Class, writing a 404 (never
// a 403) on either a missing Class or an ownership mismatch — mirrors
// internal/classes.Service.ownedClass.
func (s *Service) ownsClass(c *gin.Context, classID, uid uuid.UUID) bool {
	class, err := s.store.GetClassByID(c.Request.Context(), classID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load class"})
			return false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "class not found"})
		return false
	}
	if class.CreatedBy != uid {
		c.JSON(http.StatusNotFound, gin.H{"msg": "class not found"})
		return false
	}
	return true
}

// scopedExam loads an Exam and verifies it belongs to the given Class.
func (s *Service) scopedExam(c *gin.Context, classID, examID uuid.UUID) (database.Exam, bool) {
	exam, err := s.store.GetExamByID(c.Request.Context(), examID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load exam"})
			return database.Exam{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "exam not found"})
		return database.Exam{}, false
	}
	if exam.ClassID != classID {
		c.JSON(http.StatusNotFound, gin.H{"msg": "exam not found"})
		return database.Exam{}, false
	}
	return exam, true
}

// ownedExam verifies the requesting user owns the Class of the Exam with the
// given id — used by routes scoped directly under /exams/{examId} rather than
// under a Class (see AddExamSubject/ListExamSubjects in api/services/exams.yaml).
func (s *Service) ownedExam(c *gin.Context, examID, uid uuid.UUID) bool {
	exam, err := s.store.GetExamByID(c.Request.Context(), examID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load exam"})
			return false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "exam not found"})
		return false
	}
	return s.ownsClass(c, exam.ClassID, uid)
}

func isUniqueViolation(err error) bool {
	var pgErr *pgconn.PgError
	return errors.As(err, &pgErr) && pgErr.Code == pgerrcode.UniqueViolation
}

func toAPIExam(e database.Exam) gen.Exam {
	return gen.Exam{
		Id:        e.ID,
		ClassId:   e.ClassID,
		Label:     e.Label,
		CreatedAt: e.CreatedAt,
	}
}

func toAPIExams(list []database.Exam) []gen.Exam {
	out := make([]gen.Exam, 0, len(list))
	for _, e := range list {
		out = append(out, toAPIExam(e))
	}
	return out
}

func toAPIExamSubject(es database.ExamSubject) gen.ExamSubject {
	return gen.ExamSubject{
		Id:        es.ID,
		ExamId:    es.ExamID,
		SubjectId: es.SubjectID,
	}
}

func toAPIExamSubjects(list []database.ExamSubject) []gen.ExamSubject {
	out := make([]gen.ExamSubject, 0, len(list))
	for _, es := range list {
		out = append(out, toAPIExamSubject(es))
	}
	return out
}
