# Open-response synthetic answer generation — handoff spec

## Why this step exists
Closed-type questions (MCQ, true/false, numeric, fill-in) have a small enough
answer space that templated variation is fine — see `*_student_responses_closed.json`.
Open-response answers don't work that way: real student writing is messy,
uses its own words, and partial understanding looks different from student to
student. Templates there would just be canned strings repeated, which
undermines the whole point of the grading benchmark. This step generates real
LLM output — ideally via your Bifrost gateway, across your 3-model comparison
— conditioned on rubric + persona, so the benchmark text is actually
realistic.

## Input
For each subject, `*_open_response_generation_tasks.json` contains a list of
tasks:
```json
{
  "question_id": "phy-018",
  "subject": "JEE Physics",
  "question_text": "...",
  "rubric_points": ["...", "...", "..."],
  "students_to_generate": [
    {"student_id": "S01", "gold_label": "correct"},
    ...
    // 7 correct, 3 incorrect_misconception, 2 boundary_or_partial,
    // 1 malformed_blank, 1 malformed_gibberish_or_offtopic  (15 total)
  ]
}
```
9 tasks total across the 3 subjects (3 open-response questions each) × 15
students = 135 answers to generate.

## Prompt template (per student_id, per task)

For `gold_label != malformed_blank` (blank needs no generation — just emit
`""` directly, don't waste a call on it):

```
You are simulating a real student's short written answer to an exam question,
for building a synthetic test set for an automated grader. Write ONLY the
answer text a student would submit — no meta-commentary, no labels.

Question: {question_text}

What a full-credit answer should cover (do not quote this back verbatim,
this is grading criteria, not phrasing to copy):
{rubric_points joined as bullets}

Write an answer that fits this student profile: {persona}

Keep it to 1-4 sentences, in a plausible student's voice — imperfect grammar
or informal phrasing is fine and expected, don't over-polish.
```

Where `{persona}` is chosen per `gold_label`:

| gold_label | persona instruction |
|---|---|
| `correct` | "a student who understood the concept well, explains it correctly but in their own words — vary explanation style/order each time (don't always start the same way)" |
| `incorrect_misconception` | "a student who has a specific, plausible misconception about this topic — pick one concrete wrong belief and write as if they're confident it's right" |
| `boundary_or_partial` | "a student who got roughly one of the rubric points right but missed or garbled the others — partial understanding, not totally wrong" |
| `malformed_gibberish_or_offtopic` | "a student who either didn't understand the question and wrote something vague/off-topic, or gave up partway ('not sure', trails off, wrong subject entirely')" |

Vary temperature (~0.8–1.0) and re-roll the "correct" and "misconception"
persona instruction per call so all 7 correct answers don't converge on
identical phrasing — real classes don't write identically.

## Execution: Claude Code sub-agents (preferred over the Bifrost route below)
Rather than wiring this into the Go project against Bifrost, this is a good
fit for Claude Code launching one sub-agent per task (or per small batch of
tasks) to write the persona-conditioned answers directly — using your Claude
subscription rather than needing an API key threaded through the pipeline.
Each of the 9 tasks (3 open-response questions × 3 subjects) can be one
sub-agent invocation; each sub-agent generates all 15 answers for its
question (14 real generations + 1 blank emitted directly, no call needed),
writes them in the output shape below, and the parent process merges the 9
results into the final `_student_responses_open.json` files.

Keep generation on a single model for this pass (don't split the 15 answers
per question across models) — see the rationale below; the three-way
comparison is a separate, later step.

## Model routing (if using Bifrost/API instead)
Reuse the three-way comparison you're already building for the actual
grading feature — generate the answer set with **one** model (pick one,
e.g. Gemini Flash-Lite for cost) rather than splitting generation across all
three. The three-way *comparison* should happen later, when you run all
three graders against this fixed answer set — mixing generation models would
confound that comparison (you wouldn't know if grading differences come from
the grader or from which model wrote the student answer).

## Output shape
Merge back into the same shape as the closed-type files so downstream code
doesn't need to special-case open-response:
```json
{
  "subject": "JEE Physics",
  "note": "...",
  "responses": [
    {"student_id": "S01", "question_id": "phy-018", "answer_text": "...", "gold_label": "correct"},
    ...
  ]
}
```
Write to `{subject_key}_student_responses_open.json`, then you have, per
subject: one answer-key file + two response files (closed, open) — or merge
closed+open into one `_student_responses.json` if that's simpler for your
grader to consume.

## Quality check before treating this as ground truth
Spot-check ~10% of generated answers against the rubric yourself (or run a
cheap LLM-as-judge pass) to confirm the gold_label actually matches — e.g. a
"correct" generation that's subtly wrong would poison your accuracy metric.
Regenerate any mismatches rather than relabeling them; you want the label to
reflect intent, and intent-mismatches usually mean the prompt undershot.
