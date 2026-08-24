-- +goose Up
-- A Class: a group of students created and owned by exactly one User (teacher).
-- No organizational hierarchy above it (see ADR 0001).
CREATE TABLE classes (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name       TEXT NOT NULL,
    created_by UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_classes_created_by ON classes (created_by);

-- +goose Down
DROP TABLE classes;
