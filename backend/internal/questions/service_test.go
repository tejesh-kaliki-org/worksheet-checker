package questions_test

import (
	"net/http"
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

func TestCreateQuestion(t *testing.T) {
	t.Run("mcq success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
			`{"type":"mcq","maximum_marks":2,"config":{"options":{"A":"one","B":"two"},"correct_answer":"A"}}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["type"] != "mcq" {
			t.Fatalf("body = %+v", body)
		}
	})

	t.Run("invalid mcq config rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
			`{"type":"mcq","maximum_marks":2,"config":{"options":{"A":"one"},"correct_answer":"Z"}}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("open_response success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, examID)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
			`{"type":"open_response","maximum_marks":3,"config":{"rubric_points":["a","b"]}}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("not_found for another owner's exam subject", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")
		examID := createExam(t, tokenA, classID, "Term 1")
		examSubjectID := createExamSubject(t, tokenA, examID)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
			`{"type":"true_false","maximum_marks":1,"config":{"correct_answer":true}}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestListQuestions(t *testing.T) {
	setupTest(t)
	_, token := createUser(t, "owner@b.com")
	classID := createClass(t, token, "C")
	examID := createExam(t, token, classID, "Term 1")
	examSubjectID := createExamSubject(t, token, examID)
	testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
		`{"type":"numeric","maximum_marks":3,"config":{"correct_answer":10,"tolerance":0.1}}`, token)

	w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exam-subjects/"+examSubjectID+"/questions", "", token)
	if w.Code != http.StatusOK {
		t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
	}
}

func TestGetUpdateDeleteQuestion(t *testing.T) {
	setupTest(t)
	_, token := createUser(t, "owner@b.com")
	classID := createClass(t, token, "C")
	examID := createExam(t, token, classID, "Term 1")
	examSubjectID := createExamSubject(t, token, examID)
	created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
		`{"type":"fill_in","maximum_marks":1,"config":{"correct_answer":"chlorophyll"}}`, token).Body.Bytes())
	questionID := created["id"].(string)

	t.Run("get", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/exam-subjects/"+examSubjectID+"/questions/"+questionID, "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
	})

	t.Run("update", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodPut,
			"/api/v1/exam-subjects/"+examSubjectID+"/questions/"+questionID,
			`{"type":"fill_in","maximum_marks":2,"config":{"correct_answer":"photosynthesis"}}`, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["maximum_marks"].(float64) != 2 {
			t.Fatalf("body = %+v", body)
		}
	})

	t.Run("delete", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodDelete,
			"/api/v1/exam-subjects/"+examSubjectID+"/questions/"+questionID, "", token)
		if w.Code != http.StatusNoContent {
			t.Fatalf("status = %d, want 204", w.Code)
		}
	})

	t.Run("not_found after delete", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/exam-subjects/"+examSubjectID+"/questions/"+questionID, "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}
