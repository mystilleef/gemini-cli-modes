#!/usr/bin/env bash

# Read input from stdin (required for hook compatibility)
input=$(cat)

# Define the readonly marker file path
TARGET_DIR="${GEMINI_PROJECT_DIR:-.}"
READONLY_MARKER="$TARGET_DIR/.gemini_readonly"

# Check if the marker exists
if [ -f "$READONLY_MARKER" ]; then
  # Remove the marker
  rm -f "$READONLY_MARKER"

  # Output success message in JSON format
  jq -n '{"systemMessage": "Read-only mode disabled on session end. Marker removed."}'
else
  # Output informational message if marker doesn't exist
  jq -n '{"systemMessage": "Read-only mode was not active."}'
fi

exit 0