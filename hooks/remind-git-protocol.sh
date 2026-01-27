#!/usr/bin/env bash

# Read input from stdin for hook compatibility
input=$(cat)

# Extract the event name, defaulting to BeforeAgent
event_name=$(echo "$input" | jq -r '.hook_event_name // "BeforeAgent"')

# The strict directive to inject
msg="COMMIT PROTOCOL REMINDER: You are STRICTLY PROHIBITED from autonomously staging files or performing Git commits. You MUST obtain explicit user authorization before executing any git write operation."

# Output JSON response for the Gemini CLI
jq -n \
  --arg event "$event_name" \
  --arg msg "$msg" \
  '{
    decision: "allow",
    systemMessage: "GIT PROTOCOL ENFORCEMENT",
    hookSpecificOutput: {
      hookEventName: $event,
      additionalContext: $msg
    }
  }'

exit 0
