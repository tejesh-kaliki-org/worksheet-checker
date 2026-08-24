# Tests — students

- `TestCreateStudent/success` — creating a Student under the owner's Class succeeds.
- `TestCreateStudent/conflict on duplicate roll_number` — a duplicate Roll Number within the same Class conflicts.
- `TestCreateStudent/not_found for another owner's class` — creating a Student under a Class you don't own 404s.
- `TestCreateStudent/validation` — missing/invalid fields → 400.
- `TestListStudents/success` — a Class's Students are listed.
- `TestGetStudent/success` — the owner can fetch a Student.
- `TestGetStudent/not_found` — a nonexistent/foreign Student 404s.
- `TestUpdateStudent/success` — updating a Student persists.
- `TestDeleteStudent/success` — deleting a Student removes it.

## Known gap (tracked, not yet implemented)

`POST /classes/{classId}/students:bulk-upload` and its tests are not yet implemented — see the issue-4-academic-structure follow-up work.
