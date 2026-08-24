// Package auth is a kept (non-example) module: concrete users schema, JWT
// signup/login, email verification and password reset, backed by sqlc queries.
package auth

import (
	"context"
	"log"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"
	openapi_types "github.com/oapi-codegen/runtime/types"

	gen "github.com/tejesh-kaliki/worksheet-checker/backend/gen/api/auth"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/config"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/mail"
)

// SubjectSeeder seeds a newly created User's default Subject catalogue. See
// internal/subjects.Service.SeedDefaults and ADR 0009.
type SubjectSeeder interface {
	SeedDefaults(ctx context.Context, ownerID uuid.UUID) error
}

type Service struct {
	store      Store
	tokens     *TokenIssuer
	refreshTTL time.Duration
	mailer     mail.Mailer
	subjects   SubjectSeeder
}

func refreshTTL(cfg config.TokenConfig) time.Duration {
	h := cfg.RefreshExpiryHours
	if h == 0 {
		h = 720 // 30 days
	}
	return time.Duration(h) * time.Hour
}

func New(pool *pgxpool.Pool, cfg config.TokenConfig, mailer mail.Mailer, subjects SubjectSeeder) *Service {
	return &Service{
		store:      NewStore(pool),
		tokens:     NewTokenIssuer(cfg),
		refreshTTL: refreshTTL(cfg),
		mailer:     mailer,
		subjects:   subjects,
	}
}

// Register mounts the generated routes under the given router group, guarding
// them with ScopeAuth so the OpenAPI `security` blocks decide what needs a token.
func (s *Service) Register(r gin.IRouter) {
	gen.RegisterHandlersWithOptions(r, s, gen.GinServerOptions{
		Middlewares: []gen.MiddlewareFunc{gen.MiddlewareFunc(s.ScopeAuth())},
	})
}

// Signup implements gen.ServerInterface.
func (s *Service) Signup(c *gin.Context) {
	var body gen.SignupJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if body.Email == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "email is required"})
		return
	}
	if err := ValidatePassword(body.Password); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	hash, err := HashPassword(body.Password)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not hash password"})
		return
	}

	name := ""
	if body.Name != nil {
		name = *body.Name
	}

	user, err := s.store.CreateUser(c.Request.Context(), database.CreateUserParams{
		Email:        string(body.Email),
		PasswordHash: hash,
		Name:         name,
		Role:         "user",
	})
	if err != nil {
		c.JSON(http.StatusConflict, gin.H{"error": "email already registered"})
		return
	}

	// Seed the new User's default Subject catalogue (ADR 0009). Best-effort:
	// an empty catalogue is recoverable (the user can add Subjects later) so
	// this never fails signup, only logs.
	if s.subjects != nil {
		if err := s.subjects.SeedDefaults(c.Request.Context(), user.ID); err != nil {
			log.Printf("auth: seed default subjects for user %s: %v", user.ID, err)
		}
	}

	// Account starts unverified. Issue a verification credential and email it.
	// The credential is NEVER returned in the response.
	credential, err := s.issueVerification(c.Request.Context(), user.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not issue verification"})
		return
	}
	s.sendVerification(c.Request.Context(), user.Email, credential)

	// No session yet: hand back only a short-lived token that scopes the OTP
	// the user just received. They redeem both at POST /auth/verify.
	verificationToken, err := s.tokens.IssueVerification(user.ID.String())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "could not issue verification token"})
		return
	}
	c.JSON(http.StatusCreated, gen.SignupResponse{
		User:              toAPIUser(user),
		VerificationToken: verificationToken,
	})
}

// Login implements gen.ServerInterface.
func (s *Service) Login(c *gin.Context) {
	var body gen.LoginJSONRequestBody
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if body.Email == "" || body.Password == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "email and password are required"})
		return
	}

	user, err := s.store.GetUserByEmail(c.Request.Context(), string(body.Email))
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "invalid credentials"})
		return
	}
	if !CheckPassword(user.PasswordHash, body.Password) {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "invalid credentials"})
		return
	}

	s.respondWithSession(c, http.StatusOK, user)
}

func toAPIUser(u database.User) gen.User {
	created := u.CreatedAt
	return gen.User{
		Id:        u.ID,
		Email:     openapi_types.Email(u.Email),
		Name:      u.Name,
		Role:      u.Role,
		CreatedAt: &created,
		Verified:  &u.Verified,
	}
}
