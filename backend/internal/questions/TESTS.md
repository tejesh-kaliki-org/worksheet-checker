# Tests — questions

- `TestCreateQuestion/mcq success` — creating an `mcq` Question with a valid config.
- `TestCreateQuestion/invalid mcq config rejected` — a `correct_answer` not present in `options` → 400.
- `TestCreateQuestion/open_response success` — creating an `open_response` Question.
- `TestCreateQuestion/not_found for another owner's exam subject` — the Exam Subject belongs to a different User's Class (walking Exam Subject -> Exam -> Class -> owner) → 404.
- `TestListQuestions/success` — lists the Questions under the caller's own Exam Subject.
- `TestListQuestions/empty is [], not null` — an Exam Subject with no Questions returns `"questions":[]`, never `null`.
- `TestListQuestions/not_found for another owner's exam subject` — listing under an Exam Subject owned by a different User 404s.
- `TestGetUpdateDeleteQuestion` — the full lifecycle for one Question: get, update (config + maximum_marks change persists), delete, then get 404s.
- `TestGetUpdateDeleteQuestion_notFound/get 404s for another owner's exam subject` — ownership boundary on GetQuestion.
- `TestGetUpdateDeleteQuestion_notFound/update 404s for another owner's exam subject` — ownership boundary on UpdateQuestion.
- `TestGetUpdateDeleteQuestion_notFound/delete 404s for another owner's exam subject` — ownership boundary on DeleteQuestion.
- `TestGetUpdateDeleteQuestion_notFound/get 404s for a question id from a different exam subject` — a Question that exists but belongs to a sibling Exam Subject (same owner) still 404s: Questions are scoped to one Exam Subject, never reused (ADR 0003).
- `TestUpdateQuestion_validation` — an invalid type-specific config on update → 400, mirroring the create-time validation.
