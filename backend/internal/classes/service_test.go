package classes_test

import (
	"context"
	"encoding/json"
	"net/http"
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

func decode(t *testing.T, b []byte) map[string]any {
	t.Helper()
	var m map[string]any
	if err := json.Unmarshal(b, &m); err != nil {
		t.Fatalf("decode: %v (%s)", err, string(b))
	}
	return m
}

func TestCreateClass(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"Grade 5A"}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["name"] != "Grade 5A" {
			t.Fatalf("name = %v", body["name"])
		}
	})

	t.Run("authorization", func(t *testing.T) {
		setupTest(t)
		w := testsupport.DoJSON(router, http.MethodPost, "/api/v1/classes", `{"name":"Grade 5A"}`)
		if w.Code != http.StatusUnauthorized {
			t.Fatalf("status = %d, want 401", w.Code)
		}
	})

	t.Run("validation", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":""}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400", w.Code)
		}
	})
}

func TestListClasses(t *testing.T) {
	t.Run("success scoped to owner", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")

		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"A's class"}`, tokenA)
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"B's class"}`, tokenB)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes", "", tokenA)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		var body struct {
			Classes []map[string]any `json:"classes"`
		}
		if err := json.Unmarshal(w.Body.Bytes(), &body); err != nil {
			t.Fatalf("decode: %v", err)
		}
		if len(body.Classes) != 1 || body.Classes[0]["name"] != "A's class" {
			t.Fatalf("classes = %+v, want only A's class", body.Classes)
		}
	})
}

func TestGetClass(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+created["id"].(string), "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
	})

	t.Run("not_found for another owner's class", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, tokenA).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+created["id"].(string), "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})

	t.Run("not_found for missing class", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/00000000-0000-0000-0000-000000000000", "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestUpdateClass(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPut, "/api/v1/classes/"+created["id"].(string), `{"name":"C2"}`, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["name"] != "C2" {
			t.Fatalf("name = %v", body["name"])
		}
	})
}

func TestDeleteClass(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodDelete, "/api/v1/classes/"+created["id"].(string), "", token)
		if w.Code != http.StatusNoContent {
			t.Fatalf("status = %d, want 204", w.Code)
		}

		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+created["id"].(string), "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 after delete", w.Code)
		}
	})
}

func TestClassSubjects(t *testing.T) {
	t.Run("add, list, remove", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())
		classID := created["id"].(string)

		// setupTest truncates every table (including the seeded subjects
		// catalogue), so insert one directly rather than relying on the seed.
		var subjectID string
		err := testDB.Pool.QueryRow(context.Background(),
			`INSERT INTO subjects (name) VALUES ('Mathematics') RETURNING id`).Scan(&subjectID)
		if err != nil {
			t.Fatalf("insert subject: %v", err)
		}

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/subjects",
			`{"subject_id":"`+subjectID+`"}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}

		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/subjects", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
		var body struct {
			Subjects []map[string]any `json:"subjects"`
		}
		if err := json.Unmarshal(w.Body.Bytes(), &body); err != nil {
			t.Fatalf("decode: %v", err)
		}
		if len(body.Subjects) != 1 {
			t.Fatalf("subjects = %+v, want 1", body.Subjects)
		}

		w = testsupport.DoJSONAuth(router, http.MethodDelete, "/api/v1/classes/"+classID+"/subjects/"+subjectID, "", token)
		if w.Code != http.StatusNoContent {
			t.Fatalf("status = %d, want 204", w.Code)
		}
	})
}
