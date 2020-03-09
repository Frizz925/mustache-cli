#!/bin/sh
set -e

TESTS_DIR=$(realpath $(dirname $0))

CONTEXT_PATH="$TESTS_DIR/context.yml"
TEMPLATE_PATH="$TESTS_DIR/template.mustache"
EXPECTED_PATH="$TESTS_DIR/expected.txt"

cd "$TESTS_DIR/.."
test "$(cargo run "$TEMPLATE_PATH" < "$CONTEXT_PATH")" = "$(cat "$EXPECTED_PATH")"