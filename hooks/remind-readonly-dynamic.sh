#!/usr/bin/env bash

# Read input from stdin
input=$(cat)

# Check if readonly mode is active
if [ -f "$GEMINI_PROJECT_DIR/.gemini_readonly" ]; then
  # Extract the event name, defaulting to BeforeAgent if missing
  event_name=$(echo "$input" | jq -r '.hook_event_name // "BeforeAgent"')

  # echo "[$(date)] Event called: $event_name" >> gemini-readonly.log

  # Output dynamic JSON using jq for safety
  jq -n --arg event "$event_name" \
    --arg msg "⚠️ SYSTEM ENFORCEMENT: READONLY MODE IS ACTIVE. Please follow your core read-only directives to the letter. You are strictly prohibited from making changes to the project, with exceptions provided in your core read-only directives. Strictly enforce the protocol for showing the read-only indicator as per your read-only directives" \
    '{
      "decision": "allow",
      "systemMessage": "🔒 ACTIVATE READONLY MODE",
      "hookSpecificOutput": {
        "hookEventName": $event,
        "additionalContext": $msg
      }
    }'
else
  # Do nothing if not in readonly mode
  echo '{}'
fi
