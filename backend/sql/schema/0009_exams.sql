-- +goose Up
-- Exam: a term-based assessment event belonging to a Class, spanning one or
-- more Subjects (see CONTEXT.md).
CREATE TABLE exams (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    class_id   UUID NOT NULL REFERENCES classes (id) ON DELETE CASCADE,
    label      TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_exams_class_id ON exams (class_id);

-- +goose Down
DROP TABLE exams;
