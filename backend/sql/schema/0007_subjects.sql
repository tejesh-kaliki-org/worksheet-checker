-- +goose Up
-- Subject: part of a User's own curriculum catalogue (see ADR 0009 — Subjects
-- are user-owned, not a single global catalogue). Seeded with a reasonable
-- Indian school curriculum list at account creation; user-editable thereafter.
CREATE TABLE subjects (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name       TEXT NOT NULL,
    owner_id   UUID NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (owner_id, name)
);

CREATE INDEX idx_subjects_owner_id ON subjects (owner_id);

-- +goose Down
DROP TABLE subjects;
