#!/usr/bin/env bash

# Read input from stdin to maintain compatibility with hook architecture
input=$(cat)

# Define the strict E-Prime enforcement message
# Explicitly lists forbidden verbs to maximize model adherence
MSG="⚠️ E-PRIME ENFORCEMENT ACTIVE.
Follow your E-Prime directives to the letter.
PROHIBITED VERBS: is, am, are, was, were, be, been, being.
SCOPE: All responses, generated text, explanations, and code comments.
EXCEPTIONS: Code identifiers, exact string literals, and direct quotes.
INSTRUCTION: Use active verbs. Describe what things DO, not what they ARE."

# Output JSON using jq to inject the system message
jq -n --arg msg "$MSG" \
  '{
    "decision": "allow",
    "systemMessage": "🔒 E-PRIME ENFORCEMENT",
    "hookSpecificOutput": {
      "hookEventName": "BeforeAgent",
      "additionalContext": $msg
    }
  }'
