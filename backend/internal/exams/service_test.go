package exams_test

import (
	"net/http"
	"strings"
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

func TestCreateExam(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1 Final"}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["label"] != "Term 1 Final" {
			t.Fatalf("body = %+v", body)
		}
	})

	t.Run("not_found for another owner's class", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1"}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})

	t.Run("validation", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":""}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400", w.Code)
		}
	})
}

func TestListExams(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams", `{"label":"Term 1"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/exams", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
		body := decode(t, w.Body.Bytes())
		exams, ok := body["exams"].([]interface{})
		if !ok || len(exams) != 1 {
			t.Fatalf("body = %+v", body)
		}
	})

	t.Run("empty is [], not null", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/exams", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
		if !strings.Contains(w.Body.String(), `"exams":[]`) {
			t.Fatalf("body = %s, want an empty array, not null", w.Body.String())
		}
	})

	t.Run("not_found for another owner's class", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/exams", "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestGetExam(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/classes/"+classID+"/exams/"+created["id"].(string), "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
	})

	t.Run("not_found", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/classes/"+classID+"/exams/00000000-0000-0000-0000-000000000000", "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestAddExamSubject(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1"}`, token).Body.Bytes())["id"].(string)
		subjectID := mathematicsSubjectID(t, uid)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exams/"+examID+"/subjects",
			`{"subject_id":"`+subjectID+`"}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["subject_id"] != subjectID {
			t.Fatalf("body = %+v", body)
		}
	})

	t.Run("not_found for another owner's exam", func(t *testing.T) {
		setupTest(t)
		uidA, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")
		examID := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1"}`, tokenA).Body.Bytes())["id"].(string)
		subjectID := mathematicsSubjectID(t, uidA)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exams/"+examID+"/subjects",
			`{"subject_id":"`+subjectID+`"}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})

	t.Run("not_found for a subject owned by another user", func(t *testing.T) {
		// Subjects are a per-user catalogue (ADR 0009): attaching another
		// User's Subject to your own Exam must 404, not succeed.
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1"}`, token).Body.Bytes())["id"].(string)
		uidOther, _ := createUser(t, "other@b.com")
		otherSubjectID := mathematicsSubjectID(t, uidOther)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exams/"+examID+"/subjects",
			`{"subject_id":"`+otherSubjectID+`"}`, token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("not_found for an unknown subject", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1"}`, token).Body.Bytes())["id"].(string)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exams/"+examID+"/subjects",
			`{"subject_id":"00000000-0000-0000-0000-000000000000"}`, token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestListExamSubjects(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		uid, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1"}`, token).Body.Bytes())["id"].(string)
		subjectID := mathematicsSubjectID(t, uid)
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exams/"+examID+"/subjects",
			`{"subject_id":"`+subjectID+`"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exams/"+examID+"/subjects", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("empty is [], not null", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		examID := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1"}`, token).Body.Bytes())["id"].(string)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exams/"+examID+"/subjects", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
		if !strings.Contains(w.Body.String(), `"exam_subjects":[]`) {
			t.Fatalf("body = %s, want an empty array, not null", w.Body.String())
		}
	})

	t.Run("not_found for another owner's exam", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")
		examID := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
			`{"label":"Term 1"}`, tokenA).Body.Bytes())["id"].(string)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/exams/"+examID+"/subjects", "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}
