package evaluations_test

import (
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"os"
	"testing"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"

	classesgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/classes"
	evaluationsgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/evaluations"
	examsgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/exams"
	questionsgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/questions"
	studentsgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/students"
	submissionsgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/submissions"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/auth"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/classes"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/config"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/evaluations"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/exams"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/questions"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/students"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/submissions"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

var (
	testDB      *testsupport.TestDB
	router      *gin.Engine
	tokens      *auth.TokenIssuer
	fakeBifrost *httptest.Server
)

// bifrostHandler lets each test control how the fake Bifrost server responds
// without spinning up a new httptest.Server per test.
var bifrostHandler func(w http.ResponseWriter, r *http.Request)

func TestMain(m *testing.M) {
	testDB = testsupport.Connect("test_evaluations")

	fakeBifrost = httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if bifrostHandler != nil {
			bifrostHandler(w, r)
			return
		}
		defaultBifrostHandler(w, r)
	}))
	defer fakeBifrost.Close()

	r, api := testsupport.NewRouter()
	tokens = auth.NewTokenIssuer(config.TokenConfig{Secret: "test-secret", ExpiryHours: 1})
	authSvc := auth.New(testDB.Pool, config.TokenConfig{Secret: "test-secret", ExpiryHours: 1}, noopMailer{})
	authSvc.Register(api)
	classes.New(testDB.Pool).Register(api, classesgen.MiddlewareFunc(authSvc.ScopeAuth()))
	students.New(testDB.Pool).Register(api, studentsgen.MiddlewareFunc(authSvc.ScopeAuth()))
	exams.New(testDB.Pool).Register(api, examsgen.MiddlewareFunc(authSvc.ScopeAuth()))
	questions.New(testDB.Pool).Register(api, questionsgen.MiddlewareFunc(authSvc.ScopeAuth()))
	submissions.New(testDB.Pool).Register(api, submissionsgen.MiddlewareFunc(authSvc.ScopeAuth()))
	evaluations.New(testDB.Pool, config.BifrostConfig{BaseURL: fakeBifrost.URL, Model: "test-model"}).
		Register(api, evaluationsgen.MiddlewareFunc(authSvc.ScopeAuth()))
	router = r

	os.Exit(m.Run())
}

// defaultBifrostHandler returns a well-formed, successful grading response.
func defaultBifrostHandler(w http.ResponseWriter, r *http.Request) {
	if r.Header.Get("x-correlation-id") == "" {
		http.Error(w, "missing correlation id", http.StatusBadRequest)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	_, _ = w.Write([]byte(`{
		"model": "test-model",
		"choices": [{"message": {"role": "assistant", "content": "{\"raw_score\": 0.75, \"feedback\": \"Mostly correct.\"}"}}],
		"usage": {"prompt_tokens": 10, "completion_tokens": 5}
	}`))
}

type noopMailer struct{}

func (noopMailer) SendVerification(context.Context, string, string) error  { return nil }
func (noopMailer) SendPasswordReset(context.Context, string, string) error { return nil }

func setupTest(t *testing.T) {
	t.Helper()
	if _, err := testDB.Pool.Exec(context.Background(), `TRUNCATE users CASCADE`); err != nil {
		t.Fatalf("truncate users: %v", err)
	}
	bifrostHandler = nil
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

func createClass(t *testing.T, token, name string) string {
	t.Helper()
	w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes", `{"name":"`+name+`"}`, token)
	if w.Code != http.StatusCreated {
		t.Fatalf("create class: status = %d (%s)", w.Code, w.Body.String())
	}
	return decode(t, w.Body.Bytes())["id"].(string)
}

func createStudent(t *testing.T, token, classID, name, rollNumber string) string {
	t.Helper()
	w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
		`{"name":"`+name+`","roll_number":"`+rollNumber+`"}`, token)
	if w.Code != http.StatusCreated {
		t.Fatalf("create student: status = %d (%s)", w.Code, w.Body.String())
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

// createExamSubject attaches the seeded "Mathematics" Subject to the given
// Exam and returns the resulting Exam Subject's id.
func createExamSubject(t *testing.T, token, examID string) string {
	t.Helper()
	var subjectID uuid.UUID
	err := testDB.Pool.QueryRow(context.Background(),
		`SELECT id FROM subjects WHERE name = 'Mathematics'`).Scan(&subjectID)
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

func createQuestion(t *testing.T, token, examSubjectID string) string {
	t.Helper()
	w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/exam-subjects/"+examSubjectID+"/questions",
		`{"type":"open_response","maximum_marks":4,"config":{"rubric_points":["a","b"]}}`, token)
	if w.Code != http.StatusCreated {
		t.Fatalf("create question: status = %d (%s)", w.Code, w.Body.String())
	}
	return decode(t, w.Body.Bytes())["id"].(string)
}

// createAnswer bulk-uploads a single Submission for the given Student with
// one Answer to the given Question, and returns the Answer's id.
func createAnswer(t *testing.T, token, examSubjectID, studentID, questionID, rawAnswer string) string {
	t.Helper()
	body := `{"submissions":[{"student_id":"` + studentID + `","answers":[{"question_id":"` + questionID + `","raw_answer":"` + rawAnswer + `"}]}]}`
	w := testsupport.DoJSONAuth(router, http.MethodPost,
		"/api/v1/exam-subjects/"+examSubjectID+"/submissions:bulk-upload", body, token)
	if w.Code != http.StatusOK {
		t.Fatalf("bulk upload: status = %d (%s)", w.Code, w.Body.String())
	}
	subs := decode(t, w.Body.Bytes())["submissions"].([]any)
	submissionID := subs[0].(map[string]any)["id"].(string)

	w = testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/submissions/"+submissionID+"/answers", "", token)
	if w.Code != http.StatusOK {
		t.Fatalf("list answers: status = %d (%s)", w.Code, w.Body.String())
	}
	answers := decode(t, w.Body.Bytes())["answers"].([]any)
	return answers[0].(map[string]any)["id"].(string)
}

func decode(t *testing.T, b []byte) map[string]any {
	t.Helper()
	var m map[string]any
	if err := json.Unmarshal(b, &m); err != nil {
		t.Fatalf("decode: %v (%s)", err, string(b))
	}
	return m
}
