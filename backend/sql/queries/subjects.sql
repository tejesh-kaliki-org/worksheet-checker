-- name: ListSubjectsByOwner :many
SELECT * FROM subjects WHERE owner_id = $1 ORDER BY name;

-- name: GetSubjectByID :one
SELECT * FROM subjects WHERE id = $1;

-- name: CreateSubject :one
INSERT INTO subjects (name, owner_id)
VALUES ($1, $2)
RETURNING *;
