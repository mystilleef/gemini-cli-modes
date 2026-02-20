#!/bin/sh

# --- Read-Only State Reminder Hook ---
# Detects .gemini_readonly marker and provides appropriate system instructions.
# Optimized for POSIX compliance and state transition awareness.
# Dependencies: realpath (optional), jq (optional)

set -eu

# 0. Read input from stdin to maintain compatibility with hook architecture
# shellcheck disable=SC2034
input=$(cat)

# 1. Define Reminders
READONLY_REMINDER='READONLY MODE REMINDER:
- Strictly enforce your read-only directives.
- Enclose responses within "🔒 READONLY MODE" indicators.
- Example:
  🔒 READONLY MODE
  This is a response in a read-only session.
  🔒 READONLY MODE
- IMPORTANT: If you successfully remove the ".gemini_readonly" marker during this turn, you MUST stop using these indicators immediately for the remainder of your response.'
readonly READONLY_REMINDER

BUILDER_REMINDER='BUILDER MODE REMINDER: You have full write access. Do NOT show the "🔒 READONLY MODE" indicators.'
readonly BUILDER_REMINDER

# 2. Resolve Project Root
if command -v realpath > /dev/null 2>&1; then
  project_root=$(realpath "${GEMINI_PROJECT_DIR:-.}" 2> /dev/null || echo ".")
else
  project_root="${GEMINI_PROJECT_DIR:-.}"
fi

marker="${project_root}/.gemini_readonly"

# 3. Determine Mode and Context
if [ -f "${marker}" ]; then
  system_msg="READONLY MODE"
  context="${READONLY_REMINDER}"
else
  system_msg="BUILDER MODE"
  context="${BUILDER_REMINDER}"
fi

# 4. Output JSON (with jq fallback)
if command -v jq > /dev/null 2>&1; then
  jq -n \
    --arg sys "${system_msg}" \
    --arg ctx "${context}" \
  '{
      decision: "allow",
      systemMessage: $sys,
      hookSpecificOutput: {
        hookEventName: "BeforeAgent",
        additionalContext: $ctx
      }
    }'
else
  # POSIX-compliant JSON escaping
  # Escape backslashes, double quotes, and newlines for JSON
  esc_ctx=$(printf '%s' "${context}" | sed 's/\\/\\\\/g; s/"/\\"/g; s/$/\\n/' | tr -d '\n')
  # Remove the trailing \n added by sed for the last line
  esc_ctx="${esc_ctx%\\n}"

  printf \
  '{
    "decision": "allow",
    "systemMessage": "%s",
    "hookSpecificOutput": {
      "hookEventName": "BeforeAgent",
      "additionalContext": "%s"
    }
  }\n' \
    "${system_msg}" "${esc_ctx}"
fi
