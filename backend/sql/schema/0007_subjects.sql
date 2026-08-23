-- +goose Up
-- Subject: the global, fixed curriculum catalogue, shared across all Classes.
-- Seeded with a reasonable Indian school curriculum list; not user-editable.
CREATE TABLE subjects (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name       TEXT NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO subjects (name) VALUES
    ('Mathematics'),
    ('Science'),
    ('English'),
    ('Social Studies'),
    ('Hindi'),
    ('Computer Science'),
    ('Environmental Studies'),
    ('Physics'),
    ('Chemistry'),
    ('Biology'),
    ('History'),
    ('Geography'),
    ('Civics'),
    ('Economics'),
    ('Sanskrit');

-- +goose Down
DROP TABLE subjects;
