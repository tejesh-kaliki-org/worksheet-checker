-- name: UpsertSubmission :one
INSERT INTO submissions (exam_subject_id, student_id)
VALUES ($1, $2)
ON CONFLICT (exam_subject_id, student_id) DO UPDATE SET exam_subject_id = EXCLUDED.exam_subject_id
RETURNING *;

-- name: ListSubmissionsByExamSubject :many
SELECT * FROM submissions WHERE exam_subject_id = $1 ORDER BY created_at;

-- name: GetSubmissionByID :one
SELECT * FROM submissions WHERE id = $1;
