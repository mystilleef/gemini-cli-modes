#!/bin/sh
set -eu

# Read input from stdin to maintain compatibility with hook architecture
input=$(cat)

# Extract event name using jq
event_name=$(printf '%s\n' "${input}" | jq -r '.hook_event_name // "SessionStart"')
msg="Study response-presentation-guide.md for how to format your responses."

jq -n \
  --arg event "${event_name}" \
  --arg msg "${msg}" \
'{
    decision: "allow",
    systemMessage: "RESPONSE PRESENTATION STARTUP",
    hookSpecificOutput: {
      hookEventName: $event,
      additionalContext: $msg
    }
  }'
