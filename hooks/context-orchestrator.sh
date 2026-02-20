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
  - **Init**: Study the bd guide before using the bd tool for the first time.
  - **Task**: Use "bd" for all persistent work; avoid markdown TODOs.
  - **Split**: Break complex work into cohesive tasks.
  - **Verify**: Define executable verification in acceptance criteria.
  - **Context**: Embed file paths and documentation references.
  - **Transition**: Convert discovered work to tasks via "bd create".
  - **Failure**: Upon any "bd" command failure or usage error, you MUST study "kbase/bd-guide.md" before attempting a retry.
  - **E-Prime**: Apply strictly to all task metadata.
VIBE CHECK REMINDER:
  - **Init**: Study the vibe check guide before using the vibe check tools for the first time.
  - **Invoke**: Post-planning, during ambiguity, or before system changes.
  - **Phase**: Define "preparation", "implementation", or "review".
  - **Context**: Include full user prompt and roadmap.
  - **Interrupt**: Treat feedback as a high-priority course correction signal.
  - **Learn**: Log resolved patterns via "vibe_learn".
PRESENTATION REMINDER:
  - Study the response presentation guide before your first response.
  - Activate your response presentation directives.
INQUIRY PROTOCOL:
  - **Technical Docs**: Use ref tools for API, library, and framework specifications.
  - **General Research**: Use Perplexity tools for real-time data, complex reasoning, or deep research.
  - **Selection**: Prioritize ref for implementation details; use Perplexity for architectural patterns or troubleshooting.
  - **Verification**: Cross-reference critical technical findings from Perplexity with official documentation via ref.
'
readonly CORE_BASELINE

# 3. Main Execution Logic
main() (
  full_context="${CORE_BASELINE}"

  if command -v jq > /dev/null 2>&1; then
    jq -n \
      --arg context "${full_context}" \
    '{
      decision: "allow",
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

    printf \
    '{
      "decision": "allow",
      "hookSpecificOutput": {
        "hookEventName": "BeforeAgent",
        "additionalContext": "%s"
       }
    }\n' \
      "${esc_context}"
  fi
)

main
