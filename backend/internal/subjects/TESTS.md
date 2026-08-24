# Tests — subjects

- `TestListSubjects/success` — an authenticated User sees their own (seeded) Subject catalogue.
- `TestListSubjects/authorization` — no bearer token → 401.

## Known gap (tracked, not yet implemented)

The `subjects` package currently only implements `GET /subjects` (list). Create/update/delete/bulk-create for Subjects, and their ownership-chain 404 tests, uniqueness-conflict tests, and empty-list-not-null tests, are **not yet implemented** — see the issue-4-academic-structure follow-up work.
