-- name: CreateExam :one
INSERT INTO exams (class_id, label)
VALUES ($1, $2)
RETURNING *;

-- name: ListExamsByClass :many
SELECT * FROM exams WHERE class_id = $1 ORDER BY created_at DESC;

-- name: GetExamByID :one
SELECT * FROM exams WHERE id = $1;
