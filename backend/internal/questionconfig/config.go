// Package questionconfig is the single validating boundary for
// Question.config (JSONB). Every read or write of that column must go
// through this package -- never ad hoc json.Marshal/Unmarshal elsewhere in
// the codebase (see docs/grading-domain-model.md, point 4, and ADR 0004 --
// no question preprocessing model, i.e. no shape guessed beyond what's
// needed today).
//
// Each Question Type (see CONTEXT.md) has its own Go struct implementing
// Config. Marshal validates before serializing; Unmarshal validates after
// parsing -- config that fails Validate never reaches the database and
// never leaves it silently malformed.
package questionconfig

import (
	"encoding/json"
	"fmt"
)

// Type mirrors the question_type Postgres enum (sql/schema/0011_questions.sql).
type Type string

const (
	TypeMCQ          Type = "mcq"
	TypeTrueFalse    Type = "true_false"
	TypeNumeric      Type = "numeric"
	TypeFillIn       Type = "fill_in"
	TypeOpenResponse Type = "open_response"
)

// CurrentSchemaVersion is the schema_version stamped on newly authored
// Questions. Bump (and branch on the stored value) only when a type's Config
// shape actually changes.
const CurrentSchemaVersion = 1

// Config is implemented by every per-type config struct. Validate reports
// whether the config is well-formed for its Question Type; it is called by
// both Marshal (before writing) and Unmarshal (after reading).
type Config interface {
	Type() Type
	Validate() error
}

// Marshal validates cfg and serializes it to the JSON bytes stored in
// Question.config. It is the only sanctioned way to produce that column's
// value.
func Marshal(cfg Config) ([]byte, error) {
	if cfg == nil {
		return nil, fmt.Errorf("questionconfig: nil config")
	}
	if err := cfg.Validate(); err != nil {
		return nil, fmt.Errorf("questionconfig: invalid %s config: %w", cfg.Type(), err)
	}
	return json.Marshal(cfg)
}

// Unmarshal parses raw JSON (as stored in Question.config) into the Config
// struct appropriate for qType, and validates it. It is the only sanctioned
// way to read that column's value.
func Unmarshal(qType Type, raw []byte) (Config, error) {
	var cfg Config
	switch qType {
	case TypeMCQ:
		cfg = &MCQConfig{}
	case TypeTrueFalse:
		cfg = &TrueFalseConfig{}
	case TypeNumeric:
		cfg = &NumericConfig{}
	case TypeFillIn:
		cfg = &FillInConfig{}
	case TypeOpenResponse:
		cfg = &OpenResponseConfig{}
	default:
		return nil, fmt.Errorf("questionconfig: unknown question type %q", qType)
	}
	if err := json.Unmarshal(raw, cfg); err != nil {
		return nil, fmt.Errorf("questionconfig: decode %s config: %w", qType, err)
	}
	if err := cfg.Validate(); err != nil {
		return nil, fmt.Errorf("questionconfig: invalid %s config: %w", qType, err)
	}
	return cfg, nil
}

// ParseAny decodes raw JSON of any shape (e.g. a request body's `config`
// field, whose static type is unknown until `type` is read) into the Config
// for qType. Equivalent to Unmarshal; kept as a distinct name at API
// boundaries that already have a json.RawMessage in hand.
func ParseAny(qType Type, raw json.RawMessage) (Config, error) {
	return Unmarshal(qType, raw)
}
