-- +goose Up
-- Class Subject: a Class's selection of which catalogue Subjects apply to it.
CREATE TABLE class_subjects (
    class_id   UUID NOT NULL REFERENCES classes (id) ON DELETE CASCADE,
    subject_id UUID NOT NULL REFERENCES subjects (id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (class_id, subject_id)
);

-- +goose Down
DROP TABLE class_subjects;
