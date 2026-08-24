# Tests — exams

- `TestCreateExam/success` — an authenticated owner creates an Exam under their own Class.
- `TestCreateExam/not_found for another owner's class` — a Class owned by a different User 404s (ownership boundary, never 403).
- `TestCreateExam/validation` — a blank `label` → 400.
- `TestListExams/success` — lists the Exams under the caller's own Class.
- `TestListExams/empty is [], not null` — a Class with no Exams returns `"exams":[]`, never `null`.
- `TestListExams/not_found for another owner's class` — listing under a Class owned by a different User 404s.
- `TestGetExam/success` — fetching a single Exam by id.
- `TestGetExam/not_found` — a random UUID 404s.
- `TestAddExamSubject/success` — attaching the caller's own Subject to their own Exam.
- `TestAddExamSubject/not_found for another owner's exam` — the Exam belongs to a different User's Class → 404.
- `TestAddExamSubject/not_found for a subject owned by another user` — Subjects are a per-user catalogue (ADR 0009): attaching a Subject owned by a different User 404s exactly like a missing one, and is never attachable.
- `TestAddExamSubject/not_found for an unknown subject` — a random UUID as `subject_id` → 404.
- `TestListExamSubjects/success` — lists the Exam Subjects attached to the caller's Exam.
- `TestListExamSubjects/empty is [], not null` — an Exam with no Exam Subjects returns `"exam_subjects":[]`, never `null`.
- `TestListExamSubjects/not_found for another owner's exam` — listing under an Exam owned by a different User's Class 404s.
