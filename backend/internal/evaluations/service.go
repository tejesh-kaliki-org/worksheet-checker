package evaluations

import (
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/oapi-codegen/nullable"

	gen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/evaluations"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/bifrost"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/config"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
)

type Service struct {
	store   Store
	bifrost *bifrost.Client
}

func New(pool *pgxpool.Pool, cfg config.BifrostConfig) *Service {
	return &Service{store: NewStore(pool), bifrost: bifrost.New(cfg)}
}

// Register mounts the generated routes under the given router group.
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

// CreateEvaluationAttempt implements gen.ServerInterface. It runs the
// grading pipeline synchronously for this issue's scope: it mints the
// Attempt (whose id doubles as the Correlation ID, see
// sql/schema/0015_evaluation_attempts.sql), calls Bifrost through
// internal/bifrost, and persists the resulting Evaluation (or the failure)
// before responding.
func (s *Service) CreateEvaluationAttempt(c *gin.Context, answerID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	answer, ok := s.ownedAnswer(c, answerID, uid)
	if !ok {
		return
	}

	purpose := database.EvaluationPurposeScoring
	var body gen.CreateEvaluationAttemptJSONRequestBody
	if c.Request.ContentLength > 0 {
		if err := c.ShouldBindJSON(&body); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"msg": err.Error()})
			return
		}
		if body.Purpose != nil {
			purpose = database.EvaluationPurpose(*body.Purpose)
		}
	}

	question, err := s.store.GetQuestionByID(c.Request.Context(), answer.QuestionID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load question"})
		return
	}

	attempt, err := s.store.CreateEvaluationAttempt(c.Request.Context(), answerID, purpose)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not create evaluation attempt"})
		return
	}

	attempt, evaluation, ok := s.runAttempt(c, attempt, question, answer)
	if !ok {
		return
	}
	c.JSON(http.StatusOK, toAPIAttempt(attempt, evaluation))
}

// runAttempt drives one Evaluation Attempt to a terminal state: it grades
// the Answer via Bifrost (the Attempt's own id is the Correlation ID passed
// across that boundary -- never the Student's name or Roll Number, neither
// of which this package even loads), logs the LLM Call, and persists either
// the resulting Evaluation or the failure on the Attempt. It always returns
// the Attempt's latest state (the caller's copy is stale as soon as a status
// update lands); ok is false only if a response was already written for an
// unrecoverable error.
func (s *Service) runAttempt(c *gin.Context, attempt database.EvaluationAttempt, question database.Question, answer database.Answer) (database.EvaluationAttempt, *database.Evaluation, bool) {
	ctx := c.Request.Context()

	result, gradeErr := grade(ctx, s.bifrost, attempt.ID, question, answer)
	if gradeErr != nil {
		msg := gradeErr.Error()
		updated, err := s.store.UpdateEvaluationAttemptStatus(ctx, database.UpdateEvaluationAttemptStatusParams{
			ID: attempt.ID, Status: database.EvaluationAttemptStatusFailed, Error: &msg,
		})
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not record evaluation failure"})
			return attempt, nil, false
		}
		return updated, nil, true
	}

	if _, err := s.store.CreateLLMCall(ctx, database.CreateLLMCallParams{
		EvaluationAttemptID: attempt.ID,
		CorrelationID:       attempt.ID,
		Model:               result.model,
		TokensIn:            result.tokensIn,
		TokensOut:           result.tokensOut,
		LatencyMs:           result.latencyMs,
	}); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not log llm call"})
		return attempt, nil, false
	}

	maxMarks, err := float64FromNumeric(question.MaximumMarks)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not read maximum marks"})
		return attempt, nil, false
	}
	marksFloat := result.grade.RawScore * maxMarks
	rawScoreNum, err := numericFromFloat64(result.grade.RawScore)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not encode raw score"})
		return attempt, nil, false
	}
	marksNum, err := numericFromFloat64(marksFloat)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not encode marks"})
		return attempt, nil, false
	}

	evaluation, err := s.store.CreateEvaluation(ctx, database.CreateEvaluationParams{
		EvaluationAttemptID: attempt.ID,
		RawScore:            rawScoreNum,
		Marks:               marksNum,
		Feedback:            result.grade.Feedback,
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not save evaluation"})
		return attempt, nil, false
	}

	updated, err := s.store.UpdateEvaluationAttemptStatus(ctx, database.UpdateEvaluationAttemptStatusParams{
		ID: attempt.ID, Status: database.EvaluationAttemptStatusSucceeded, Error: nil,
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not finalize evaluation attempt"})
		return attempt, nil, false
	}
	return updated, &evaluation, true
}

// ListEvaluationAttempts implements gen.ServerInterface.
func (s *Service) ListEvaluationAttempts(c *gin.Context, answerID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedAnswer(c, answerID, uid); !ok {
		return
	}
	attempts, err := s.store.ListEvaluationAttemptsByAnswer(c.Request.Context(), answerID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not list evaluation attempts"})
		return
	}
	out := make([]gen.EvaluationAttempt, 0, len(attempts))
	for _, a := range attempts {
		var eval *database.Evaluation
		if a.Status == database.EvaluationAttemptStatusSucceeded {
			e, err := s.store.GetEvaluationByAttemptID(c.Request.Context(), a.ID)
			if err != nil && !errors.Is(err, pgx.ErrNoRows) {
				c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load evaluation"})
				return
			}
			if err == nil {
				eval = &e
			}
		}
		out = append(out, toAPIAttempt(a, eval))
	}
	c.JSON(http.StatusOK, gen.EvaluationAttemptList{EvaluationAttempts: out})
}

// GetEvaluationAttempt implements gen.ServerInterface.
func (s *Service) GetEvaluationAttempt(c *gin.Context, answerID uuid.UUID, attemptID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedAnswer(c, answerID, uid); !ok {
		return
	}
	attempt, err := s.store.GetEvaluationAttemptByID(c.Request.Context(), attemptID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load evaluation attempt"})
			return
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "evaluation attempt not found"})
		return
	}
	if attempt.AnswerID != answerID {
		c.JSON(http.StatusNotFound, gin.H{"msg": "evaluation attempt not found"})
		return
	}

	var eval *database.Evaluation
	if attempt.Status == database.EvaluationAttemptStatusSucceeded {
		e, err := s.store.GetEvaluationByAttemptID(c.Request.Context(), attempt.ID)
		if err != nil && !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load evaluation"})
			return
		}
		if err == nil {
			eval = &e
		}
	}
	c.JSON(http.StatusOK, toAPIAttempt(attempt, eval))
}

// ownedAnswer loads an Answer and verifies the requesting user owns it,
// walking Answer -> Submission -> Exam Subject -> Exam -> Class -> owner.
// Every failure along the chain reports as "answer not found" (never 403),
// so a 404 never hints at which link in the chain actually failed (see
// internal/submissions/service.go's ownedSubmission for the reference
// implementation of this pattern).
func (s *Service) ownedAnswer(c *gin.Context, answerID, uid uuid.UUID) (database.Answer, bool) {
	answer, err := s.store.GetAnswerByID(c.Request.Context(), answerID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load answer"})
			return database.Answer{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "answer not found"})
		return database.Answer{}, false
	}
	submission, err := s.store.GetSubmissionByID(c.Request.Context(), answer.SubmissionID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load submission"})
			return database.Answer{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "answer not found"})
		return database.Answer{}, false
	}
	examSubject, err := s.store.GetExamSubjectByID(c.Request.Context(), submission.ExamSubjectID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load exam subject"})
			return database.Answer{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "answer not found"})
		return database.Answer{}, false
	}
	exam, err := s.store.GetExamByID(c.Request.Context(), examSubject.ExamID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load exam"})
			return database.Answer{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "answer not found"})
		return database.Answer{}, false
	}
	class, err := s.store.GetClassByID(c.Request.Context(), exam.ClassID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"msg": "could not load class"})
			return database.Answer{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"msg": "answer not found"})
		return database.Answer{}, false
	}
	if class.CreatedBy != uid {
		c.JSON(http.StatusNotFound, gin.H{"msg": "answer not found"})
		return database.Answer{}, false
	}
	return answer, true
}

func toAPIAttempt(a database.EvaluationAttempt, eval *database.Evaluation) gen.EvaluationAttempt {
	out := gen.EvaluationAttempt{
		Id:       a.ID,
		AnswerId: a.AnswerID,
		Status:   gen.EvaluationAttemptStatus(a.Status),
		Purpose:  gen.EvaluationPurpose(a.Purpose),
	}
	if a.Error != nil {
		out.Error = nullable.NewNullableWithValue(*a.Error)
	}
	if eval != nil {
		out.Evaluation = nullable.NewNullableWithValue(toAPIEvaluation(*eval))
	}
	return out
}

func toAPIEvaluation(e database.Evaluation) gen.Evaluation {
	rawScore, _ := float64FromNumeric(e.RawScore)
	marks, _ := float64FromNumeric(e.Marks)
	return gen.Evaluation{
		Id:                  e.ID,
		EvaluationAttemptId: e.EvaluationAttemptID,
		RawScore:            rawScore,
		Marks:               marks,
		Feedback:            e.Feedback,
	}
}
