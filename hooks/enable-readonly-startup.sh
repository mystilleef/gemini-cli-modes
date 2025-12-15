#!/usr/bin/env bash

# Define the readonly marker file path
READONLY_MARKER="$GEMINI_PROJECT_DIR/.gemini_readonly"

# Check if the marker exists
if [ ! -f "$READONLY_MARKER" ]; then
  # Create the marker
  touch "$READONLY_MARKER"

  # Output a message indicating readonly mode has been enabled
  echo '{"systemMessage": "Read-only mode enabled on session startup."}'
else
  # Output a message indicating readonly mode is already active
  echo '{"systemMessage": "Read-only mode is already active."}'
fi

exit 0
