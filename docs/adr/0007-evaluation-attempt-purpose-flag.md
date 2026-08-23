# Evaluation Attempts carry an explicit scoring/experiment Purpose

Status: accepted

`evaluation_attempts.purpose` is `scoring` (default) or `experiment`. Only `scoring`-Purpose Evaluations ever determine a Student's Effective Marks; `experiment`-Purpose Evaluations (comparing models, comparing pipeline versions/optimizations) accumulate freely against the same Answers without any risk of silently changing a real grade. Without this flag, "the latest successful Evaluation Attempt" would be ambiguous the moment any comparison run happens, and comparison work would either be blocked or would risk corrupting real grades. This is treated as sound practice generally, not just a showcase concern — production-grade grading pipelines that ever get re-evaluated for calibration or model upgrades need the same separation.
