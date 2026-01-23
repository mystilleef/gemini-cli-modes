#!/bin/bash

# Test suite for write-mode.sh

# Resolve script path relative to this test file
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/../scripts" && pwd)/write-mode.sh"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

setup() {
  TEST_DIR=$(mktemp -d)
  cd "$TEST_DIR" || exit 1
}

teardown() {
  rm -rf "$TEST_DIR"
}

fail() {
  echo -e "${RED}✗ $1${NC}"
  teardown
  exit 1
}

pass() {
  echo -e "${GREEN}✓ $1${NC}"
}

run_test() {
  setup
  $1
  teardown
}

# =============================================================================
# Tests
# =============================================================================

test_deactivates_readonly_mode() {
  touch ".gemini_readonly"
  output=$("$SCRIPT_PATH")
  
  if [ ! -f ".gemini_readonly" ] && [[ "$output" == *"SUCCESS: Write mode activated"* ]]; then
    pass "Deactivates read-only mode successfully"
  else
    fail "Failed to deactivate read-only mode. Output: $output"
  fi
}

test_warns_if_already_writable() {
  output=$("$SCRIPT_PATH")
  
  if [[ "$output" == *"WARN: Write mode already active"* ]]; then
    pass "Warns when write mode already active"
  else
    fail "Failed to warn when already active. Output: $output"
  fi
}

# =============================================================================
# Run All Tests
# =============================================================================

run_test test_deactivates_readonly_mode
run_test test_warns_if_already_writable

echo ""
echo "All tests passed."
