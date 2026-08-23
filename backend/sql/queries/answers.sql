-- name: UpsertAnswer :one
INSERT INTO answers (submission_id, question_id, raw_answer)
VALUES ($1, $2, $3)
ON CONFLICT (submission_id, question_id) DO UPDATE SET raw_answer = EXCLUDED.raw_answer, updated_at = now()
RETURNING *;

-- name: GetAnswerByID :one
SELECT * FROM answers WHERE id = $1;

-- name: ListAnswersBySubmission :many
SELECT * FROM answers WHERE submission_id = $1 ORDER BY created_at;

-- name: UpdateAnswer :one
UPDATE answers SET raw_answer = $2, updated_at = now() WHERE id = $1
RETURNING *;
