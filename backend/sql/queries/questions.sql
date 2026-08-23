-- name: CreateQuestion :one
INSERT INTO questions (exam_subject_id, type, config, schema_version, maximum_marks)
VALUES ($1, $2, $3, $4, $5)
RETURNING *;

-- name: ListQuestionsByExamSubject :many
SELECT * FROM questions WHERE exam_subject_id = $1 ORDER BY created_at;

-- name: GetQuestionByID :one
SELECT * FROM questions WHERE id = $1;

-- name: UpdateQuestion :one
UPDATE questions
SET type = $2, config = $3, schema_version = $4, maximum_marks = $5, updated_at = now()
WHERE id = $1
RETURNING *;

-- name: DeleteQuestion :exec
DELETE FROM questions WHERE id = $1;
