package submissions_test

import (
	"net/http"
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

func TestBulkUploadSubmissions(t *testing.T) {
	t.Run("success creates submissions and answers", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)
		questionID := createQuestion(t, token, examSubjectID)

		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[{"question_id":"` + questionID + `","raw_answer":"42"}]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}

		w = testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("list status = %d (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("re-upload is idempotent (upsert)", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)
		questionID := createQuestion(t, token, examSubjectID)

		body1 := `{"submissions":[{"student_id":"` + studentID + `","answers":[{"question_id":"` + questionID + `","raw_answer":"first"}]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body1, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d (%s)", w.Code, w.Body.String())
		}
		submissions := decode(t, w.Body.Bytes())["submissions"].([]any)
		submissionID := submissions[0].(map[string]any)["id"].(string)

		body2 := `{"submissions":[{"student_id":"` + studentID + `","answers":[{"question_id":"` + questionID + `","raw_answer":"second"}]}]}`
		w = testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body2, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d (%s)", w.Code, w.Body.String())
		}
		submissions2 := decode(t, w.Body.Bytes())["submissions"].([]any)
		if submissions2[0].(map[string]any)["id"].(string) != submissionID {
			t.Fatalf("expected same submission id on re-upload")
		}

		w = testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/submissions/"+submissionID+"/answers", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("list answers status = %d (%s)", w.Code, w.Body.String())
		}
		answers := decode(t, w.Body.Bytes())["answers"].([]any)
		if len(answers) != 1 {
			t.Fatalf("expected 1 answer (upserted), got %d", len(answers))
		}
		if answers[0].(map[string]any)["raw_answer"].(string) != "second" {
			t.Fatalf("expected overwritten answer, got %+v", answers[0])
		}
	})

	t.Run("student from a different class rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classA := createClass(t, token, "A")
		classB := createClass(t, token, "B")
		studentID := createStudent(t, token, classB, "Bob", "1")
		examID := createExam(t, token, classA, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)

		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("not_found for another owner's exam subject", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")
		studentID := createStudent(t, tokenA, classID, "Alice", "1")
		examID := createExam(t, tokenA, classID, "Term 1")
		examSubjectID := createExamSubject(t, tokenA, examID)

		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestGetAndUpdateAnswer(t *testing.T) {
	setupTest(t)
	_, token := createUser(t, "owner@b.com")
	classID := createClass(t, token, "C")
	studentID := createStudent(t, token, classID, "Alice", "1")
	examID := createExam(t, token, classID, "Term 1")
	examSubjectID := createExamSubject(t, token, examID)
	questionID := createQuestion(t, token, examSubjectID)

	body := `{"submissions":[{"student_id":"` + studentID + `","answers":[{"question_id":"` + questionID + `","raw_answer":"42"}]}]}`
	w := testsupport.DoJSONAuth(router, http.MethodPost,
		"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
	if w.Code != http.StatusOK {
		t.Fatalf("bulk upload status = %d (%s)", w.Code, w.Body.String())
	}
	submissionID := decode(t, w.Body.Bytes())["submissions"].([]any)[0].(map[string]any)["id"].(string)

	w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/submissions/"+submissionID+"/answers", "", token)
	answerID := decode(t, w.Body.Bytes())["answers"].([]any)[0].(map[string]any)["id"].(string)

	t.Run("get answer", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/submissions/"+submissionID+"/answers/"+answerID, "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d (%s)", w.Code, w.Body.String())
		}
		if decode(t, w.Body.Bytes())["raw_answer"] != "42" {
			t.Fatalf("body = %s", w.Body.String())
		}
	})

	t.Run("teacher corrects a mis-entered answer", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodPut,
			"/api/v1/submissions/"+submissionID+"/answers/"+answerID, `{"raw_answer":"24"}`, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d (%s)", w.Code, w.Body.String())
		}
		if decode(t, w.Body.Bytes())["raw_answer"] != "24" {
			t.Fatalf("body = %s", w.Body.String())
		}
	})

	t.Run("not_found for another owner", func(t *testing.T) {
		_, tokenB := createUser(t, "b@b.com")
		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/submissions/"+submissionID+"/answers/"+answerID, "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}
