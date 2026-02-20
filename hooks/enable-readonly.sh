#!/usr/bin/env bash

# Read input from stdin (required for hook compatibility)
input=$(cat)

# Define the readonly marker file path
TARGET_DIR="${GEMINI_PROJECT_DIR:-.}"
READONLY_MARKER="$TARGET_DIR/.gemini_readonly"

# Check if the marker exists
if [ ! -f "$READONLY_MARKER" ]; then
  # Create the marker
  touch "$READONLY_MARKER"

  # Output a message indicating readonly mode has been enabled
  jq -n '{"systemMessage": "STARTED READONLY MODE"}'
else
  # Output a message indicating readonly mode is already active
  jq -n '{"systemMessage": "STARTED READONLY MODE"}'
fi

exit 0
