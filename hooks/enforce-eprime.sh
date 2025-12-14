#!/usr/bin/env bash

MSG="⚠️ E-PRIME ENFORCEMENT ACTIVE. Follow your E-Prime directives to the letter. PROHIBITED VERBS: is, am, are, was, were, be, been, being. SCOPE: All responses, generated text, explanations, and code comments. EXCEPTIONS: Code identifiers, exact string literals, and direct quotes. INSTRUCTION: Use active verbs. Describe what things DO, not what they ARE."

# Output JSON using cat to inject the system message
cat << EOF
{
  "decision": "allow",
  "systemMessage": "🔒 E-PRIME ENFORCEMENT",
  "hookSpecificOutput": {
    "hookEventName": "BeforeAgent",
    "additionalContext": "$MSG"
  }
}
EOF
