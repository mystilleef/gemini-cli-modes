#!/usr/bin/env bash

# Read input from stdin to maintain compatibility with hook architecture
input=$(cat)

event_name=$(echo "$input" | jq -r '.hook_event_name // "SessionStart"')
msg="Study bd-guide.md for how and when to use your task management system and the 'bd' tool."

jq -n \
  --arg event "$event_name" \
  --arg msg "$msg" \
  '{
    decision: "allow",
    systemMessage: "BEADS ONBOARD STARTUP",
    hookSpecificOutput: {
      hookEventName: $event,
      additionalContext: $msg
    }
  }'

exit 0
