// Command cli is a dev/demo-only management tool (not end-user facing). It
// exists alongside cmd/server as a separate binary so operational one-offs
// (like seeding sample data) don't grow into the HTTP server's flags.
package main

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

func main() {
	root := &cobra.Command{
		Use:   "cli",
		Short: "Worksheet Checker dev/demo management CLI",
	}
	root.AddCommand(newSeedQuestionsCmd())

	if err := root.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
