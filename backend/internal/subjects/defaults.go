package subjects

import (
	"context"

	"github.com/google/uuid"
)

// DefaultCatalogue is the starter Subject list every new User's catalogue is
// seeded with at account creation (a reasonable Indian school curriculum).
// See ADR 0009: Subjects are user-owned, not a single global catalogue, but
// every User starts from the same defaults and may add/rename/remove freely.
var DefaultCatalogue = []string{
	"Mathematics",
	"Science",
	"English",
	"Social Studies",
	"Hindi",
	"Computer Science",
	"Environmental Studies",
	"Physics",
	"Chemistry",
	"Biology",
	"History",
	"Geography",
	"Civics",
	"Economics",
	"Sanskrit",
}

// SeedDefaults creates DefaultCatalogue as owned Subjects for a newly created
// User. Intended to be called once, right after the User row is inserted
// (see internal/auth.Service.Signup). Not idempotent by design — existing
// users are never re-seeded or backfilled (see ADR 0009).
func (s *Service) SeedDefaults(ctx context.Context, ownerID uuid.UUID) error {
	for _, name := range DefaultCatalogue {
		if _, err := s.store.CreateSubject(ctx, name, ownerID); err != nil {
			return err
		}
	}
	return nil
}
