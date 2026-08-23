// Package submissions implements the Submission and Answer domains: a
// Submission is one Student's complete set of Answers for one Exam Subject,
// created in bulk by the teacher (not entered by the student directly); an
// Answer is a single Student response to a single Question, belonging to a
// Submission (see CONTEXT.md).
package submissions

import (
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	gen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/submissions"
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
		c.JSON(http.StatusUnauthorized, gin.H{"error": "missing or invalid bearer token"})
		return uuid.UUID{}, false
	}
	return id, true
}

// ListSubmissions implements gen.ServerInterface.
func (s *Service) ListSubmissions(c *gin.Context, examSubjectID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, _, ok := s.ownedExamSubject(c, examSubjectID, uid); !ok {
		return
	}
	list, err := s.store.ListSubmissionsByExamSubject(c.Request.Context(), examSubjectID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not list submissions"})
		return
	}
	c.JSON(http.StatusOK, gen.SubmissionList{Submissions: toAPISubmissions(list)})
}

// BulkUploadSubmissions implements gen.ServerInterface. It upserts one
// Submission per Student and one Answer per Question within it, all scoped
// to the given Exam Subject. Re-uploading is idempotent: an existing
// Submission for the same Student is reused, and an existing Answer for the
// same Question is overwritten (see api/services/submissions.yaml).
func (s *Service) BulkUploadSubmissions(c *gin.Context, examSubjectID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	_, exam, ok := s.ownedExamSubject(c, examSubjectID, uid)
	if !ok {
		return
	}
	var body gen.BulkUploadSubmissionsJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Validate every Student belongs to the Exam's Class before writing
	// anything, so a bad row in a large bulk upload doesn't leave a partial
	// result behind.
	for _, studentInput := range body.Submissions {
		student, err := s.store.GetStudentByID(c.Request.Context(), studentInput.StudentId)
		if err != nil {
			if !errors.Is(err, pgx.ErrNoRows) {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load student"})
				return
			}
			c.JSON(http.StatusBadRequest, gin.H{"error": "unknown student: " + studentInput.StudentId.String()})
			return
		}
		if student.ClassID != exam.ClassID {
			c.JSON(http.StatusBadRequest, gin.H{"error": "student does not belong to this exam's class: " + studentInput.StudentId.String()})
			return
		}
		for _, answerInput := range studentInput.Answers {
			question, err := s.store.GetQuestionByID(c.Request.Context(), answerInput.QuestionId)
			if err != nil {
				if !errors.Is(err, pgx.ErrNoRows) {
					c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load question"})
					return
				}
				c.JSON(http.StatusBadRequest, gin.H{"error": "unknown question: " + answerInput.QuestionId.String()})
				return
			}
			if question.ExamSubjectID != examSubjectID {
				c.JSON(http.StatusBadRequest, gin.H{"error": "question does not belong to this exam subject: " + answerInput.QuestionId.String()})
				return
			}
		}
	}

	submissions := make([]database.Submission, 0, len(body.Submissions))
	for _, studentInput := range body.Submissions {
		submission, err := s.store.UpsertSubmission(c.Request.Context(), examSubjectID, studentInput.StudentId)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not create submission"})
			return
		}
		for _, answerInput := range studentInput.Answers {
			if _, err := s.store.UpsertAnswer(c.Request.Context(), database.UpsertAnswerParams{
				SubmissionID: submission.ID,
				QuestionID:   answerInput.QuestionId,
				RawAnswer:    answerInput.RawAnswer,
			}); err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "could not create answer"})
				return
			}
		}
		submissions = append(submissions, submission)
	}
	c.JSON(http.StatusOK, gen.SubmissionList{Submissions: toAPISubmissions(submissions)})
}

// ListAnswers implements gen.ServerInterface.
func (s *Service) ListAnswers(c *gin.Context, submissionID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedSubmission(c, submissionID, uid); !ok {
		return
	}
	list, err := s.store.ListAnswersBySubmission(c.Request.Context(), submissionID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not list answers"})
		return
	}
	c.JSON(http.StatusOK, gen.AnswerList{Answers: toAPIAnswers(list)})
}

// GetAnswer implements gen.ServerInterface.
func (s *Service) GetAnswer(c *gin.Context, submissionID uuid.UUID, answerID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedSubmission(c, submissionID, uid); !ok {
		return
	}
	answer, ok := s.scopedAnswer(c, submissionID, answerID)
	if !ok {
		return
	}
	c.JSON(http.StatusOK, toAPIAnswer(answer))
}

// UpdateAnswer implements gen.ServerInterface. This is the path by which a
// teacher corrects a mis-entered Answer after bulk upload.
func (s *Service) UpdateAnswer(c *gin.Context, submissionID uuid.UUID, answerID uuid.UUID) {
	uid, ok := userID(c)
	if !ok {
		return
	}
	if _, ok := s.ownedSubmission(c, submissionID, uid); !ok {
		return
	}
	if _, ok := s.scopedAnswer(c, submissionID, answerID); !ok {
		return
	}
	var body gen.UpdateAnswerJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	updated, err := s.store.UpdateAnswer(c.Request.Context(), answerID, body.RawAnswer)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not update answer"})
		return
	}
	c.JSON(http.StatusOK, toAPIAnswer(updated))
}

// ownedExamSubject verifies the requesting user owns the Class of the Exam
// Subject with the given id, walking Exam Subject -> Exam -> Class -> owner
// (see internal/questions for the identical pattern). It returns the loaded
// Exam Subject and Exam so callers needing them (e.g. bulk upload's Student
// Class check) don't have to reload them.
func (s *Service) ownedExamSubject(c *gin.Context, examSubjectID, uid uuid.UUID) (database.ExamSubject, database.Exam, bool) {
	examSubject, err := s.store.GetExamSubjectByID(c.Request.Context(), examSubjectID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load exam subject"})
			return database.ExamSubject{}, database.Exam{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "exam subject not found"})
		return database.ExamSubject{}, database.Exam{}, false
	}
	exam, err := s.store.GetExamByID(c.Request.Context(), examSubject.ExamID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load exam"})
			return database.ExamSubject{}, database.Exam{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "exam subject not found"})
		return database.ExamSubject{}, database.Exam{}, false
	}
	class, err := s.store.GetClassByID(c.Request.Context(), exam.ClassID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load class"})
			return database.ExamSubject{}, database.Exam{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "exam subject not found"})
		return database.ExamSubject{}, database.Exam{}, false
	}
	if class.CreatedBy != uid {
		c.JSON(http.StatusNotFound, gin.H{"error": "exam subject not found"})
		return database.ExamSubject{}, database.Exam{}, false
	}
	return examSubject, exam, true
}

// ownedSubmission loads a Submission and verifies the requesting user owns
// it, walking Submission -> Exam Subject -> Exam -> Class -> owner. Every
// failure along the chain -- including an exam subject that no longer
// resolves or belongs to someone else -- reports as "submission not found",
// so a 404 never hints at which link in the chain actually failed.
func (s *Service) ownedSubmission(c *gin.Context, submissionID, uid uuid.UUID) (database.Submission, bool) {
	submission, err := s.store.GetSubmissionByID(c.Request.Context(), submissionID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load submission"})
			return database.Submission{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "submission not found"})
		return database.Submission{}, false
	}
	examSubject, err := s.store.GetExamSubjectByID(c.Request.Context(), submission.ExamSubjectID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load exam subject"})
			return database.Submission{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "submission not found"})
		return database.Submission{}, false
	}
	exam, err := s.store.GetExamByID(c.Request.Context(), examSubject.ExamID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load exam"})
			return database.Submission{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "submission not found"})
		return database.Submission{}, false
	}
	class, err := s.store.GetClassByID(c.Request.Context(), exam.ClassID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load class"})
			return database.Submission{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "submission not found"})
		return database.Submission{}, false
	}
	if class.CreatedBy != uid {
		c.JSON(http.StatusNotFound, gin.H{"error": "submission not found"})
		return database.Submission{}, false
	}
	return submission, true
}

// scopedAnswer loads an Answer and verifies it belongs to the given
// Submission.
func (s *Service) scopedAnswer(c *gin.Context, submissionID, answerID uuid.UUID) (database.Answer, bool) {
	answer, err := s.store.GetAnswerByID(c.Request.Context(), answerID)
	if err != nil {
		if !errors.Is(err, pgx.ErrNoRows) {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "could not load answer"})
			return database.Answer{}, false
		}
		c.JSON(http.StatusNotFound, gin.H{"error": "answer not found"})
		return database.Answer{}, false
	}
	if answer.SubmissionID != submissionID {
		c.JSON(http.StatusNotFound, gin.H{"error": "answer not found"})
		return database.Answer{}, false
	}
	return answer, true
}

func toAPISubmission(sub database.Submission) gen.Submission {
	return gen.Submission{
		Id:            sub.ID,
		ExamSubjectId: sub.ExamSubjectID,
		StudentId:     sub.StudentID,
	}
}

func toAPISubmissions(list []database.Submission) []gen.Submission {
	out := make([]gen.Submission, 0, len(list))
	for _, sub := range list {
		out = append(out, toAPISubmission(sub))
	}
	return out
}

func toAPIAnswer(a database.Answer) gen.Answer {
	return gen.Answer{
		Id:           a.ID,
		SubmissionId: a.SubmissionID,
		QuestionId:   a.QuestionID,
		RawAnswer:    a.RawAnswer,
	}
}

func toAPIAnswers(list []database.Answer) []gen.Answer {
	out := make([]gen.Answer, 0, len(list))
	for _, a := range list {
		out = append(out, toAPIAnswer(a))
	}
	return out
}
