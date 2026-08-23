// Package questions implements the Question domain: a single graded item
// within an Exam Subject, with a Question Type, a type-specific Config, and
// a Maximum Marks value (see CONTEXT.md and ADR 0003 — Questions are scoped
// directly to their Exam Subject, never reused across Exams).
//
// All reads/writes of the stored `config` JSONB go through
// internal/questionconfig — this package never touches the column's bytes
// except by handing them to that package's Marshal/Unmarshal.
package questions

import (
	"encoding/json"
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	gen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/questions"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/questionconfig"
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
		c.JSON(http.StatusUnauthorized, gin.H{"error": "missing or invalid bearer token"})
		return uuid.UUID{}, false
	}
	return id, true
}

// ListQuestions implements gen.ServerInterface.
func (s *Service) ListQuestions(c *gin.Context, examSubjectID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedExamSubject(c, examSubjectID, uid); !ok {
		return
	}
	list, err := s.store.ListQuestionsByExamSubject(c.Request.Context(), examSubjectID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not list questions"})
		return
	}
	out, err := toAPIQuestions(list)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not decode stored questions"})
		return
	}
	c.JSON(http.StatusOK, gen.QuestionList{Questions: out})
}

// CreateQuestion implements gen.ServerInterface.
func (s *Service) CreateQuestion(c *gin.Context, examSubjectID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedExamSubject(c, examSubjectID, uid); !ok {
		return
	}
	var body gen.CreateQuestionJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	_, configBytes, err := decodeConfig(body.Type, body.Config)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	marks, err := numericFromFloat64(body.MaximumMarks)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	question, err := s.store.CreateQuestion(c.Request.Context(), database.CreateQuestionParams{
		ExamSubjectID: examSubjectID,
		Type:          database.QuestionType(body.Type),
		Config:        configBytes,
		SchemaVersion: questionconfig.CurrentSchemaVersion,
		MaximumMarks:  marks,
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not create question"})
		return
	}
	out, err := toAPIQuestion(question)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not decode stored question"})
		return
	}
	c.JSON(http.StatusCreated, out)
}

// GetQuestion implements gen.ServerInterface.
func (s *Service) GetQuestion(c *gin.Context, examSubjectID uuid.UUID, questionID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedExamSubject(c, examSubjectID, uid); !ok {
		return
	}
	question, ok := s.scopedQuestion(c, examSubjectID, questionID)
	if !ok {
		return
	}
	out, err := toAPIQuestion(question)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not decode stored question"})
		return
	}
	c.JSON(http.StatusOK, out)
}

// UpdateQuestion implements gen.ServerInterface.
func (s *Service) UpdateQuestion(c *gin.Context, examSubjectID uuid.UUID, questionID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedExamSubject(c, examSubjectID, uid); !ok {
		return
	}
	if _, ok := s.scopedQuestion(c, examSubjectID, questionID); !ok {
		return
	}
	var body gen.UpdateQuestionJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	_, configBytes, err := decodeConfig(body.Type, body.Config)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	marks, err := numericFromFloat64(body.MaximumMarks)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	updated, err := s.store.UpdateQuestion(c.Request.Context(), database.UpdateQuestionParams{
		ID:            questionID,
		Type:          database.QuestionType(body.Type),
		Config:        configBytes,
		SchemaVersion: questionconfig.CurrentSchemaVersion,
		MaximumMarks:  marks,
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not update question"})
		return
	}
	out, err := toAPIQuestion(updated)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not decode stored question"})
		return
	}
	c.JSON(http.StatusOK, out)
}

// DeleteQuestion implements gen.ServerInterface.
func (s *Service) DeleteQuestion(c *gin.Context, examSubjectID uuid.UUID, questionID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedExamSubject(c, examSubjectID, uid); !ok {
		return
	}
	if _, ok := s.scopedQuestion(c, examSubjectID, questionID); !ok {
		return
	}
	if err := s.store.DeleteQuestion(c.Request.Context(), questionID); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not delete question"})
		return
	}
	c.Status(http.StatusNoContent)
}

// decodeConfig re-encodes the request body's generic `config` map to JSON and
// hands it to internal/questionconfig for type-specific decoding and
// validation — the only path by which request config reaches storage.
func decodeConfig(qType gen.QuestionType, raw map[string]interface{}) (questionconfig.Config, []byte, error) {
	buf, err := json.Marshal(raw)
	if err != nil {
		return nil, nil, err
	}
	cfg, err := questionconfig.Unmarshal(questionconfig.Type(qType), buf)
	if err != nil {
		return nil, nil, err
	}
	// Re-marshal through the boundary so the stored bytes are always the
	// canonical shape Marshal produces, not whatever the client happened to send.
	canonical, err := questionconfig.Marshal(cfg)
	if err != nil {
		return nil, nil, err
	}
	return cfg, canonical, nil
}

// ownedExamSubject loads an Exam Subject and verifies the requesting user
// owns its Exam's Class, walking Exam Subject -> Exam -> Class -> owner.
func (s *Service) ownedExamSubject(c *gin.Context, examSubjectID, uid uuid.UUID) (database.ExamSubject, bool) {
	examSubject, err := s.store.GetExamSubjectByID(c.Request.Context(), examSubjectID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load exam subject"})
			return database.ExamSubject{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "exam subject not found"})
		return database.ExamSubject{}, false
	}
	exam, err := s.store.GetExamByID(c.Request.Context(), examSubject.ExamID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load exam"})
			return database.ExamSubject{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "exam subject not found"})
		return database.ExamSubject{}, false
	}
	class, err := s.store.GetClassByID(c.Request.Context(), exam.ClassID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load class"})
			return database.ExamSubject{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "exam subject not found"})
		return database.ExamSubject{}, false
	}
	if class.CreatedBy != uid {
		c.JSON(http.StatusNotFound, gin.H{"error": "exam subject not found"})
		return database.ExamSubject{}, false
	}
	return examSubject, true
}

// scopedQuestion loads a Question and verifies it belongs to the given Exam
// Subject.
func (s *Service) scopedQuestion(c *gin.Context, examSubjectID, questionID uuid.UUID) (database.Question, bool) {
	question, err := s.store.GetQuestionByID(c.Request.Context(), questionID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load question"})
			return database.Question{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "question not found"})
		return database.Question{}, false
	}
	if question.ExamSubjectID != examSubjectID {
		c.JSON(http.StatusNotFound, gin.H{"error": "question not found"})
		return database.Question{}, false
	}
	return question, true
}

func toAPIQuestion(q database.Question) (gen.Question, error) {
	cfg, err := questionconfig.Unmarshal(questionconfig.Type(q.Type), q.Config)
	if err != nil {
		return gen.Question{}, err
	}
	canonical, err := questionconfig.Marshal(cfg)
	if err != nil {
		return gen.Question{}, err
	}
	var configMap map[string]interface{}
	if err := json.Unmarshal(canonical, &configMap); err != nil {
		return gen.Question{}, err
	}
	marks, err := float64FromNumeric(q.MaximumMarks)
	if err != nil {
		return gen.Question{}, err
	}
	return gen.Question{
		Id:            q.ID,
		ExamSubjectId: q.ExamSubjectID,
		Type:          gen.QuestionType(q.Type),
		Config:        configMap,
		SchemaVersion: int(q.SchemaVersion),
		MaximumMarks:  marks,
	}, nil
}

func toAPIQuestions(list []database.Question) ([]gen.Question, error) {
	out := make([]gen.Question, 0, len(list))
	for _, q := range list {
		apiQ, err := toAPIQuestion(q)
		if err != nil {
			return nil, err
		}
		out = append(out, apiQ)
	}
	return out, nil
}
