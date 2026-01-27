#!/usr/bin/env bash

# Read input from stdin to maintain compatibility with hook architecture
input=$(cat)

# Check if readonly mode is active
TARGET_DIR="${GEMINI_PROJECT_DIR:-.}"
if [ ! -f "$TARGET_DIR/.gemini_readonly" ]; then
  # Only remind about bd when NOT in readonly mode
  event_name=$(echo "$input" | jq -r '.hook_event_name // "BeforeAgent"')
  msg="For complex work, activate your task management system to manage your work."

  jq -n \
    --arg event "$event_name" \
    --arg msg "$msg" \
    '{
      decision: "allow",
      systemMessage: "BEADS REMINDER",
      hookSpecificOutput: {
        hookEventName: $event,
        additionalContext: $msg
      }
    }'
else
  # Silent in readonly mode
  echo '{}'
fi

exit 0
