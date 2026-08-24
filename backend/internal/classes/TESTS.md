# Tests — classes

- `TestCreateClass/success` — creating a Class returns it with the owner set to the caller.
- `TestCreateClass/authorization` — no bearer token → 401.
- `TestCreateClass/validation` — an empty name → 400.
- `TestCreateClassNameUniqueness/duplicate name for same owner conflicts` — the `classes (created_by, name)` constraint added in `0009_classes_unique_name.sql` surfaces as 409.
- `TestCreateClassNameUniqueness/same name for a different owner is allowed` — uniqueness is per-User, not global.
- `TestCreateClassNameUniqueness/rename onto an existing name conflicts` — `PUT /classes/{id}` hits the same constraint → 409.
- `TestListClasses/success scoped to owner` — a User sees only their own Classes.
- `TestListClassesEmpty` — a User with no Classes gets `"classes":[]`, never `null`.
- `TestGetClass/success` — the owner can fetch their Class.
- `TestGetClass/not_found for another owner's class` — ownership boundary (404, never 403).
- `TestGetClass/not_found for missing class` — a nonexistent id 404s.
- `TestUpdateClass/success` — renaming a Class persists.
- `TestDeleteClass/success` — deleting a Class makes subsequent GETs 404.
- `TestClassSubjects/bulk-select, list, remove` — the happy path: select one of the owner's own Subjects for their Class, list it back, remove it.
- `TestClassSubjects/bulk-select subject owned by another user 404s` — a Subject belonging to a different User cannot be selected (404, not 403).
- `TestClassSubjects/bulk-select nonexistent subject 404s` — a random UUID that matches no Subject 404s.
- `TestClassSubjects/subjects on class owned by another user 404s` — listing another User's Class-Subjects 404s.
- `TestBulkSelectClassSubjects/selects several subjects at once and is idempotent` — the same payload submitted twice yields the same two selections, no duplicates and no error.
- `TestBulkSelectClassSubjects/empty list is rejected` — `{"subject_ids":[]}` → 400.
- `TestBulkSelectClassSubjects/malformed body is rejected` — a wrongly typed `subject_ids` → 400.
- `TestBulkSelectClassSubjects/a single foreign id rejects the whole selection` — all-or-nothing: a mixed payload 404s and selects nothing.
- `TestBulkSelectClassSubjects/class owned by another user 404s` — ownership boundary on the Class.
- `TestBulkSelectClassSubjects/missing class 404s` — a random Class id 404s.

Note: `DELETE /classes/{classId}/subjects/{subjectId}` cannot conflict on this
schema — no Exam Subject / Question / Answer table exists yet — so there is
deliberately no 409 case for it here, matching the spec.
