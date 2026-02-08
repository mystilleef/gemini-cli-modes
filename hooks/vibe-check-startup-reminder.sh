#!/usr/bin/env bash

# Read input from stdin to maintain compatibility with hook architecture
input=$(cat)

event_name=$(echo "$input" | jq -r '.hook_event_name // "SessionStart"')
msg="Study vibe-check-guide.md for how and when to do a vibe check."

jq -n \
  --arg event "$event_name" \
  --arg msg "$msg" \
'{
    decision: "allow",
    systemMessage: "VIBE CHECK STARTUP",
    hookSpecificOutput: {
      hookEventName: $event,
      additionalContext: $msg
    }
  }'

exit 0
