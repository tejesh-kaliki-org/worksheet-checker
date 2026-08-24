-- name: ListSubjectsByOwner :many
SELECT * FROM subjects WHERE owner_id = $1 ORDER BY name;

-- name: GetSubjectByID :one
SELECT * FROM subjects WHERE id = $1;

-- name: CreateSubject :one
INSERT INTO subjects (name, owner_id)
VALUES ($1, $2)
RETURNING *;

-- name: UpdateSubject :one
UPDATE subjects SET name = $2 WHERE id = $1
RETURNING *;

-- name: DeleteSubject :exec
DELETE FROM subjects WHERE id = $1;

-- name: BulkCreateSubjects :many
-- Idempotent by (owner_id, name): names the owner already has are skipped
-- rather than rejected (see api/services/subjects.yaml :bulk-create).
INSERT INTO subjects (name, owner_id)
SELECT DISTINCT n, sqlc.arg(owner_id)::uuid FROM unnest(sqlc.arg(names)::text[]) AS n
ON CONFLICT (owner_id, name) DO NOTHING
RETURNING *;

-- name: CountOwnedSubjectsByIDs :one
SELECT count(*) FROM subjects WHERE owner_id = sqlc.arg(owner_id) AND id = ANY(sqlc.arg(ids)::uuid[]);
