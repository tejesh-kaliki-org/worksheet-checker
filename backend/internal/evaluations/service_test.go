package evaluations_test

import (
	"net/http"
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

func TestCreateEvaluationAttempt(t *testing.T) {
	t.Run("success grades the answer and persists an Evaluation", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@e.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)
		questionID := createQuestion(t, token, examSubjectID)
		answerID := createAnswer(t, token, examSubjectID, studentID, questionID, "42")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/answers/"+answerID+"/evaluation-attempts", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["status"] != "succeeded" {
			t.Fatalf("status field = %v, want succeeded (%s)", body["status"], w.Body.String())
		}
		if body["purpose"] != "scoring" {
			t.Fatalf("purpose field = %v, want scoring (default)", body["purpose"])
		}
		eval, ok := body["evaluation"].(map[string]any)
		if !ok {
			t.Fatalf("expected evaluation in response, got %s", w.Body.String())
		}
		if eval["raw_score"].(float64) != 0.75 {
			t.Fatalf("raw_score = %v, want 0.75", eval["raw_score"])
		}
		if eval["marks"].(float64) != 3 {
			t.Fatalf("marks = %v, want 3 (0.75 * maximum_marks 4)", eval["marks"])
		}
		if eval["feedback"] != "Mostly correct." {
			t.Fatalf("feedback = %v", eval["feedback"])
		}
	})

	t.Run("bifrost failure records a failed attempt, not a 500", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@e.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)
		questionID := createQuestion(t, token, examSubjectID)
		answerID := createAnswer(t, token, examSubjectID, studentID, questionID, "42")

		bifrostHandler = func(w http.ResponseWriter, r *http.Request) {
			http.Error(w, "boom", http.StatusInternalServerError)
		}

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/answers/"+answerID+"/evaluation-attempts", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["status"] != "failed" {
			t.Fatalf("status field = %v, want failed (%s)", body["status"], w.Body.String())
		}
		if body["error"] == nil || body["error"] == "" {
			t.Fatalf("expected a non-empty error message, got %v", body["error"])
		}
		if _, ok := body["evaluation"]; ok && body["evaluation"] != nil {
			t.Fatalf("expected no evaluation on a failed attempt, got %v", body["evaluation"])
		}
	})

	t.Run("respects an explicit experiment purpose", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@e.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)
		questionID := createQuestion(t, token, examSubjectID)
		answerID := createAnswer(t, token, examSubjectID, studentID, questionID, "42")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/answers/"+answerID+"/evaluation-attempts", `{"purpose":"experiment"}`, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["purpose"] != "experiment" {
			t.Fatalf("purpose field = %v, want experiment", body["purpose"])
		}
	})

	t.Run("answer belonging to another user's class is not found", func(t *testing.T) {
		setupTest(t)
		_, ownerToken := createUser(t, "owner@e.com")
		classID := createClass(t, ownerToken, "C")
		studentID := createStudent(t, ownerToken, classID, "Alice", "1")
		examID := createExam(t, ownerToken, classID, "Term 1")
		examSubjectID := createExamSubject(t, ownerToken, examID)
		questionID := createQuestion(t, ownerToken, examSubjectID)
		answerID := createAnswer(t, ownerToken, examSubjectID, studentID, questionID, "42")

		_, otherToken := createUser(t, "other@e.com")
		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/answers/"+answerID+"/evaluation-attempts", "", otherToken)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("unknown answer id is not found", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@e.com")
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/answers/00000000-0000-0000-0000-000000000000/evaluation-attempts", "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})
}

func TestListAndGetEvaluationAttempts(t *testing.T) {
	t.Run("list and get round-trip a created attempt", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@e.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)
		questionID := createQuestion(t, token, examSubjectID)
		answerID := createAnswer(t, token, examSubjectID, studentID, questionID, "42")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/answers/"+answerID+"/evaluation-attempts", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("create status = %d (%s)", w.Code, w.Body.String())
		}
		attemptID := decode(t, w.Body.Bytes())["id"].(string)

		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/answers/"+answerID+"/evaluation-attempts", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("list status = %d (%s)", w.Code, w.Body.String())
		}
		attempts := decode(t, w.Body.Bytes())["evaluation_attempts"].([]any)
		if len(attempts) != 1 {
			t.Fatalf("expected 1 attempt, got %d", len(attempts))
		}

		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/answers/"+answerID+"/evaluation-attempts/"+attemptID, "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("get status = %d (%s)", w.Code, w.Body.String())
		}
		if decode(t, w.Body.Bytes())["id"] != attemptID {
			t.Fatalf("get returned a different attempt")
		}
	})

	t.Run("get for another user's answer is not found", func(t *testing.T) {
		setupTest(t)
		_, ownerToken := createUser(t, "owner@e.com")
		classID := createClass(t, ownerToken, "C")
		studentID := createStudent(t, ownerToken, classID, "Alice", "1")
		examID := createExam(t, ownerToken, classID, "Term 1")
		examSubjectID := createExamSubject(t, ownerToken, examID)
		questionID := createQuestion(t, ownerToken, examSubjectID)
		answerID := createAnswer(t, ownerToken, examSubjectID, studentID, questionID, "42")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/answers/"+answerID+"/evaluation-attempts", "", ownerToken)
		attemptID := decode(t, w.Body.Bytes())["id"].(string)

		_, otherToken := createUser(t, "other@e.com")
		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/answers/"+answerID+"/evaluation-attempts/"+attemptID, "", otherToken)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}

		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/answers/"+answerID+"/evaluation-attempts", "", otherToken)
		if w.Code != http.StatusNotFound {
			t.Fatalf("list status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})
}
