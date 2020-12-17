package main

import (
	"os"

	"github.com/elastic/beats/libbeat/beat"

	"github.com/tnektnek/carbonbeat/app"
)

func main() {
	err := beat.Run("carbonbeat", "", app.New)
	if err != nil {
		os.Exit(1)
	}
}
