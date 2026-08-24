package subjects_test

import (
	"context"
	"os"
	"testing"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"

	subjectsgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/subjects"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/auth"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/config"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/subjects"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

var (
	testDB *testsupport.TestDB
	router *gin.Engine
	tokens *auth.TokenIssuer
)

func TestMain(m *testing.M) {
	testDB = testsupport.Connect("test_subjects")

	r, api := testsupport.NewRouter()
	tokens = auth.NewTokenIssuer(config.TokenConfig{Secret: "test-secret", ExpiryHours: 1})
	authSvc := auth.New(testDB.Pool, config.TokenConfig{Secret: "test-secret", ExpiryHours: 1}, noopMailer{}, nil)
	authSvc.Register(api)
	subjects.New(testDB.Pool).Register(api, subjectsgen.MiddlewareFunc(authSvc.ScopeAuth()))
	router = r

	os.Exit(m.Run())
}

type noopMailer struct{}

func (noopMailer) SendVerification(context.Context, string, string) error  { return nil }
func (noopMailer) SendPasswordReset(context.Context, string, string) error { return nil }

func setupTest(t *testing.T) {
	t.Helper()
	// Subjects cascade-delete with their owning user (owner_id ON DELETE
	// CASCADE), so truncating users is enough to reset both.
	if _, err := testDB.Pool.Exec(context.Background(), `TRUNCATE users CASCADE`); err != nil {
		t.Fatalf("truncate users: %v", err)
	}
}

// createUser inserts a verified user directly (bypassing signup) and seeds
// its default Subject catalogue the same way auth.Service.Signup does (see
// ADR 0009), since tests need Subjects without going through the full
// signup flow.
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

// createBareUser inserts a verified user WITHOUT seeding a default catalogue,
// for tests that need to observe an empty Subject list.
func createBareUser(t *testing.T, email string) (uuid.UUID, string) {
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
