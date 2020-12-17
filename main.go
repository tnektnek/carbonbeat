package main

import (
	"os"

	"github.com/elastic/beats/libbeat/beat"

<<<<<<< HEAD
	"github.com/indeedsecurity/carbonbeat/app"
=======
	"github.com/tnektnek/carbonbeat/app"
>>>>>>> 42f0668 (committing content to begin merge)
)

func main() {
	err := beat.Run("carbonbeat", "", app.New)
	if err != nil {
		os.Exit(1)
	}
}
