# Worksheet Checker

An AI-assisted grading platform: teachers organize students into classes, run exams against a fixed subject catalogue, and have student answers evaluated by an LLM behind a proxy, with human oversight to override the machine's grade.

## Language

### Academic structure

**Class**:
A group of students created and owned by exactly one teacher (`User`). Has no organizational hierarchy above it.
_Avoid_: Section, batch, cohort

**Student**:
A minimal identity record scoped to a single Class — a name and a Roll Number, nothing more. A student in two different Classes is two unrelated Student records.
_Avoid_: Learner, pupil, candidate

**Roll Number**:
A student's identifier within their Class, used to correlate Answers back to a Student without exposing their name.
_Avoid_: Student ID, admission number

**Subject**:
An entry in a User's own curriculum catalogue (e.g. Mathematics, Science), scoped to the User who owns it — not shared globally. Seeded with a default Indian-curriculum list at account creation; the owning User may add, rename, or remove entries from there. A Class selects which of its owner's Subjects apply to it (see ADR 0009).
_Avoid_: Course, paper (paper is reserved for the exam-instance sense, see Exam Subject)

**Exam**:
A term-based assessment event belonging to a Class, spanning one or more Subjects.
_Avoid_: Test, assessment (unless referring to the general activity, not the record)

**Exam Subject**:
The pairing of one Exam with one Subject it covers. Each Exam Subject owns its own catalogue of Questions — the same Subject in two different Exams has two independent sets of Questions.
_Avoid_: Paper, section

**Question**:
A single graded item within an Exam Subject, with a Type, a type-specific Config, and a maximum Marks value. Scoped directly to its Exam Subject — not reused across Exams.
_Avoid_: Item, prompt (prompt is reserved for LLM input construction)

**Question Type**:
The fixed shape of a Question's expected answer: `mcq`, `true_false`, `numeric`, `fill_in`, or `open_response`.

**Maximum Marks**:
The ceiling a Question is worth — the score a perfect Answer would earn. Fixed per Question. Distinct from Marks (what a specific Answer actually earned).
_Avoid_: Marks (Marks is reserved for the achieved score, not the ceiling), max score, total marks

### Answering

**Submission**:
One Student's complete set of Answers for one Exam Subject, created in bulk by the teacher (not entered by the student directly).
_Avoid_: Attempt (Attempt is reserved for Evaluation Attempt), paper, script

**Answer**:
A single Student response to a single Question, belonging to a Submission. The unit that Evaluation operates on.
_Avoid_: Response

### Evaluation

**Evaluation Attempt**:
One try at having the AI grade an Answer. Carries a status, an optional error, and a Purpose. Failed attempts leave no Evaluation.
_Avoid_: Evaluation run, grading job

**Purpose**:
Marks whether an Evaluation Attempt counts toward a Student's real grade (`scoring`) or exists only for offline comparison — different models, different pipeline versions, different feedback quality — without ever affecting Effective Marks or Feedback (`experiment`). Comparing Feedback quality across `experiment` attempts is itself a core showcase goal of this project, not a side effect.
_Avoid_: Mode, type (too generic; Purpose is the canonical term)

**Evaluation**:
The AI's judgment for one successful Evaluation Attempt: a Raw Score, the resulting Marks, and Feedback. Never mutated after creation — a re-grade is a new Evaluation Attempt, not an edit.
_Avoid_: Grade, result, score (score alone is ambiguous between Raw Score and Marks)

**Raw Score**:
The AI's normalized judgment of an Answer's correctness, on a 0.00–1.00 scale, independent of the Question's Maximum Marks.
_Avoid_: AI score, confidence

**Marks**:
The score a specific Answer actually earned — `Raw Score × Question.Maximum Marks` from the governing Evaluation, unless superseded by an Evaluation Override's own Marks. Distinct from Maximum Marks (the ceiling).
_Avoid_: Awarded marks, final score, grade

**Evaluation Override**:
A teacher's manual correction, recording the Marks and/or Feedback they've decided an Answer should have. Recorded alongside the Evaluation it corrects, never replacing or editing it — both remain visible. In the UI, Override Feedback is pre-filled with the Evaluation's own Feedback for the teacher to edit, not entered blank.
_Avoid_: Correction, manual grade

**Feedback**:
Targeted, student-facing prose explaining why an Answer earned its Raw Score — not just correct/incorrect, but what the Answer got right or wrong and why. Produced alongside Raw Score by the same Evaluation Attempt; optionally supplied on an Evaluation Override, which then supersedes the Evaluation's Feedback the same way Override Marks supersede Evaluation Marks (i.e. it resolves into Effective Marks' companion value the same way — no separate "Effective Feedback" term is needed). Present for every Question Type, including objective ones like MCQ, though option-specific misconception feedback is not yet in scope.
_Avoid_: Comment, explanation, notes

**Effective Marks**:
The Marks that actually count for a Student: the latest Evaluation Override's Marks if one exists, otherwise the latest `scoring`-Purpose Evaluation's Marks.

**Evaluation Batch**:
A grouping of Answers submitted together to the LLM proxy for cost-efficient processing. An infrastructure concern, decoupled from the academic structure — unrelated to Exam, Submission, or Class boundaries.
_Avoid_: Job batch, queue

**Answer Event**:
One entry in the append-only history of everything that has happened to an Answer (submitted, attempt started, attempt failed, evaluation completed, override applied). The narrative log, distinct from the structured Evaluation Attempt / Evaluation / Evaluation Override records themselves.
_Avoid_: Audit log entry, activity

**Correlation ID**:
An opaque identifier minted by this project — never a Student's name or Roll Number — passed to the LLM proxy to link multiple LLM Calls back to the same Evaluation Attempt. Doubles as the PII-safety boundary and the pipeline-timing correlation key.
_Avoid_: Trace ID (reserved for OpenTelemetry's own trace/span identifiers — this project already has OTel wired in, and reusing "trace" here would conflate two unrelated identifier spaces), request ID

**LLM Call**:
A single request/response exchange with the LLM proxy, logged locally (tokens, latency, model, Correlation ID) as a resilience backup — not a replacement for the proxy's own tracking. One Evaluation Attempt may have several LLM Calls if it retries internally.
_Avoid_: LLM request, API call
