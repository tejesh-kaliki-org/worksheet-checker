package submissions_test

import (
	"net/http"
	"strings"
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

func TestBulkUploadSubmissions(t *testing.T) {
	t.Run("success creates submissions and answers", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)
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
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)
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
		uid, token := createUser(t, "owner@b.com")
		classA := createClass(t, token, "A")
		classB := createClass(t, token, "B")
		studentID := createStudent(t, token, classB, "Bob", "1")
		examID := createExam(t, token, classA, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)

		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("unknown student rejected", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)

		body := `{"submissions":[{"student_id":"00000000-0000-0000-0000-000000000000","answers":[]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("unknown question rejected", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)

		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[{"question_id":"00000000-0000-0000-0000-000000000000","raw_answer":"x"}]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("question from a different exam subject rejected", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)
		otherExamID := createExam(t, token, classID, "Term 2")
		otherExamSubjectID := createExamSubject(t, token, uid, otherExamID)
		otherQuestionID := createQuestion(t, token, otherExamSubjectID)

		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[{"question_id":"` + otherQuestionID + `","raw_answer":"x"}]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("not_found for another owner's exam subject", func(t *testing.T) {
		setupTest(t)
		uidA, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")
		studentID := createStudent(t, tokenA, classID, "Alice", "1")
		examID := createExam(t, tokenA, classID, "Term 1")
		examSubjectID := createExamSubject(t, tokenA, uidA, examID)

		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestListSubmissions(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)
		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[]}]}`
		testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exam-subjects/"+examSubjectID+"/submissions", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		submissions, ok := decode(t, w.Body.Bytes())["submissions"].([]any)
		if !ok || len(submissions) != 1 {
			t.Fatalf("body = %s", w.Body.String())
		}
	})

	t.Run("empty is [], not null", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exam-subjects/"+examSubjectID+"/submissions", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
		if !strings.Contains(w.Body.String(), `"submissions":[]`) {
			t.Fatalf("body = %s, want an empty array, not null", w.Body.String())
		}
	})

	t.Run("not_found for another owner's exam subject", func(t *testing.T) {
		setupTest(t)
		uidA, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")
		examID := createExam(t, tokenA, classID, "Term 1")
		examSubjectID := createExamSubject(t, tokenA, uidA, examID)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exam-subjects/"+examSubjectID+"/submissions", "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestListAnswers(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)
		questionID := createQuestion(t, token, examSubjectID)
		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[{"question_id":"` + questionID + `","raw_answer":"42"}]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
		submissionID := decode(t, w.Body.Bytes())["submissions"].([]any)[0].(map[string]any)["id"].(string)

		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/submissions/"+submissionID+"/answers", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		answers, ok := decode(t, w.Body.Bytes())["answers"].([]any)
		if !ok || len(answers) != 1 {
			t.Fatalf("body = %s", w.Body.String())
		}
	})

	t.Run("empty is [], not null", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		studentID := createStudent(t, token, classID, "Alice", "1")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)
		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
		submissionID := decode(t, w.Body.Bytes())["submissions"].([]any)[0].(map[string]any)["id"].(string)

		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/submissions/"+submissionID+"/answers", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
		if !strings.Contains(w.Body.String(), `"answers":[]`) {
			t.Fatalf("body = %s, want an empty array, not null", w.Body.String())
		}
	})

	t.Run("not_found for another owner's submission", func(t *testing.T) {
		setupTest(t)
		uidA, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")
		studentID := createStudent(t, tokenA, classID, "Alice", "1")
		examID := createExam(t, tokenA, classID, "Term 1")
		examSubjectID := createExamSubject(t, tokenA, uidA, examID)
		body := `{"submissions":[{"student_id":"` + studentID + `","answers":[]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, tokenA)
		submissionID := decode(t, w.Body.Bytes())["submissions"].([]any)[0].(map[string]any)["id"].(string)

		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/submissions/"+submissionID+"/answers", "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestGetAndUpdateAnswer(t *testing.T) {
	setupTest(t)
	uid, token := createUser(t, "owner@b.com")
	classID := createClass(t, token, "C")
	studentID := createStudent(t, token, classID, "Alice", "1")
	examID := createExam(t, token, classID, "Term 1")
	examSubjectID := createExamSubject(t, token, uid, examID)
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

	t.Run("get 404s for an unknown answer id", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/submissions/"+submissionID+"/answers/00000000-0000-0000-0000-000000000000", "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})

	t.Run("get 404s for an answer id from a different submission", func(t *testing.T) {
		otherStudentID := createStudent(t, token, classID, "Bob", "2")
		otherBody := `{"submissions":[{"student_id":"` + otherStudentID + `","answers":[{"question_id":"` + questionID + `","raw_answer":"7"}]}]}`
		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", otherBody, token)
		otherSubmissionID := decode(t, w.Body.Bytes())["submissions"].([]any)[0].(map[string]any)["id"].(string)

		w = testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/submissions/"+otherSubmissionID+"/answers/"+answerID, "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
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

	t.Run("update 404s for an unknown answer id", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodPut,
			"/api/v1/submissions/"+submissionID+"/answers/00000000-0000-0000-0000-000000000000",
			`{"raw_answer":"x"}`, token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
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

	t.Run("update not_found for another owner", func(t *testing.T) {
		_, tokenB := createUser(t, "c@b.com")
		w := testsupport.DoJSONAuth(router, http.MethodPut,
			"/api/v1/submissions/"+submissionID+"/answers/"+answerID, `{"raw_answer":"x"}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}
