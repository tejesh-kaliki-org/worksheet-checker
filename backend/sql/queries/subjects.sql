-- name: ListSubjects :many
SELECT * FROM subjects ORDER BY name;

-- name: GetSubjectByID :one
SELECT * FROM subjects WHERE id = $1;
