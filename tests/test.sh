TESTS_DIR=$(dirname $0)

CONTEXT_PATH="$TESTS_DIR/context.yml"
TEMPLATE_PATH="$TESTS_DIR/template.mustache"
EXPECTED_PATH="$TESTS_DIR/expected.txt"

MAIN_SCRIPT_PATH="$TESTS_DIR/../main.go"

test "$(go run "$MAIN_SCRIPT_PATH" "$TEMPLATE_PATH" < "$CONTEXT_PATH")" = "$(cat "$EXPECTED_PATH")"