#!/usr/bin/env bash

# Read input from stdin (required for hook compatibility)
input=$(cat)

MSG="Strictly enforce your E-Prime directives."

jq -n \
  --arg msg "$MSG" \
  '{
    decision: "allow",
    systemMessage: "E-PRIME ENFORCEMENT",
    hookSpecificOutput: {
      hookEventName: "BeforeAgent",
      additionalContext: $msg
    }
  }'

exit 0