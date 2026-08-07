# Sample data — Worksheet & Quiz Answer Checker

Synthetic benchmark data for testing the grading pipeline. All questions are
original — written in the style of JEE (Physics/Mathematics) and CBSE Class
10 Science exams, using public NCERT/syllabus topic names, but no verbatim
content from real NTA/CBSE papers. This keeps the published repo copyright-
clean and honors the synthetic-data-only constraint.

## Contents (per subject: jee_physics, jee_mathematics, cbse_science)

- `{subject}_answer_key.json` — 20 questions, mixed types (6 MCQ, 4 true/false,
  4 numeric, 3 fill-in, 3 open-response), each with a scoring answer key
  (exact answer + accepted variants for closed types, a rubric for
  open-response, and distractor reasoning for MCQ).
- `{subject}_student_responses_closed.json` — 15 simulated responses per
  closed-type question (mcq/true_false/numeric/fill_in), template-generated
  since the answer space is small enough that formatting variation is the
  main realism concern.
- `{subject}_open_response_generation_tasks.json` — the generation spec for
  the 3 open-response questions per subject; see
  `OPEN_RESPONSE_GENERATION_HANDOFF.md` for how to actually fill these in via
  an LLM (Bifrost gateway) rather than templates, since templated free-text
  answers would be unrealistic in a way that undermines the benchmark.

## Response distribution (documented, fixed)
Every question gets exactly 15 simulated student responses in this split:
- 8 correct (phrasing/format variants)
- 3 incorrect via a specific, named misconception
- 2 boundary/format-edge-case (or partial-credit for open-response)
- 1 blank
- 1 gibberish / off-topic

Each response carries a `gold_label` — this is the ground truth for scoring
grader accuracy, NOT input to the grader under test. It's what turns this
from "some test data" into an actual measurable accuracy/before-after number
for the project writeup, and gives you labeled retry-worthy cases (blank,
gibberish, boundary) to point to as the documented failure mode.

## Totals
60 questions across 3 subjects (20 each: 6 MCQ, 4 true/false, 4 numeric,
3 fill-in, 3 open-response). 51 closed-type questions × 15 responses = 765
responses already generated here. 9 open-response questions × 15 = 135
answers to be generated per the handoff spec. 900 student responses total
once that step is done.

## Not included here (by design)
A private benchmark of real JEE/CBSE past-paper questions, for validating
against real exam data. Source these directly from NTA's/CBSE's own official
released past papers, keep them in a gitignored local-only folder, and never
commit or quote them in the public repo, README, or any blog/LinkedIn post —
only aggregate accuracy numbers from that benchmark are safe to publish.
