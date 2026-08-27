-- name: AddExamSubject :one
INSERT INTO exam_subjects (exam_id, subject_id)
VALUES ($1, $2)
ON CONFLICT (exam_id, subject_id) DO UPDATE SET exam_id = EXCLUDED.exam_id
RETURNING *;

-- name: ListExamSubjectsByExam :many
SELECT * FROM exam_subjects WHERE exam_id = $1 ORDER BY created_at;

-- name: GetExamSubjectByID :one
SELECT * FROM exam_subjects WHERE id = $1;
