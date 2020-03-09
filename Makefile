BINARY_TARGET := x86_64-unknown-linux-gnu
BINARY_NAME := mustache-cli
OUT_DIR := target/$(BINARY_TARGET)/release

test:
	tests/test.sh

build:
	cargo build --target $(BINARY_TARGET) --release
	strip $(OUT_DIR)/$(BINARY_NAME)
	cp $(OUT_DIR)/$(BINARY_NAME) target/release/$(BINARY_NAME)