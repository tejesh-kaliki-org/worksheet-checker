# Holistic 0.00-1.00 Raw Score in v1, rubric-based partial credit deferred

Status: accepted

`Evaluation.raw_score` is a single holistic 0.00–1.00 judgment of an Answer's correctness, not a per-criterion rubric breakdown (e.g. formula correct vs. units present vs. final value correct, each worth its own points). A criteria-based model would require designing rubric authoring (who defines criteria, at what granularity, for which Question Types) — a larger feature than the current data-modeling scope. `Evaluation.breakdown` (nullable JSONB) is reserved unused specifically so this can be added later without a breaking migration; when built, it is expected to store points already scaled to the Question's Maximum Marks (not 0–1), since the grading prompt will carry that context. Revisit when showing step-wise partial credit becomes a real requirement rather than a hypothetical.
