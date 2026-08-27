# Tests — evaluations

- `TestCreateEvaluationAttempt/success grades the answer and persists an Evaluation` — a successful Bifrost grading call produces a `succeeded` Attempt with an Evaluation (`raw_score`, `marks = raw_score * Question.maximum_marks`, `feedback`).
- `TestCreateEvaluationAttempt/bifrost failure records a failed attempt, not a 500` — a Bifrost error is recorded as a `failed` Attempt with a non-empty `error`, and the endpoint still responds 200 (the Attempt's terminal status is the payload, per CONTEXT.md).
- `TestCreateEvaluationAttempt/respects an explicit experiment purpose` — passing `{"purpose":"experiment"}` is honored in the response.
- `TestCreateEvaluationAttempt/malformed request body is rejected` — invalid JSON in the request body → 400.
- `TestCreateEvaluationAttempt/answer belonging to another user's class is not found` — the Answer belongs to a different User (walking Answer -> Submission -> Exam Subject -> Exam -> Class -> owner) → 404.
- `TestCreateEvaluationAttempt/unknown answer id is not found` — a random UUID as `answerId` → 404.
- `TestListAndGetEvaluationAttempts/list and get round-trip a created attempt` — listing and getting a single created Attempt returns matching data.
- `TestListAndGetEvaluationAttempts/list is [], not null, when the Answer has no attempts yet` — an Answer with no Evaluation Attempts returns `"evaluation_attempts":[]`, never `null`.
- `TestListAndGetEvaluationAttempts/get 404s for an unknown attempt id` — a random UUID as `attemptId` → 404.
- `TestListAndGetEvaluationAttempts/get 404s for an attempt id from a different answer` — an Attempt that exists but belongs to a sibling Answer still 404s when addressed through the wrong Answer: Attempts are scoped to one Answer, never reused.
- `TestListAndGetEvaluationAttempts/get for another user's answer is not found` — both `GET .../evaluation-attempts/{id}` and `GET .../evaluation-attempts` 404 for a different User's Answer (ownership boundary, never 403).
