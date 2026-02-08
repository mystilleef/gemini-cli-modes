#!/bin/sh

# Test suite for enable-write-mode.sh
# Verifies POSIX compliance and status reporting.

set -eu

SCRIPT_PATH="./skills/write-mode/scripts/enable-write-mode.sh"
MARKER=".gemini_readonly"

# Ensure we start with the marker
touch "$MARKER"

echo "Running Test 1: Successful activation..."
OUTPUT=$("$SCRIPT_PATH")
if [ "$OUTPUT" = "STATUS: SUCCESS: Write mode activated" ] && [ ! -f "$MARKER" ]; then
    echo "Test 1 PASSED"
else
    echo "Test 1 FAILED: Got '$OUTPUT'"
    exit 1
fi

echo "Running Test 2: Warning when already active..."
OUTPUT=$("$SCRIPT_PATH")
if [ "$OUTPUT" = "STATUS: WARN: Write mode already active" ]; then
    echo "Test 2 PASSED"
else
    echo "Test 2 FAILED: Got '$OUTPUT'"
    exit 1
fi

# Cleanup
rm -f "$MARKER"
echo "All tests passed successfully."
