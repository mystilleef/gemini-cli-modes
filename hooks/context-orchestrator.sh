#!/bin/sh

# --- Context Orchestrator ---
# Aggregates context from multiple sources and ensures a safety baseline.
# Dependencies: realpath (optional), jq (optional)

set -eu

# 1. Read input from stdin to maintain compatibility with hook architecture
# shellcheck disable=SC2034
input=$(cat)

# 2. Define Core Safety Baseline
# Includes E-Prime, Git Protocol, Task Management, and Vibe Check directives.
CORE_BASELINE='
E-PRIME REMINDER:
  - Strictly enforce your E-Prime directives.
COMMIT PROTOCOL REMINDER:
  - You are STRICTLY PROHIBITED from autonomously staging files or performing Git commits.
  - You MUST obtain explicit user authorization before executing any git write operation.
TASK MANAGEMENT REMINDER:
  - For complex work, then activate your task management system to manage your work.
  - Use the "bd" tool for all task management operations.
  - Always study the bd guide before the first invocation of the bd tool.
VIBE CHECK REMINDER:
  - For complex work, interact with the vibe check mcp to help brainstorm, verify,
    and validate your ideas, plans, or solutions before executing them.
  - Always study the vibe check guide before the first invocation of the vibe check mcp tools.
PRESENTATION REMINDER:
  - Strictly follow your response presentation directive in your response presentation guide.
'

# 3. Main Execution Logic
main() (
  if command -v realpath > /dev/null 2>&1; then
    project_root=$(realpath "${GEMINI_PROJECT_DIR:-.}" 2> /dev/null || echo ".")
  else
    project_root="${GEMINI_PROJECT_DIR:-.}"
  fi
  marker="${project_root}/.gemini_readonly"

  if [ -f "${marker}" ]; then
    system_msg="READONLY MODE"
    dynamic_ctx="Strictly enforce your read-only directives.

Enclose responses within '🔒 READONLY MODE' indicators.

For example:

🔒 READONLY MODE

This is a response in a read-only session.

🔒 READONLY MODE

IMPORTANT: If you successfully remove the '.gemini_readonly' marker during this turn, you MUST stop using these indicators immediately for the remainder of your response."
  else
    system_msg="BUILDER MODE"
    dynamic_ctx="You are in Builder Mode. You have full write access. Do NOT show the '🔒 READONLY MODE' indicators."
  fi

  # Swapped order: Baseline first, then Dynamic Context
  full_context="${CORE_BASELINE} ${dynamic_ctx}"

  if command -v jq > /dev/null 2>&1; then
    jq -n \
      --arg context "${full_context}" \
      --arg system_msg "${system_msg}" \
    '{
      decision: "allow",
      systemMessage: $system_msg,
      hookSpecificOutput: {
        hookEventName: "BeforeAgent",
        additionalContext: $context
      }
    }'
  else
    # Fallback for environments without jq
    # Escape backslashes, double quotes, and newlines for JSON
    # We use a subshell and sed/tr for POSIX-compliant escaping
    esc_context=$(printf '%s' "${full_context}" | sed 's/\\/\\\\/g; s/"/\\"/g; s/$/\\n/' | tr -d '\n')
    # Remove the trailing \n added by sed for the last line
    esc_context="${esc_context%\\n}"

    printf '{"decision": "allow", "systemMessage": "%s", "hookSpecificOutput": {"hookEventName": "BeforeAgent", "additionalContext": "%s"}}\n' \
      "${system_msg}" "${esc_context}"
  fi
)

main
