-- +goose Up
-- A teacher's Class names must be distinct within their own account, the same
-- way Subject names are (see 0007_subjects.sql). Two different teachers may
-- both have a "Grade 5A"; one teacher may not have it twice. Enforced at the
-- DB level so the service can surface a 409 from the constraint rather than
-- racing a SELECT-then-INSERT.
ALTER TABLE classes ADD CONSTRAINT classes_created_by_name_key UNIQUE (created_by, name);

-- +goose Down
ALTER TABLE classes DROP CONSTRAINT classes_created_by_name_key;
