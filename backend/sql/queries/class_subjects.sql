-- name: AddClassSubject :one
INSERT INTO class_subjects (class_id, subject_id)
VALUES ($1, $2)
ON CONFLICT (class_id, subject_id) DO UPDATE SET class_id = EXCLUDED.class_id
RETURNING *;

-- name: RemoveClassSubject :exec
DELETE FROM class_subjects WHERE class_id = $1 AND subject_id = $2;

-- name: ListSubjectsByClass :many
SELECT s.* FROM subjects s
JOIN class_subjects cs ON cs.subject_id = s.id
WHERE cs.class_id = $1
ORDER BY s.name;
