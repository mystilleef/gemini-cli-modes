#!/usr/bin/env bash

# Check if readonly mode is active
TARGET_DIR="${GEMINI_PROJECT_DIR:-.}"
if [ -f "$TARGET_DIR/.gemini_readonly" ]; then
  # Read input from stdin
  input=$(cat)
  if [ "$input" = "" ]; then
    input="{}"
  fi

  # Extract the event name, defaulting to BeforeAgent if missing
  event_name=$(echo "$input" | jq -r '.hook_event_name // "BeforeAgent"')
  msg="Strictly enforce your read-only directives."

  # Output dynamic JSON using jq for safety
  jq -n \
    --arg event "$event_name" \
    --arg msg "$msg" \
    '{
      decision: "allow",
      systemMessage: "READONLY MODE",
      hookSpecificOutput: {
        hookEventName: $event,
        additionalContext: $msg
      }
    }'
else
  # Output BUILDER MODE when marker is missing
  msg="You are in Builder Mode. You have full write access. Don't show the read-only mode indicator."

  jq -n \
    --arg event "$event_name" \
    --arg msg "$msg" \
    '{
      decision: "allow",
      systemMessage: "BUILDER MODE",
      hookSpecificOutput: {
        hookEventName: $event,
        additionalContext: $msg
      }
    }'
fi

exit 0
