package questionconfig

import "fmt"

// MCQConfig is the Config for a `mcq` Question: a set of lettered options
// and the correct one. Shape mirrors the sample benchmark dataset's
// answer_key.options / answer_key.correct_answer (sample-dataset/*_answer_key.json).
type MCQConfig struct {
	Options       map[string]string `json:"options"`
	CorrectAnswer string            `json:"correct_answer"`
}

func (c *MCQConfig) Type() Type { return TypeMCQ }

func (c *MCQConfig) Validate() error {
	if len(c.Options) < 2 {
		return fmt.Errorf("mcq: at least 2 options required")
	}
	if c.CorrectAnswer == "" {
		return fmt.Errorf("mcq: correct_answer is required")
	}
	if _, ok := c.Options[c.CorrectAnswer]; !ok {
		return fmt.Errorf("mcq: correct_answer %q is not among options", c.CorrectAnswer)
	}
	return nil
}

// TrueFalseConfig is the Config for a `true_false` Question.
type TrueFalseConfig struct {
	CorrectAnswer bool `json:"correct_answer"`
}

func (c *TrueFalseConfig) Type() Type { return TypeTrueFalse }

func (c *TrueFalseConfig) Validate() error { return nil }

// NumericConfig is the Config for a `numeric` Question: a correct numeric
// answer plus an optional tolerance for float comparison.
type NumericConfig struct {
	CorrectAnswer float64 `json:"correct_answer"`
	Tolerance     float64 `json:"tolerance,omitempty"`
	Unit          string  `json:"unit,omitempty"`
}

func (c *NumericConfig) Type() Type { return TypeNumeric }

func (c *NumericConfig) Validate() error {
	if c.Tolerance < 0 {
		return fmt.Errorf("numeric: tolerance must be >= 0")
	}
	return nil
}

// FillInConfig is the Config for a `fill_in` Question: a correct answer plus
// accepted spelling/casing variants.
type FillInConfig struct {
	CorrectAnswer    string   `json:"correct_answer"`
	AcceptedVariants []string `json:"accepted_variants,omitempty"`
}

func (c *FillInConfig) Type() Type { return TypeFillIn }

func (c *FillInConfig) Validate() error {
	if c.CorrectAnswer == "" {
		return fmt.Errorf("fill_in: correct_answer is required")
	}
	return nil
}

// OpenResponseConfig is the Config for an `open_response` Question: a
// rubric of discrete points an Answer is checked against, for grading
// (holistic scoring per Evaluation, not per-criterion -- see ADR 0005).
type OpenResponseConfig struct {
	RubricPoints []string `json:"rubric_points"`
}

func (c *OpenResponseConfig) Type() Type { return TypeOpenResponse }

func (c *OpenResponseConfig) Validate() error {
	if len(c.RubricPoints) == 0 {
		return fmt.Errorf("open_response: at least one rubric point is required")
	}
	return nil
}
