#!/usr/bin/env bash

# Read input from stdin to maintain compatibility with hook architecture
input=$(cat)

# Check if readonly mode is active
TARGET_DIR="${GEMINI_PROJECT_DIR:-.}"
if [ ! -f "$TARGET_DIR/.gemini_readonly" ]; then
  # Only remind about vibe_check when NOT in readonly mode (Builder Mode)
  event_name=$(echo "$input" | jq -r '.hook_event_name // "BeforeAgent"')
  msg="Enforce your vibe check directives"

  jq -n \
    --arg event "$event_name" \
    --arg msg "$msg" \
    '{
      decision: "allow",
      systemMessage: "VIBE CHECK REMINDER",
      hookSpecificOutput: {
        hookEventName: $event,
        additionalContext: $msg
      }
    }'
else
  # Silent in readonly mode to reduce noise
  echo '{}'
fi

exit 0
