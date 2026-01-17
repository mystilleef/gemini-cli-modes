#!/usr/bin/env bash

# Define the readonly marker file path
READONLY_MARKER="$GEMINI_PROJECT_DIR/.gemini_readonly"

# Check if the marker exists
if [ -f "$READONLY_MARKER" ]; then
  # Remove the marker
  rm -f "$READONLY_MARKER"

  # Output success message in JSON format
  echo '{"systemMessage": "Read-only mode disabled on session end. Marker removed."}'
else
  # Output informational message if marker doesn't exist
  echo '{"systemMessage": "Read-only mode was not active."}'
fi

exit 0
