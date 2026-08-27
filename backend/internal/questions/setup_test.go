package questions_test

import (
	"context"
	"encoding/json"
	"net/http"
	"os"
	"testing"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"

	classesgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/classes"
	examsgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/exams"
	questionsgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/questions"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/auth"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/classes"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/config"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/exams"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/questions"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/subjects"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

var (
	testDB *testsupport.TestDB
	router *gin.Engine
	tokens *auth.TokenIssuer
)

func TestMain(m *testing.M) {
	testDB = testsupport.Connect("test_questions")

	r, api := testsupport.NewRouter()
	tokens = auth.NewTokenIssuer(config.TokenConfig{Secret: "test-secret", ExpiryHours: 1})
	authSvc := auth.New(testDB.Pool, config.TokenConfig{Secret: "test-secret", ExpiryHours: 1}, noopMailer{}, nil)
	authSvc.Register(api)
	classes.New(testDB.Pool).Register(api, classesgen.MiddlewareFunc(authSvc.ScopeAuth()))
	exams.New(testDB.Pool).Register(api, examsgen.MiddlewareFunc(authSvc.ScopeAuth()))
	questions.New(testDB.Pool).Register(api, questionsgen.MiddlewareFunc(authSvc.ScopeAuth()))
	router = r

	os.Exit(m.Run())
}

type noopMailer struct{}

func (noopMailer) SendVerification(context.Context, string, string) error  { return nil }
func (noopMailer) SendPasswordReset(context.Context, string, string) error { return nil }

func setupTest(t *testing.T) {
	t.Helper()
	if _, err := testDB.Pool.Exec(context.Background(), `TRUNCATE users CASCADE`); err != nil {
		t.Fatalf("truncate users: %v", err)
	}
}

// createUser inserts a verified user directly (bypassing signup) and seeds
// its default Subject catalogue the same way auth.Service.Signup does (see
// ADR 0009), since Subjects are now a per-user catalogue rather than a global
// one.
func createUser(t *testing.T, email string) (uuid.UUID, string) {
	t.Helper()
	var id uuid.UUID
	err := testDB.Pool.QueryRow(context.Background(),
		`INSERT INTO users (email, password_hash, name, role, verified) VALUES ($1, 'x', 'Test', 'user', true) RETURNING id`,
		email).Scan(&id)
	if err != nil {
		t.Fatalf("create user: %v", err)
	}
	if err := subjects.New(testDB.Pool).SeedDefaults(context.Background(), id); err != nil {
		t.Fatalf("seed default subjects: %v", err)
	}
	token, err := tokens.Issue(id.String(), "user")
	if err != nil {
		t.Fatalf("issue token: %v", err)
	}
	return id, token
}

func createClass(t *testing.T, token, name string) string {
	t.Helper()
	w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"`+name+`"}`, token)
	if w.Code != http.StatusCreated {
		t.Fatalf("create class: status = %d (%s)", w.Code, w.Body.String())
	}
	return decode(t, w.Body.Bytes())["id"].(string)
}

func createExam(t *testing.T, token, classID, label string) string {
	t.Helper()
	w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/exams",
		`{"label":"`+label+`"}`, token)
	if w.Code != http.StatusCreated {
		t.Fatalf("create exam: status = %d (%s)", w.Code, w.Body.String())
	}
	return decode(t, w.Body.Bytes())["id"].(string)
}

// createExamSubject attaches the given owner's seeded "Mathematics" Subject
// to the given Exam and returns the resulting Exam Subject's id. Subjects are
// a per-user catalogue (ADR 0009), so the subject must be looked up scoped to
// the same owner as the Exam's Class.
func createExamSubject(t *testing.T, token string, ownerID uuid.UUID, examID string) string {
	t.Helper()
	var subjectID uuid.UUID
	err := testDB.Pool.QueryRow(context.Background(),
		`SELECT id FROM subjects WHERE name = 'Mathematics' AND owner_id = $1`, ownerID).Scan(&subjectID)
	if err != nil {
		t.Fatalf("load seeded subject: %v", err)
	}
	w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exams/"+examID+"/subjects",
		`{"subject_id":"`+subjectID.String()+`"}`, token)
	if w.Code != http.StatusCreated {
		t.Fatalf("add exam subject: status = %d (%s)", w.Code, w.Body.String())
	}
	return decode(t, w.Body.Bytes())["id"].(string)
}

func decode(t *testing.T, b []byte) map[string]any {
	t.Helper()
	var m map[string]any
	if err := json.Unmarshal(b, &m); err != nil {
		t.Fatalf("decode: %v (%s)", err, string(b))
	}
	return m
}
