# Questions are scoped to an Exam Subject, no reusable question bank

Status: accepted

`Question` rows belong directly to one `Exam Subject` (`exam_subject_id` FK) rather than living in a shared bank referenced by multiple exams. A bank adds a join table plus versioning questions when a reused item's marks or content change on one exam but not another — complexity with no current payoff. The sample benchmark dataset's flat subject/topic/question shape is test fixture data, not evidence of a reuse requirement. Revisit if AI-driven question generation is added and questions need to be generated once, then adapted/reused across multiple exams; the migration path is additive (`source_question_id` nullable FK on `Question`).
