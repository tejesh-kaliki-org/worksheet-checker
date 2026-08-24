-- name: CreateClass :one
INSERT INTO classes (name, created_by)
VALUES ($1, $2)
RETURNING *;

-- name: ListClassesByOwner :many
SELECT * FROM classes WHERE created_by = $1 ORDER BY created_at DESC;

-- name: GetClassByID :one
SELECT * FROM classes WHERE id = $1;

-- name: UpdateClass :one
UPDATE classes SET name = $2, updated_at = now() WHERE id = $1
RETURNING *;

-- name: DeleteClass :exec
DELETE FROM classes WHERE id = $1;
