-- +goose Up
-- A Student: a minimal identity record scoped to a single Class (see ADR
-- 0002 — no cross-class identity). Roll Number correlates Answers back to a
-- Student without exposing their name, and is unique within the Class.
CREATE TABLE students (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    class_id    UUID NOT NULL REFERENCES classes (id) ON DELETE CASCADE,
    name        TEXT NOT NULL,
    roll_number TEXT NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (class_id, roll_number)
);

CREATE INDEX idx_students_class_id ON students (class_id);

-- +goose Down
DROP TABLE students;
