-- +goose Up
-- Answer: a single Student response to a single Question, belonging to a
-- Submission (see CONTEXT.md). One Answer per Question per Submission.
-- `raw_answer` stores the student's raw answer text/data for that Question,
-- verbatim as entered by the teacher during bulk upload -- interpretation
-- against the Question's Type/Config happens at Evaluation time, not here.
CREATE TABLE answers (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    submission_id UUID NOT NULL REFERENCES submissions (id) ON DELETE CASCADE,
    question_id   UUID NOT NULL REFERENCES questions (id) ON DELETE CASCADE,
    raw_answer    TEXT NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (submission_id, question_id)
);

CREATE INDEX idx_answers_submission_id ON answers (submission_id);

-- +goose Down
DROP TABLE answers;
