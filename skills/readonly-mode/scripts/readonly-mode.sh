#!/bin/sh
# readonly-mode.sh
# Purpose: Create the read-only marker file

MARKER=".gemini_readonly"

if [ -f "$MARKER" ]; then
  echo "WARN: Read-only mode already active"
  exit 0
fi

if touch "$MARKER"; then
  echo "SUCCESS: Read-only mode activated"
  exit 0
else
  echo "ERROR: Failed to create marker file"
  exit 1
fi
