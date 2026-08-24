package subjects_test

import (
	"context"
	"encoding/json"
	"net/http"
	"strings"
	"testing"

	"github.com/google/uuid"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

func TestListSubjects(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/subjects", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		var body struct {
			Subjects []map[string]any `json:"subjects"`
		}
		if err := json.Unmarshal(w.Body.Bytes(), &body); err != nil {
			t.Fatalf("decode: %v", err)
		}
		if len(body.Subjects) == 0 {
			t.Fatal("expected the seeded subject catalogue to be non-empty")
		}
	})

	t.Run("authorization", func(t *testing.T) {
		setupTest(t)
		w := testsupport.DoJSON(router, http.MethodGet, "/api/v1/subjects", "")
		if w.Code != http.StatusUnauthorized {
			t.Fatalf("status = %d, want 401", w.Code)
		}
	})
}

// listNames returns the names in the caller's catalogue, failing the test on
// any non-200.
func listNames(t *testing.T, token string) []string {
	t.Helper()
	w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/subjects", "", token)
	if w.Code != http.StatusOK {
		t.Fatalf("list status = %d, want 200 (%s)", w.Code, w.Body.String())
	}
	var body struct {
		Subjects []struct {
			Name string `json:"name"`
		} `json:"subjects"`
	}
	if err := json.Unmarshal(w.Body.Bytes(), &body); err != nil {
		t.Fatalf("decode: %v", err)
	}
	names := make([]string, 0, len(body.Subjects))
	for _, s := range body.Subjects {
		names = append(names, s.Name)
	}
	return names
}

func decode(t *testing.T, b []byte) map[string]any {
	t.Helper()
	var m map[string]any
	if err := json.Unmarshal(b, &m); err != nil {
		t.Fatalf("decode: %v (%s)", err, string(b))
	}
	return m
}

// TestListSubjectsEmpty pins the collection-endpoint contract for a User whose
// catalogue was never seeded: an empty array, never null.
func TestListSubjectsEmpty(t *testing.T) {
	setupTest(t)
	_, token := createBareUser(t, "bare@b.com")

	w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/subjects", "", token)
	if w.Code != http.StatusOK {
		t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
	}
	if !strings.Contains(w.Body.String(), `"subjects":[]`) {
		t.Fatalf("body = %s, want an empty array not null", w.Body.String())
	}
}

func TestCreateSubject(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		if decode(t, w.Body.Bytes())["name"] != "Music" {
			t.Fatalf("body = %s", w.Body.String())
		}
	})

	t.Run("name is trimmed", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"  Music  "}`, token)
		if w.Code != http.StatusCreated || decode(t, w.Body.Bytes())["name"] != "Music" {
			t.Fatalf("status = %d, body = %s", w.Code, w.Body.String())
		}
	})

	t.Run("blank name is rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"   "}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("malformed body is rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":5}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("duplicate name for the same owner conflicts", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, token)
		if w.Code != http.StatusConflict {
			t.Fatalf("status = %d, want 409 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("the same name for a different owner is allowed", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createBareUser(t, "a@b.com")
		_, tokenB := createBareUser(t, "b@b.com")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, tokenA)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, tokenB)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("authorization", func(t *testing.T) {
		setupTest(t)
		w := testsupport.DoJSON(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`)
		if w.Code != http.StatusUnauthorized {
			t.Fatalf("status = %d, want 401", w.Code)
		}
	})
}

func TestBulkCreateSubjects(t *testing.T) {
	t.Run("creates all names and returns the full catalogue", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects:bulk-create",
			`{"names":["Music","Art"]}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		if got := listNames(t, token); len(got) != 2 {
			t.Fatalf("catalogue = %v, want 2 entries", got)
		}
	})

	t.Run("idempotent: existing names are skipped, never 409", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects:bulk-create",
			`{"names":["Music","Art"]}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		if got := listNames(t, token); len(got) != 2 {
			t.Fatalf("catalogue = %v, want Music and Art only", got)
		}
	})

	t.Run("duplicates within one request collapse", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects:bulk-create",
			`{"names":["Music","Music"]}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		if got := listNames(t, token); len(got) != 1 {
			t.Fatalf("catalogue = %v, want 1 entry", got)
		}
	})

	t.Run("empty list is rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects:bulk-create", `{"names":[]}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("blank entry rejects the whole request", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects:bulk-create",
			`{"names":["Music","  "]}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
		if got := listNames(t, token); len(got) != 0 {
			t.Fatalf("catalogue = %v, want nothing created", got)
		}
	})

	t.Run("scoped to the caller", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createBareUser(t, "a@b.com")
		_, tokenB := createBareUser(t, "b@b.com")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects:bulk-create", `{"names":["Music"]}`, tokenA)

		if got := listNames(t, tokenB); len(got) != 0 {
			t.Fatalf("B's catalogue = %v, want empty", got)
		}
	})
}

func TestUpdateSubject(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPut, "/api/v1/subjects/"+created["id"].(string), `{"name":"Musicology"}`, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
		if decode(t, w.Body.Bytes())["name"] != "Musicology" {
			t.Fatalf("body = %s", w.Body.String())
		}
	})

	t.Run("blank name is rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPut, "/api/v1/subjects/"+created["id"].(string), `{"name":"  "}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("renaming onto an existing name conflicts", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, token)
		other := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Art"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPut, "/api/v1/subjects/"+other["id"].(string), `{"name":"Music"}`, token)
		if w.Code != http.StatusConflict {
			t.Fatalf("status = %d, want 409 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("another user's subject 404s", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createBareUser(t, "a@b.com")
		_, tokenB := createBareUser(t, "b@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, tokenA).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPut, "/api/v1/subjects/"+created["id"].(string), `{"name":"Art"}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("missing subject 404s", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodPut, "/api/v1/subjects/"+uuid.NewString(), `{"name":"Art"}`, token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})
}

func TestDeleteSubject(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodDelete, "/api/v1/subjects/"+created["id"].(string), "", token)
		if w.Code != http.StatusNoContent {
			t.Fatalf("status = %d, want 204 (%s)", w.Code, w.Body.String())
		}
		if got := listNames(t, token); len(got) != 0 {
			t.Fatalf("catalogue = %v, want empty", got)
		}
	})

	// Deleting never cascades: a Subject a Class still selects must 409.
	// Downstream Exam Subject / Question / Answer tables do not exist on this
	// schema yet, so class_subjects is the only reference that can conflict.
	t.Run("subject still selected by a class conflicts", func(t *testing.T) {
		setupTest(t)
		ownerID, token := createBareUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, token).Body.Bytes())
		subjectID := created["id"].(string)

		var classID string
		if err := testDB.Pool.QueryRow(context.Background(),
			`INSERT INTO classes (name, created_by) VALUES ('Grade 5A', $1) RETURNING id`, ownerID).Scan(&classID); err != nil {
			t.Fatalf("insert class: %v", err)
		}
		if _, err := testDB.Pool.Exec(context.Background(),
			`INSERT INTO class_subjects (class_id, subject_id) VALUES ($1, $2)`, classID, subjectID); err != nil {
			t.Fatalf("insert class_subject: %v", err)
		}

		w := testsupport.DoJSONAuth(router, http.MethodDelete, "/api/v1/subjects/"+subjectID, "", token)
		if w.Code != http.StatusConflict {
			t.Fatalf("status = %d, want 409 (%s)", w.Code, w.Body.String())
		}
		if got := listNames(t, token); len(got) != 1 {
			t.Fatalf("catalogue = %v, want the subject kept", got)
		}
	})

	t.Run("another user's subject 404s", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createBareUser(t, "a@b.com")
		_, tokenB := createBareUser(t, "b@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/subjects", `{"name":"Music"}`, tokenA).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodDelete, "/api/v1/subjects/"+created["id"].(string), "", tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("missing subject 404s", func(t *testing.T) {
		setupTest(t)
		_, token := createBareUser(t, "owner@b.com")

		w := testsupport.DoJSONAuth(router, http.MethodDelete, "/api/v1/subjects/"+uuid.NewString(), "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})
}
