-- name: CreateStudent :one
INSERT INTO students (class_id, name, roll_number)
VALUES ($1, $2, $3)
RETURNING *;

-- name: ListStudentsByClass :many
SELECT * FROM students WHERE class_id = $1 ORDER BY roll_number;

-- name: GetStudentByID :one
SELECT * FROM students WHERE id = $1;

-- name: UpdateStudent :one
UPDATE students SET name = $2, roll_number = $3, updated_at = now() WHERE id = $1
RETURNING *;

-- name: DeleteStudent :exec
DELETE FROM students WHERE id = $1;
