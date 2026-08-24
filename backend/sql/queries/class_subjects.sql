-- name: RemoveClassSubject :exec
DELETE FROM class_subjects WHERE class_id = $1 AND subject_id = $2;

-- name: ListSubjectsByClass :many
SELECT s.* FROM subjects s
JOIN class_subjects cs ON cs.subject_id = s.id
WHERE cs.class_id = $1
ORDER BY s.name;

-- name: CountClassSubjectsBySubject :one
SELECT count(*) FROM class_subjects WHERE subject_id = $1;

-- name: BulkAddClassSubjects :exec
-- One statement, so the whole selection lands atomically. Already-selected
-- Subjects are left alone rather than erroring.
INSERT INTO class_subjects (class_id, subject_id)
SELECT sqlc.arg(class_id), s FROM unnest(sqlc.arg(subject_ids)::uuid[]) AS s
ON CONFLICT (class_id, subject_id) DO NOTHING;
