-- +goose Up
-- Submission: one Student's complete set of Answers for one Exam Subject,
-- created in bulk by the teacher, not entered by the student directly (see
-- CONTEXT.md). One Submission per Student x Exam Subject.
CREATE TABLE submissions (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    exam_subject_id UUID NOT NULL REFERENCES exam_subjects (id) ON DELETE CASCADE,
    student_id      UUID NOT NULL REFERENCES students (id) ON DELETE CASCADE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (exam_subject_id, student_id)
);

CREATE INDEX idx_submissions_exam_subject_id ON submissions (exam_subject_id);
CREATE INDEX idx_submissions_student_id ON submissions (student_id);

-- +goose Down
DROP TABLE submissions;
