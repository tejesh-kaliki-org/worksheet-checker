-- +goose Up
-- Question: a single graded item within an Exam Subject, with a Type, a
-- type-specific Config, and a Maximum Marks value. Scoped directly to its
-- Exam Subject -- not reused across Exams (see CONTEXT.md and ADR 0003).
--
-- `config` is JSONB whose shape is discriminated by `type`; `schema_version`
-- is reserved for future config migrations. All reads/writes of `config` go
-- through internal/questionconfig -- never ad hoc elsewhere (see ADR context
-- in docs/grading-domain-model.md, point 4).
CREATE TYPE question_type AS ENUM (
    'mcq',
    'true_false',
    'numeric',
    'fill_in',
    'open_response'
);

CREATE TABLE questions (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    exam_subject_id UUID NOT NULL REFERENCES exam_subjects (id) ON DELETE CASCADE,
    type            question_type NOT NULL,
    config          JSONB NOT NULL,
    schema_version  INT NOT NULL DEFAULT 1,
    maximum_marks   NUMERIC(6, 2) NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_questions_exam_subject_id ON questions (exam_subject_id);

-- +goose Down
DROP TABLE questions;
DROP TYPE question_type;
