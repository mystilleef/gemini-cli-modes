#!/bin/sh

# STATUS: message protocol compliance
# This script enables read-only mode by creating a marker file.
# It adheres to POSIX standards for portability.

set -eu

MARKER=".gemini_readonly"

if [ -f "$MARKER" ]; then
  printf "STATUS: WARN: Read-only mode already active\n"
  exit 0
elif touch "$MARKER"; then
  printf "STATUS: SUCCESS: Read-only mode activated\n"
  exit 0
else
  printf "STATUS: ERROR: Failed to create marker file\n"
  exit 1
fi
