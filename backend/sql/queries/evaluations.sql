-- name: CreateEvaluation :one
INSERT INTO evaluations (evaluation_attempt_id, raw_score, marks, feedback)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: GetEvaluationByAttemptID :one
SELECT * FROM evaluations WHERE evaluation_attempt_id = $1;

-- name: GetLatestScoringEvaluationByAnswer :one
SELECT evaluations.*
FROM evaluations
JOIN evaluation_attempts ON evaluation_attempts.id = evaluations.evaluation_attempt_id
WHERE evaluation_attempts.answer_id = $1
  AND evaluation_attempts.purpose = 'scoring'
ORDER BY evaluations.created_at DESC
LIMIT 1;
