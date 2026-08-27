-- +goose Up
-- An Exam's label must be distinct within its own Class, the same way Class
-- names are distinct within their owning User (see 0009_classes_unique_name.sql).
-- Enforced at the DB level so the service can surface a 409 from the
-- constraint rather than racing a SELECT-then-INSERT.
ALTER TABLE exams ADD CONSTRAINT exams_class_id_label_key UNIQUE (class_id, label);

-- +goose Down
ALTER TABLE exams DROP CONSTRAINT exams_class_id_label_key;
