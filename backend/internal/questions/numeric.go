package questions

import (
	"fmt"
	"strconv"

	"github.com/jackc/pgx/v5/pgtype"
)

// numericFromFloat64 converts an API-level float64 (Maximum Marks) into the
// pgtype.Numeric sqlc generates for the `numeric` column.
func numericFromFloat64(v float64) (pgtype.Numeric, error) {
	var n pgtype.Numeric
	if err := n.Scan(strconv.FormatFloat(v, 'f', -1, 64)); err != nil {
		return pgtype.Numeric{}, fmt.Errorf("invalid maximum_marks: %w", err)
	}
	return n, nil
}

// float64FromNumeric converts a stored pgtype.Numeric back to a float64 for
// the API response.
func float64FromNumeric(n pgtype.Numeric) (float64, error) {
	f, err := n.Float64Value()
	if err != nil {
		return 0, err
	}
	return f.Float64, nil
}
