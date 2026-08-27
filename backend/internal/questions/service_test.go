package questions_test

import (
	"net/http"
	"strings"
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

// questionTypeConfigs is a valid config for every QuestionType, used to loop
// create/update tests over all types rather than testing each one-off.
var questionTypeConfigs = []struct {
	qType  string
	config string
}{
	{"mcq", `{"options":{"A":"one","B":"two"},"correct_answer":"A"}`},
	{"true_false", `{"correct_answer":true}`},
	{"numeric", `{"correct_answer":10,"tolerance":0.1}`},
	{"fill_in", `{"correct_answer":"chlorophyll"}`},
	{"open_response", `{"rubric_points":["a","b"]}`},
}

func TestCreateQuestion(t *testing.T) {
	t.Run("all question types accepted", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)

		for _, tc := range questionTypeConfigs {
			t.Run(tc.qType, func(t *testing.T) {
				w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
					`{"type":"`+tc.qType+`","maximum_marks":2,"config":`+tc.config+`}`, token)
				if w.Code != http.StatusCreated {
					t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
				}
				body := decode(t, w.Body.Bytes())
				if body["type"] != tc.qType {
					t.Fatalf("body = %+v", body)
				}
			})
		}
	})

	t.Run("invalid mcq config rejected", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
			`{"type":"mcq","maximum_marks":2,"config":{"options":{"A":"one"},"correct_answer":"Z"}}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("invalid type rejected", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
			`{"type":"essay","maximum_marks":2,"config":{}}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("not_found for another owner's exam subject", func(t *testing.T) {
		setupTest(t)
		uidA, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")
		examID := createExam(t, tokenA, classID, "Term 1")
		examSubjectID := createExamSubject(t, tokenA, uidA, examID)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
			`{"type":"true_false","maximum_marks":1,"config":{"correct_answer":true}}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestListQuestions(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
			`{"type":"numeric","maximum_marks":3,"config":{"correct_answer":10,"tolerance":0.1}}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exam-subjects/"+examSubjectID+"/questions", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("empty is [], not null", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := createExam(t, token, classID, "Term 1")
		examSubjectID := createExamSubject(t, token, uid, examID)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exam-subjects/"+examSubjectID+"/questions", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
		if !strings.Contains(w.Body.String(), `"questions":[]`) {
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

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exam-subjects/"+examSubjectID+"/questions", "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestGetUpdateDeleteQuestion(t *testing.T) {
	setupTest(t)
	uid, token := createUser(t, "owner@b.com")
	classID := createClass(t, token, "C")
	examID := createExam(t, token, classID, "Term 1")
	examSubjectID := createExamSubject(t, token, uid, examID)
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

func TestGetUpdateDeleteQuestion_notFound(t *testing.T) {
	setupTest(t)
	uidA, tokenA := createUser(t, "a@b.com")
	_, tokenB := createUser(t, "b@b.com")
	classID := createClass(t, tokenA, "C")
	examID := createExam(t, tokenA, classID, "Term 1")
	examSubjectID := createExamSubject(t, tokenA, uidA, examID)
	created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
		`{"type":"fill_in","maximum_marks":1,"config":{"correct_answer":"chlorophyll"}}`, tokenA).Body.Bytes())
	questionID := created["id"].(string)

	t.Run("get 404s for another owner's exam subject", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/exam-subjects/"+examSubjectID+"/questions/"+questionID, "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})

	t.Run("update 404s for another owner's exam subject", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodPut,
			"/api/v1/exam-subjects/"+examSubjectID+"/questions/"+questionID,
			`{"type":"fill_in","maximum_marks":2,"config":{"correct_answer":"photosynthesis"}}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})

	t.Run("delete 404s for another owner's exam subject", func(t *testing.T) {
		w := testsupport.DoJSONAuth(router, http.MethodDelete,
			"/api/v1/exam-subjects/"+examSubjectID+"/questions/"+questionID, "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})

	t.Run("get 404s for a question id from a different exam subject", func(t *testing.T) {
		otherExamID := createExam(t, tokenA, classID, "Term 2")
		otherExamSubjectID := createExamSubject(t, tokenA, uidA, otherExamID)

		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/exam-subjects/"+otherExamSubjectID+"/questions/"+questionID, "", tokenA)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestUpdateQuestion_validation(t *testing.T) {
	setupTest(t)
	uid, token := createUser(t, "owner@b.com")
	classID := createClass(t, token, "C")
	examID := createExam(t, token, classID, "Term 1")
	examSubjectID := createExamSubject(t, token, uid, examID)
	created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
		`{"type":"fill_in","maximum_marks":1,"config":{"correct_answer":"chlorophyll"}}`, token).Body.Bytes())
	questionID := created["id"].(string)

	w := testsupport.DoJSONAuth(router, http.MethodPut,
		"/api/v1/exam-subjects/"+examSubjectID+"/questions/"+questionID,
		`{"type":"mcq","maximum_marks":2,"config":{"options":{"A":"one"},"correct_answer":"Z"}}`, token)
	if w.Code != http.StatusBadRequest {
		t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
	}
}

func TestUpdateQuestion_allTypesAccepted(t *testing.T) {
	setupTest(t)
	uid, token := createUser(t, "owner@b.com")
	classID := createClass(t, token, "C")
	examID := createExam(t, token, classID, "Term 1")
	examSubjectID := createExamSubject(t, token, uid, examID)
	created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
		`{"type":"fill_in","maximum_marks":1,"config":{"correct_answer":"chlorophyll"}}`, token).Body.Bytes())
	questionID := created["id"].(string)

	for _, tc := range questionTypeConfigs {
		t.Run(tc.qType, func(t *testing.T) {
			w := testsupport.DoJSONAuth(router, http.MethodPut,
				"/api/v1/exam-subjects/"+examSubjectID+"/questions/"+questionID,
				`{"type":"`+tc.qType+`","maximum_marks":2,"config":`+tc.config+`}`, token)
			if w.Code != http.StatusOK {
				t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
			}
			body := decode(t, w.Body.Bytes())
			if body["type"] != tc.qType {
				t.Fatalf("body = %+v", body)
			}
		})
	}
}
