# CLAUDE.md

Guidance for AI agents working in Worksheet Checker.

## Stack

- `backend/` — Go HTTP server (gin + pgx). One package per domain under `internal/`.
- `api/` — OpenAPI specs; the contract is the source of truth. Update the spec first.
- `frontend/` — Flutter (Riverpod + GoRouter). Always use the Riverpod generator.

## Order of operations for API changes

1. Update `api/services/*.yaml`.
2. Implement the backend handler in `internal/<domain>`.
3. Register routes in `internal/server/server.go`.
4. Regenerate the Dart client, then build the UI.

Every operation must declare every status code its handler can actually return, using the shared error-response `$ref`s (`NotFound`, `Conflict`, `BadRequest`, etc.) rather than ad hoc inline response bodies.

## Conventions

- Verify backend changes with `go test ./...`, not just `go build`.
- Migrations are goose-style files in `backend/sql/schema`, applied on startup.
- Observability is always-on with a no-op default — never gate it behind a flag.
- Every service test file must cover **at minimum**: the happy path, each 404 branch in the ownership chain, input-validation failures, and collection-endpoint edge cases (empty list, not null). Treat this as a floor, not a ceiling — add whatever additional scenarios are specific and meaningful to that handler's actual logic (e.g. uniqueness constraints, conflict/dependent-data checks, idempotency). Each domain's test package includes a short `TESTS.md` listing every test function with a one-line description of the scenario it covers, so coverage is reviewable at a glance.

See `TEMPLATE_NOTES.md` for how domains are wired.
