package classes_test

import (
	"context"
	"os"
	"testing"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"

	classesgen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/classes"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/auth"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/classes"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/config"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

var (
	testDB *testsupport.TestDB
	router *gin.Engine
	tokens *auth.TokenIssuer
)

func TestMain(m *testing.M) {
	testDB = testsupport.Connect("test_classes")

	r, api := testsupport.NewRouter()
	tokens = auth.NewTokenIssuer(config.TokenConfig{Secret: "test-secret", ExpiryHours: 1})
	authSvc := auth.New(testDB.Pool, config.TokenConfig{Secret: "test-secret", ExpiryHours: 1}, noopMailer{})
	authSvc.Register(api)
	classes.New(testDB.Pool).Register(api, classesgen.MiddlewareFunc(authSvc.ScopeAuth()))
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

// createUser inserts a verified user directly (bypassing signup/verify) and
// returns its id and a valid access token, for tests that only need an
// authenticated owner.
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
