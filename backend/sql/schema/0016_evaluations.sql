-- +goose Up
-- Evaluation: the AI's judgment for one successful Evaluation Attempt -- a
-- Raw Score, the resulting Marks, and Feedback. 1:1 with a successful
-- Attempt; never mutated after creation (a re-grade is a new Evaluation
-- Attempt, not an edit -- see CONTEXT.md).
--
-- `breakdown` is reserved unused per ADR 0005 (holistic scoring, not
-- rubric-based, for v1) -- no code in this migration's domain reads or
-- writes it.
CREATE TABLE evaluations (
    id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    evaluation_attempt_id UUID NOT NULL UNIQUE
        REFERENCES evaluation_attempts (id) ON DELETE CASCADE,
    raw_score             NUMERIC(3, 2) NOT NULL CHECK (raw_score >= 0 AND raw_score <= 1),
    marks                 NUMERIC(6, 2) NOT NULL,
    feedback              TEXT NOT NULL,
    breakdown             JSONB,
    created_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- +goose Down
DROP TABLE evaluations;
