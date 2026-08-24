package students_test

import (
	"encoding/json"
	"net/http"
	"strings"
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

func TestCreateStudent(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["name"] != "Asha" || body["roll_number"] != "1" {
			t.Fatalf("body = %+v", body)
		}
	})

	t.Run("conflict on duplicate roll_number", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Bala","roll_number":"1"}`, token)
		if w.Code != http.StatusConflict {
			t.Fatalf("status = %d, want 409 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("not_found for another owner's class", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})

	t.Run("validation", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"","roll_number":""}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400", w.Code)
		}
	})
}

func TestListStudents(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/students", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
	})
}

func TestGetStudent(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/students/"+created["id"].(string), "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
	})

	t.Run("not_found", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/classes/"+classID+"/students/00000000-0000-0000-0000-000000000000", "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestUpdateStudent(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPut, "/api/v1/classes/"+classID+"/students/"+created["id"].(string),
			`{"name":"Asha K","roll_number":"2"}`, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
	})
}

func TestDeleteStudent(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodDelete, "/api/v1/classes/"+classID+"/students/"+created["id"].(string), "", token)
		if w.Code != http.StatusNoContent {
			t.Fatalf("status = %d, want 204", w.Code)
		}
	})
}

// roster lists a Class's Students, failing the test on any non-200.
func roster(t *testing.T, classID, token string) []map[string]any {
	t.Helper()
	w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/students", "", token)
	if w.Code != http.StatusOK {
		t.Fatalf("list status = %d, want 200 (%s)", w.Code, w.Body.String())
	}
	var body struct {
		Students []map[string]any `json:"students"`
	}
	if err := json.Unmarshal(w.Body.Bytes(), &body); err != nil {
		t.Fatalf("decode: %v", err)
	}
	return body.Students
}

// TestListStudentsEmpty pins the collection-endpoint contract: a Class with no
// Students returns an empty array, never null.
func TestListStudentsEmpty(t *testing.T) {
	setupTest(t)
	_, token := createUser(t, "owner@b.com")
	classID := createClass(t, token, "C")

	w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/students", "", token)
	if w.Code != http.StatusOK {
		t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
	}
	if !strings.Contains(w.Body.String(), `"students":[]`) {
		t.Fatalf("body = %s, want an empty array not null", w.Body.String())
	}
}

func TestBulkUploadStudents(t *testing.T) {
	t.Run("creates the whole roster and returns it", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students:bulk-upload",
			`{"students":[{"name":"Asha","roll_number":"1"},{"name":"Bala","roll_number":"2"}]}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		if got := roster(t, classID, token); len(got) != 2 {
			t.Fatalf("roster = %+v, want 2", got)
		}
	})

	t.Run("empty list is rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students:bulk-upload",
			`{"students":[]}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("malformed body is rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students:bulk-upload",
			`{"students":"Asha"}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("a blank field rejects the whole upload", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students:bulk-upload",
			`{"students":[{"name":"Asha","roll_number":"1"},{"name":"  ","roll_number":"2"}]}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
		if got := roster(t, classID, token); len(got) != 0 {
			t.Fatalf("roster = %+v, want nothing created", got)
		}
	})

	t.Run("a roll number repeated within the request is rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students:bulk-upload",
			`{"students":[{"name":"Asha","roll_number":"1"},{"name":"Bala","roll_number":"1"}]}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
		if got := roster(t, classID, token); len(got) != 0 {
			t.Fatalf("roster = %+v, want nothing created", got)
		}
	})

	t.Run("a roll number colliding with an existing Student conflicts", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students:bulk-upload",
			`{"students":[{"name":"Bala","roll_number":"2"},{"name":"Chandra","roll_number":"1"}]}`, token)
		if w.Code != http.StatusConflict {
			t.Fatalf("status = %d, want 409 (%s)", w.Code, w.Body.String())
		}
		// All-or-nothing: the valid entry must not have landed either.
		if got := roster(t, classID, token); len(got) != 1 {
			t.Fatalf("roster = %+v, want only the pre-existing Student", got)
		}
	})

	t.Run("another owner's class 404s", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students:bulk-upload",
			`{"students":[{"name":"Asha","roll_number":"1"}]}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("missing class 404s", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/classes/00000000-0000-0000-0000-000000000000/students:bulk-upload",
			`{"students":[{"name":"Asha","roll_number":"1"}]}`, token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("authorization", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSON(router, http.MethodPost, "/api/v1/classes/"+classID+"/students:bulk-upload",
			`{"students":[{"name":"Asha","roll_number":"1"}]}`)
		if w.Code != http.StatusUnauthorized {
			t.Fatalf("status = %d, want 401", w.Code)
		}
	})
}
