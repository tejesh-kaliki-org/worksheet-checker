-- +goose Up
-- LLM Call: a single request/response exchange with the LLM proxy (Bifrost),
-- logged locally (tokens, latency, model, Correlation ID) as a resilience
-- backup -- not a replacement for the proxy's own tracking. One Evaluation
-- Attempt may have several LLM Calls if it retries internally (see
-- CONTEXT.md).
--
-- correlation_id is denormalized alongside evaluation_attempt_id (rather
-- than implied) so this table stands on its own when cross-referencing
-- against Bifrost-side logs, without a join back to evaluation_attempts.
CREATE TABLE llm_calls (
    id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    evaluation_attempt_id UUID NOT NULL REFERENCES evaluation_attempts (id) ON DELETE CASCADE,
    correlation_id        UUID NOT NULL,
    model                 TEXT NOT NULL,
    tokens_in             INT NOT NULL,
    tokens_out            INT NOT NULL,
    cached_tokens         INT,
    thinking_tokens       INT,
    latency_ms            INT NOT NULL,
    created_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_llm_calls_evaluation_attempt_id ON llm_calls (evaluation_attempt_id);

-- +goose Down
DROP TABLE llm_calls;
