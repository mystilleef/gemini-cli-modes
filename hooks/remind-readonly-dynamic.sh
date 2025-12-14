#!/usr/bin/env bash

# Check if readonly mode is active
if [ -f "$GEMINI_PROJECT_DIR/.gemini_readonly" ]; then
  # echo "[$(date)] Event called: $event_name" >> gemini-readonly.log
  # Read input from stdin
  input=$(cat)
  # Extract the event name, defaulting to BeforeAgent if missing
  event_name=$(echo "$input" | jq -r '.hook_event_name // "BeforeAgent"')
  msg="⚠️ SYSTEM ENFORCEMENT: READONLY MODE IS ACTIVE. Please follow your core read-only directives to the letter. Other than removing the read-only marker (using the /writable, /build, and /implement command explicitly issued by the user), you are strictly prohibited from making changes to the project. Strictly enforce the protocol for showing the read-only indicator as per your read-only directives"
  # Output dynamic JSON using jq for safety
  cat << EOF
  {
    "decision": "allow",
    "systemMessage": "🔒 ACTIVATE READONLY MODE",
    "hookSpecificOutput": {
      "hookEventName": "$event_name",
      "additionalContext": "$msg"
    }
  }
EOF
else
  # Do nothing if not in readonly mode
  echo '{}'
fi
