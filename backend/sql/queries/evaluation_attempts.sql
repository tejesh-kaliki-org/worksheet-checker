-- name: CreateEvaluationAttempt :one
INSERT INTO evaluation_attempts (answer_id, purpose)
VALUES ($1, $2)
RETURNING *;

-- name: GetEvaluationAttemptByID :one
SELECT * FROM evaluation_attempts WHERE id = $1;

-- name: UpdateEvaluationAttemptStatus :one
UPDATE evaluation_attempts SET status = $2, error = $3, updated_at = now()
WHERE id = $1
RETURNING *;

-- name: ListEvaluationAttemptsByAnswer :many
SELECT * FROM evaluation_attempts WHERE answer_id = $1 ORDER BY created_at DESC;
