package students_test

import (
	"context"
	"encoding/json"
	"net/http"
	"os"
	"testing"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"

	classesgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/classes"
	studentsgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/students"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/auth"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/classes"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/config"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/students"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

var (
	testDB *testsupport.TestDB
	router *gin.Engine
	tokens *auth.TokenIssuer
)

func TestMain(m *testing.M) {
	testDB = testsupport.Connect("test_students")

	r, api := testsupport.NewRouter()
	tokens = auth.NewTokenIssuer(config.TokenConfig{Secret: "test-secret", ExpiryHours: 1})
	authSvc := auth.New(testDB.Pool, config.TokenConfig{Secret: "test-secret", ExpiryHours: 1}, noopMailer{}, nil)
	authSvc.Register(api)
	classes.New(testDB.Pool).Register(api, classesgen.MiddlewareFunc(authSvc.ScopeAuth()))
	students.New(testDB.Pool).Register(api, studentsgen.MiddlewareFunc(authSvc.ScopeAuth()))
	router = r

	os.Exit(m.Run())
}

type noopMailer struct{}

func (noopMailer) SendVerification(context.Context, string, string) error  { return nil }
func (noopMailer) SendPasswordReset(context.Context, string, string) error { return nil }

func setupTest(t *testing.T) {
	t.Helper()
	testDB.Truncate(t)
}

func createUser(t *testing.T, email string) (uuid.UUID, string) {
	t.Helper()
	var id uuid.UUID
	err := testDB.Pool.QueryRow(context.Background(),
		`INSERT INTO users (email, password_hash, name, role, verified) VALUES ($1, 'x', 'Test', 'user', true) RETURNING id`,
		email).Scan(&id)
	if err != nil {
		t.Fatalf("create user: %v", err)
	}
	token, err := tokens.Issue(id.String(), "user")
	if err != nil {
		t.Fatalf("issue token: %v", err)
	}
	return id, token
}

// createClass creates a Class owned by the given token's user and returns its id.
func createClass(t *testing.T, token, name string) string {
	t.Helper()
	w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"`+name+`"}`, token)
	if w.Code != http.StatusCreated {
		t.Fatalf("create class: status = %d (%s)", w.Code, w.Body.String())
	}
	var body map[string]any
	if err := json.Unmarshal(w.Body.Bytes(), &body); err != nil {
		t.Fatalf("decode: %v", err)
	}
	return body["id"].(string)
}

func decode(t *testing.T, b []byte) map[string]any {
	t.Helper()
	var m map[string]any
	if err := json.Unmarshal(b, &m); err != nil {
		t.Fatalf("decode: %v (%s)", err, string(b))
	}
	return m
}
