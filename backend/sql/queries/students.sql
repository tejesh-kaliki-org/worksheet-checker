-- name: CreateStudent :one
INSERT INTO students (class_id, name, roll_number)
VALUES ($1, $2, $3)
RETURNING *;

-- name: ListStudentsByClass :many
SELECT * FROM students WHERE class_id = $1 ORDER BY roll_number;

-- name: GetStudentByID :one
SELECT * FROM students WHERE id = $1;

-- name: UpdateStudent :one
UPDATE students SET name = $2, roll_number = $3, updated_at = now() WHERE id = $1
RETURNING *;

-- name: DeleteStudent :exec
DELETE FROM students WHERE id = $1;

-- name: BulkCreateStudents :many
-- One statement, so the roster upload is all-or-nothing: any Roll Number
-- collision aborts the whole insert.
INSERT INTO students (class_id, name, roll_number)
SELECT sqlc.arg(class_id), n.name, r.roll_number
FROM unnest(sqlc.arg(names)::text[]) WITH ORDINALITY AS n(name, i)
JOIN unnest(sqlc.arg(roll_numbers)::text[]) WITH ORDINALITY AS r(roll_number, i) USING (i)
RETURNING *;
