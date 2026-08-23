-- +goose Up
-- Exam Subject: the pairing of one Exam with one Subject it covers. Each Exam
-- Subject owns its own catalogue of Questions -- the same Subject in two
-- different Exams has two independent sets of Questions (see CONTEXT.md and
-- ADR 0003 -- no reusable question bank).
CREATE TABLE exam_subjects (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    exam_id    UUID NOT NULL REFERENCES exams (id) ON DELETE CASCADE,
    subject_id UUID NOT NULL REFERENCES subjects (id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (exam_id, subject_id)
);

CREATE INDEX idx_exam_subjects_exam_id ON exam_subjects (exam_id);

-- +goose Down
DROP TABLE exam_subjects;
