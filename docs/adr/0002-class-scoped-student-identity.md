# Class-scoped Student identity, no cross-class rollover

Status: accepted

A `Student` record is scoped to a single `Class`; the same physical student in two classes (e.g. across academic years) produces two unrelated `Student` rows with no link between them. Building cross-class identity would require matching/merging logic (name collisions, transfers, re-enrollment) that isn't core to the grading problem this project demonstrates. Revisit if there's a real need to track one student's history or performance across multiple classes or years — likely a `person_id` layer above `Student` rather than a change to `Student` itself.
