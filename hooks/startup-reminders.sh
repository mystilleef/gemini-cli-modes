#!/bin/sh

# --- Startup Reminders Hook ---
# Consolidates reminders for beads, vibe check, and response presentation.
# Dependencies: jq

set -eu

# 1. Read input from stdin
input=$(cat)

# 2. Extract event name
event_name=$(printf '%s\n' "${input}" | jq -r '.hook_event_name // "SessionStart"')

# 3. Define Consolidated Message
msg="Study the following guides to ensure alignment with project protocols:
- bd-guide.md: Task management system and the 'bd' tool.
- vibe-check-guide.md: Metacognitive oversight and vibe checks.
- response-presentation-guide.md: Response formatting and presentation guidelines."

# 4. Output JSON
jq -n \
  --arg event "${event_name}" \
  --arg msg "${msg}" \
'{
  decision: "allow",
  systemMessage: "STARTUP REMINDERS",
  hookSpecificOutput: {
    hookEventName: $event,
    additionalContext: $msg
  }
}'

exit 0
