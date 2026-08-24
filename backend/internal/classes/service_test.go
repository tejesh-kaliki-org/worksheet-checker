package classes_test

import (
	"context"
	"encoding/json"
	"net/http"
	"strings"
	"testing"

	"github.com/google/uuid"

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
	t.Run("bulk-select, list, remove", func(t *testing.T) {
		setupTest(t)
		ownerID, token := createUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())
		classID := created["id"].(string)

		// setupTest truncates every table, so insert an owner-scoped subject
		// directly rather than relying on signup-time seeding.
		var subjectID string
		err := testDB.Pool.QueryRow(context.Background(),
			`INSERT INTO subjects (name, owner_id) VALUES ('Mathematics', $1) RETURNING id`, ownerID).Scan(&subjectID)
		if err != nil {
			t.Fatalf("insert subject: %v", err)
		}

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/subjects:bulk-select",
			`{"subject_ids":["`+subjectID+`"]}`, token)
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

	t.Run("bulk-select subject owned by another user 404s", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		otherID, _ := createUser(t, "other@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())
		classID := created["id"].(string)

		var subjectID string
		err := testDB.Pool.QueryRow(context.Background(),
			`INSERT INTO subjects (name, owner_id) VALUES ('Mathematics', $1) RETURNING id`, otherID).Scan(&subjectID)
		if err != nil {
			t.Fatalf("insert subject: %v", err)
		}

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/subjects:bulk-select",
			`{"subject_ids":["`+subjectID+`"]}`, token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("bulk-select nonexistent subject 404s", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())
		classID := created["id"].(string)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/subjects:bulk-select",
			`{"subject_ids":["`+uuid.NewString()+`"]}`, token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("subjects on class owned by another user 404s", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		_, otherToken := createUser(t, "other@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())
		classID := created["id"].(string)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/subjects", "", otherToken)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

// TestCreateClassNameUniqueness covers the 0009_classes_unique_name.sql
// constraint: names are unique per owner, not globally.
func TestCreateClassNameUniqueness(t *testing.T) {
	t.Run("duplicate name for same owner conflicts", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"Grade 5A"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"Grade 5A"}`, token)
		if w.Code != http.StatusConflict {
			t.Fatalf("status = %d, want 409 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("same name for a different owner is allowed", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"Grade 5A"}`, tokenA)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"Grade 5A"}`, tokenB)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("rename onto an existing name conflicts", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"Grade 5A"}`, token)
		other := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"Grade 5B"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPut, "/api/v1/classes/"+other["id"].(string), `{"name":"Grade 5A"}`, token)
		if w.Code != http.StatusConflict {
			t.Fatalf("status = %d, want 409 (%s)", w.Code, w.Body.String())
		}
	})
}

// TestListClassesEmpty pins the collection-endpoint contract: a User with no
// Classes gets an empty JSON array, never null.
func TestListClassesEmpty(t *testing.T) {
	setupTest(t)
	_, token := createUser(t, "owner@b.com")

	w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes", "", token)
	if w.Code != http.StatusOK {
		t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
	}
	if !strings.Contains(w.Body.String(), `"classes":[]`) {
		t.Fatalf("body = %s, want an empty array not null", w.Body.String())
	}
}

func TestBulkSelectClassSubjects(t *testing.T) {
	// seedSubject inserts an owner-scoped Subject directly; setupTest
	// truncates every table, so signup-time seeding is not available here.
	seedSubject := func(t *testing.T, owner uuid.UUID, name string) string {
		t.Helper()
		var id string
		if err := testDB.Pool.QueryRow(context.Background(),
			`INSERT INTO subjects (name, owner_id) VALUES ($1, $2) RETURNING id`, name, owner).Scan(&id); err != nil {
			t.Fatalf("insert subject: %v", err)
		}
		return id
	}

	t.Run("selects several subjects at once and is idempotent", func(t *testing.T) {
		setupTest(t)
		ownerID, token := createUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())
		classID := created["id"].(string)
		a, b := seedSubject(t, ownerID, "Mathematics"), seedSubject(t, ownerID, "Science")
		body := `{"subject_ids":["` + a + `","` + b + `"]}`

		for i := range 2 {
			w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/subjects:bulk-select", body, token)
			if w.Code != http.StatusCreated {
				t.Fatalf("attempt %d: status = %d, want 201 (%s)", i, w.Code, w.Body.String())
			}
			var got struct {
				Subjects []map[string]any `json:"subjects"`
			}
			if err := json.Unmarshal(w.Body.Bytes(), &got); err != nil {
				t.Fatalf("decode: %v", err)
			}
			if len(got.Subjects) != 2 {
				t.Fatalf("attempt %d: subjects = %+v, want 2", i, got.Subjects)
			}
		}
	})

	t.Run("empty list is rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/classes/"+created["id"].(string)+"/subjects:bulk-select", `{"subject_ids":[]}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("malformed body is rejected", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/classes/"+created["id"].(string)+"/subjects:bulk-select", `{"subject_ids":"maths"}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("a single foreign id rejects the whole selection", func(t *testing.T) {
		setupTest(t)
		ownerID, token := createUser(t, "owner@b.com")
		otherID, _ := createUser(t, "other@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())
		classID := created["id"].(string)
		mine, theirs := seedSubject(t, ownerID, "Mathematics"), seedSubject(t, otherID, "Science")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/subjects:bulk-select",
			`{"subject_ids":["`+mine+`","`+theirs+`"]}`, token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}

		// Nothing may have been selected: the request is all-or-nothing.
		w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/subjects", "", token)
		if !strings.Contains(w.Body.String(), `"subjects":[]`) {
			t.Fatalf("body = %s, want no subjects selected", w.Body.String())
		}
	})

	t.Run("class owned by another user 404s", func(t *testing.T) {
		setupTest(t)
		ownerID, token := createUser(t, "owner@b.com")
		_, otherToken := createUser(t, "other@b.com")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"C"}`, token).Body.Bytes())
		subjectID := seedSubject(t, ownerID, "Mathematics")

		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/classes/"+created["id"].(string)+"/subjects:bulk-select",
			`{"subject_ids":["`+subjectID+`"]}`, otherToken)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("missing class 404s", func(t *testing.T) {
		setupTest(t)
		ownerID, token := createUser(t, "owner@b.com")
		subjectID := seedSubject(t, ownerID, "Mathematics")

		w := testsupport.DoJSONAuth(router, http.MethodPost,
			"/api/v1/classes/"+uuid.NewString()+"/subjects:bulk-select",
			`{"subject_ids":["`+subjectID+`"]}`, token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404 (%s)", w.Code, w.Body.String())
		}
	})
}
