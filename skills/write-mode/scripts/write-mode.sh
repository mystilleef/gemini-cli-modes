#!/bin/sh
# write-mode.sh
# Purpose: Remove the read-only marker file

MARKER=".gemini_readonly"

if [ ! -f "$MARKER" ]; then
  echo "WARN: Write mode already active"
  exit 0
fi

if rm "$MARKER"; then
  echo "SUCCESS: Write mode activated"
  exit 0
else
  echo "ERROR: Failed to remove marker file"
  exit 1
fi
