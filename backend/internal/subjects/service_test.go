package subjects_test

import (
	"encoding/json"
	"net/http"
	"testing"

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
