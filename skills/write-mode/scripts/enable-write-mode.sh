#!/bin/sh

# STATUS: message protocol compliance
# This script enables write mode by removing the read-only marker file.
# It adheres to POSIX standards for portability.

set -eu

MARKER=".gemini_readonly"

if [ ! -f "$MARKER" ]; then
  printf "STATUS: WARN: Write mode already active
"
  exit 0
elif rm "$MARKER"; then
  printf "STATUS: SUCCESS: Write mode activated
"
  exit 0
else
  printf "STATUS: ERROR: Failed to remove marker file
"
  exit 1
fi
