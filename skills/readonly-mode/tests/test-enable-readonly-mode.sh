#!/bin/sh

# Test suite for enable-readonly-mode.sh
# Verifies POSIX compliance and status reporting.

set -eu

SCRIPT_PATH="./skills/readonly-mode/scripts/enable-readonly-mode.sh"
MARKER=".gemini_readonly"

# Ensure we start without the marker
rm -f "$MARKER"

echo "Running Test 1: Successful activation..."
OUTPUT=$("$SCRIPT_PATH")
if [ "$OUTPUT" = "STATUS: SUCCESS: Read-only mode activated" ] && [ -f "$MARKER" ]; then
    echo "Test 1 PASSED"
else
    echo "Test 1 FAILED: Got '$OUTPUT'"
    exit 1
fi

echo "Running Test 2: Warning when already active..."
OUTPUT=$("$SCRIPT_PATH")
if [ "$OUTPUT" = "STATUS: WARN: Read-only mode already active" ]; then
    echo "Test 2 PASSED"
else
    echo "Test 2 FAILED: Got '$OUTPUT'"
    exit 1
fi

# Cleanup
rm -f "$MARKER"
echo "All tests passed successfully."
