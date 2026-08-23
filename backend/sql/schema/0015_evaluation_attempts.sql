-- +goose Up
-- Evaluation Attempt: one try at having the AI grade an Answer. Carries a
-- status, an optional error, and a Purpose (`scoring` counts toward the
-- Student's real grade; `experiment` never does -- see CONTEXT.md and
-- ADR 0007). Failed attempts leave no Evaluation (see 0016_evaluations.sql).
--
-- The Attempt's own id doubles as the Correlation ID passed to Bifrost (the
-- LLM proxy) -- an opaque identifier that is never the Student's name or
-- Roll Number (see ADR 0006). No separate correlation_id column is needed.
CREATE TYPE evaluation_attempt_status AS ENUM (
    'pending',
    'running',
    'succeeded',
    'failed'
);

CREATE TYPE evaluation_purpose AS ENUM (
    'scoring',
    'experiment'
);

CREATE TABLE evaluation_attempts (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    answer_id  UUID NOT NULL REFERENCES answers (id) ON DELETE CASCADE,
    status     evaluation_attempt_status NOT NULL DEFAULT 'pending',
    purpose    evaluation_purpose NOT NULL DEFAULT 'scoring',
    error      TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_evaluation_attempts_answer_id ON evaluation_attempts (answer_id);

-- +goose Down
DROP TABLE evaluation_attempts;
DROP TYPE evaluation_purpose;
DROP TYPE evaluation_attempt_status;
