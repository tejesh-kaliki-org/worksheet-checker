package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"strconv"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgtype"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/spf13/cobra"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/config"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/database"
	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/questionconfig"
)

// sampleQuestion mirrors one entry of sample-dataset/*_answer_key.json
// (see docs/grading-domain-model.md's "Starting point" section — the sample
// benchmark dataset is a shape reference only, not itself a schema to mirror).
type sampleQuestion struct {
	Type      string                 `json:"type"`
	Marks     float64                `json:"marks"`
	Options   map[string]string      `json:"options"`
	AnswerKey map[string]interface{} `json:"answer_key"`
}

type sampleDataset struct {
	Questions []sampleQuestion `json:"questions"`
}

// newSeedQuestionsCmd seeds Questions from a sample benchmark dataset
// answer-key file into a given Exam Subject. Dev/demo tool only -- it does
// not go through the HTTP API, but still routes every config through
// internal/questionconfig, the same boundary the API handlers use.
func newSeedQuestionsCmd() *cobra.Command {
	var (
		configPath    string
		datasetPath   string
		examSubjectID string
	)

	cmd := &cobra.Command{
		Use:   "seed-questions",
		Short: "Seed Questions from a sample benchmark dataset answer key into an Exam Subject",
		RunE: func(cmd *cobra.Command, args []string) error {
			examSubjectUUID, err := uuid.Parse(examSubjectID)
			if err != nil {
				return fmt.Errorf("invalid --exam-subject-id: %w", err)
			}

			raw, err := os.ReadFile(datasetPath)
			if err != nil {
				return fmt.Errorf("read dataset: %w", err)
			}
			var dataset sampleDataset
			if err := json.Unmarshal(raw, &dataset); err != nil {
				return fmt.Errorf("parse dataset: %w", err)
			}

			cfg, err := config.Load(configPath)
			if err != nil {
				return fmt.Errorf("load config: %w", err)
			}
			ctx := context.Background()
			pool, err := pgxpool.New(ctx, cfg.Database.URL)
			if err != nil {
				return fmt.Errorf("connect database: %w", err)
			}
			defer pool.Close()
			queries := database.New(pool)

			seeded := 0
			for i, q := range dataset.Questions {
				qType, qCfg, err := toQuestionConfig(q)
				if err != nil {
					fmt.Fprintf(os.Stderr, "skipping question %d (%s): %v\n", i, q.Type, err)
					continue
				}
				configBytes, err := questionconfig.Marshal(qCfg)
				if err != nil {
					fmt.Fprintf(os.Stderr, "skipping question %d (%s): %v\n", i, q.Type, err)
					continue
				}
				marks, err := numericFromFloat64(q.Marks)
				if err != nil {
					fmt.Fprintf(os.Stderr, "skipping question %d (%s): %v\n", i, q.Type, err)
					continue
				}
				if _, err := queries.CreateQuestion(ctx, database.CreateQuestionParams{
					ExamSubjectID: examSubjectUUID,
					Type:          database.QuestionType(qType),
					Config:        configBytes,
					SchemaVersion: questionconfig.CurrentSchemaVersion,
					MaximumMarks:  marks,
				}); err != nil {
					return fmt.Errorf("insert question %d: %w", i, err)
				}
				seeded++
			}
			fmt.Printf("seeded %d/%d questions into exam subject %s\n", seeded, len(dataset.Questions), examSubjectUUID)
			return nil
		},
	}

	cmd.Flags().StringVar(&configPath, "config", "config/env.yaml", "path to the server config YAML (for the database URL)")
	cmd.Flags().StringVar(&datasetPath, "dataset", "", "path to a sample-dataset/*_answer_key.json file (required)")
	cmd.Flags().StringVar(&examSubjectID, "exam-subject-id", "", "target Exam Subject id (required)")
	_ = cmd.MarkFlagRequired("dataset")
	_ = cmd.MarkFlagRequired("exam-subject-id")

	return cmd
}

// toQuestionConfig converts one sample dataset question into the
// questionconfig.Config for its type -- the only sanctioned shape for
// Question.config. Unknown/malformed entries are rejected, not guessed at.
func toQuestionConfig(q sampleQuestion) (questionconfig.Type, questionconfig.Config, error) {
	qType := questionconfig.Type(q.Type)
	switch qType {
	case questionconfig.TypeMCQ:
		correct, _ := q.AnswerKey["correct_answer"].(string)
		return qType, &questionconfig.MCQConfig{
			Options:       q.Options,
			CorrectAnswer: correct,
		}, nil
	case questionconfig.TypeTrueFalse:
		correct, _ := q.AnswerKey["correct_answer"].(bool)
		return qType, &questionconfig.TrueFalseConfig{CorrectAnswer: correct}, nil
	case questionconfig.TypeNumeric:
		answerStr, _ := q.AnswerKey["correct_answer"].(string)
		answer, err := strconv.ParseFloat(answerStr, 64)
		if err != nil {
			return qType, nil, fmt.Errorf("numeric correct_answer %q: %w", answerStr, err)
		}
		unit, _ := q.AnswerKey["unit"].(string)
		return qType, &questionconfig.NumericConfig{CorrectAnswer: answer, Unit: unit}, nil
	case questionconfig.TypeFillIn:
		correct, _ := q.AnswerKey["correct_answer"].(string)
		var variants []string
		if raw, ok := q.AnswerKey["accepted_variants"].([]interface{}); ok {
			for _, v := range raw {
				if s, ok := v.(string); ok {
					variants = append(variants, s)
				}
			}
		}
		return qType, &questionconfig.FillInConfig{CorrectAnswer: correct, AcceptedVariants: variants}, nil
	case questionconfig.TypeOpenResponse:
		var points []string
		if raw, ok := q.AnswerKey["rubric_points"].([]interface{}); ok {
			for _, v := range raw {
				if s, ok := v.(string); ok {
					points = append(points, s)
				}
			}
		}
		return qType, &questionconfig.OpenResponseConfig{RubricPoints: points}, nil
	default:
		return qType, nil, fmt.Errorf("unknown question type %q", q.Type)
	}
}

// numericFromFloat64 converts a float64 (Maximum Marks) into the
// pgtype.Numeric sqlc generates for the questions.maximum_marks column.
func numericFromFloat64(v float64) (pgtype.Numeric, error) {
	var n pgtype.Numeric
	if err := n.Scan(strconv.FormatFloat(v, 'f', -1, 64)); err != nil {
		return pgtype.Numeric{}, fmt.Errorf("invalid maximum_marks: %w", err)
	}
	return n, nil
}
