-- name: CreateLLMCall :one
INSERT INTO llm_calls (
    evaluation_attempt_id, correlation_id, model, tokens_in, tokens_out,
    cached_tokens, thinking_tokens, latency_ms
)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
RETURNING *;

-- name: ListLLMCallsByAttempt :many
SELECT * FROM llm_calls WHERE evaluation_attempt_id = $1 ORDER BY created_at;
