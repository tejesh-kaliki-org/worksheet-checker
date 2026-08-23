# No question pre-processing model in v1

Status: accepted

No table or stub is reserved for question pre-processing (e.g. precomputed embeddings, decomposed rubric criteria) aimed at future cost/latency optimization. Designing that shape now would mean guessing at an optimization technique that hasn't been chosen yet. Revisit once a specific pre-processing optimization is actually being implemented — design the table then, against the real requirement, rather than against a placeholder.
