package main

import (
	"io/ioutil"
	"os"

	"github.com/hoisie/mustache"
	"gopkg.in/yaml.v2"
)

func main() {
	if len(os.Args) < 2 {
		printError("Usage: mustache-cli <template-file>")
		os.Exit(1)
	}
	err := run(os.Args[1])
	if err != nil {
		panic(err)
	}
}

func run(templateFile string) error {
	template, err := ioutil.ReadFile(templateFile)
	if err != nil {
		return err
	}
	b, err := ioutil.ReadAll(os.Stdin)
	if err != nil {
		return err
	}
	context := make(map[string]interface{})
	err = yaml.Unmarshal(b, &context)
	if err != nil {
		return err
	}
	rendered := mustache.Render(string(template), context)
	_, err = os.Stdout.WriteString(rendered)
	return err
}

func printError(message string) {
	_, err := os.Stderr.WriteString(message + "\r\n")
	if err != nil {
		panic(err)
	}
}
