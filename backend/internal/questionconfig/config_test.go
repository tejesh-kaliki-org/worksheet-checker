package questionconfig_test

import (
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/questionconfig"
)

func TestMarshalUnmarshalRoundTrip(t *testing.T) {
	cases := []questionconfig.Config{
		&questionconfig.MCQConfig{
			Options:       map[string]string{"A": "one", "B": "two"},
			CorrectAnswer: "A",
		},
		&questionconfig.TrueFalseConfig{CorrectAnswer: true},
		&questionconfig.NumericConfig{CorrectAnswer: 10, Tolerance: 0.5, Unit: "V"},
		&questionconfig.FillInConfig{CorrectAnswer: "chlorophyll", AcceptedVariants: []string{"Chlorophyll"}},
		&questionconfig.OpenResponseConfig{RubricPoints: []string{"point one"}},
	}
	for _, cfg := range cases {
		raw, err := questionconfig.Marshal(cfg)
		if err != nil {
			t.Fatalf("marshal %s: %v", cfg.Type(), err)
		}
		got, err := questionconfig.Unmarshal(cfg.Type(), raw)
		if err != nil {
			t.Fatalf("unmarshal %s: %v", cfg.Type(), err)
		}
		if got.Type() != cfg.Type() {
			t.Fatalf("type mismatch: got %s want %s", got.Type(), cfg.Type())
		}
	}
}

func TestMCQValidate(t *testing.T) {
	cfg := &questionconfig.MCQConfig{
		Options:       map[string]string{"A": "one"},
		CorrectAnswer: "B",
	}
	if _, err := questionconfig.Marshal(cfg); err == nil {
		t.Fatal("expected error for correct_answer not among options")
	}
}

func TestFillInValidate(t *testing.T) {
	cfg := &questionconfig.FillInConfig{}
	if _, err := questionconfig.Marshal(cfg); err == nil {
		t.Fatal("expected error for missing correct_answer")
	}
}

func TestOpenResponseValidate(t *testing.T) {
	cfg := &questionconfig.OpenResponseConfig{}
	if _, err := questionconfig.Marshal(cfg); err == nil {
		t.Fatal("expected error for empty rubric_points")
	}
}

func TestUnmarshalUnknownType(t *testing.T) {
	if _, err := questionconfig.Unmarshal("bogus", []byte(`{}`)); err == nil {
		t.Fatal("expected error for unknown type")
	}
}
