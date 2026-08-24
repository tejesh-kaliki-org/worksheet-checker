# Tests — classes

- `TestCreateClass/success` — creating a Class returns it with the owner set to the caller.
- `TestCreateClass/*` (validation cases) — empty/missing name → 400.
- `TestListClasses/success` — a User's classes are listed.
- `TestGetClass/success` — the owner can fetch their Class.
- `TestGetClass/not_found` — another User's Class, or a nonexistent id, 404s.
- `TestUpdateClass/success` — renaming a Class persists.
- `TestDeleteClass/success` — deleting a Class makes subsequent GETs 404.
- `TestClassSubjects/add, list, remove` — the happy path: add one of the owner's own Subjects to their Class, list it back, remove it.
- `TestClassSubjects/add subject owned by another user 404s` — a Subject belonging to a different User cannot be added to your Class (ownership boundary; 404 not 403).
- `TestClassSubjects/add nonexistent subject 404s` — a random UUID that matches no Subject 404s.
- `TestClassSubjects/subjects on class owned by another user 404s` — listing another User's Class-Subjects 404s.

## Known gaps (tracked, not yet implemented)

- Class-name uniqueness per owner is not yet enforced at the DB or service level (no test, no constraint) — the reviewer's requested "distinct class name" case is not yet in this file.
- `ListClasses` returning `[]` (not `null`) for a zero-class User is not yet asserted.
- `POST /classes/{classId}/subjects:bulk-select` and its tests are not yet implemented.

See the issue-4-academic-structure follow-up work for these.
