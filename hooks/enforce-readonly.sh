#!/bin/sh

# --- Secure Read-Only Enforcement ---
# Blocks write operations unless whitelisted.
# Implements strict parsing to prevent command chaining and injection.
# Adheres to POSIX standards.

set -eu

# 1. Robust Input Handling
input=$(cat)

# 2. Project Setup
PROJECT_DIR="${GEMINI_PROJECT_DIR:-.}"

# 3. Whitelist Configuration
# Diagnostic and read-only tools permitted in Read-Only mode
WHITELIST_TOOLS="bd ls git grep find cat stat whoami date echo printf pwd bash sh jq head tail wc file fd rg bat sort uniq cut tr diff basename dirname realpath which uname tree node npm npx pnpm yarn bun tsc eslint prettier jest vitest biome"

# POSIX-compliant absolute path resolution
# Returns absolute path if possible, original path if resolution fails
# Returns empty string for empty input
_get_abs_path() {
  _gap_path="${1}"

  # Validate non-empty input
  if [ -z "${_gap_path}" ]; then
    printf '' >&2
    return 1
  fi

  # Convert to absolute path format
  case "${_gap_path}" in
    /*) _gap_abs="${_gap_path}" ;;
    *) _gap_abs="$(pwd -P)/${_gap_path}" ;;
  esac

  # Extract directory and basename
  _gap_dir="$(dirname "${_gap_abs}")"
  _gap_base="${_gap_abs##*/}"

  # Attempt to resolve to canonical path
  # Falls back to constructed absolute path if directory doesn't exist
  (
    cd "${_gap_dir}" 2> /dev/null || exit 1
    _gap_pwd=$(pwd -P)
    printf '%s/%s\n' "${_gap_pwd}" "${_gap_base}"
  ) || printf '%s\n' "${_gap_abs}"
}

MARKER_FILE=$(_get_abs_path "${PROJECT_DIR}/.gemini_readonly")

# Debug logging helper
# Outputs debug messages to stderr when READONLY_DEBUG=1
# Arguments:
#   $@: Message to log
_debug_log() {
  if [ "${READONLY_DEBUG:-0}" = "1" ]; then
    printf '[READONLY-DEBUG] %s\n' "$*" >&2
  fi
}

# Helper function to check if a tool is whitelisted
# Arguments:
#   $1: Tool name to check
# Returns:
#   0 if whitelisted, 1 otherwise
_is_whitelisted_tool() {
  _iwt_tool="${1}"

  # Always allow QUOTED placeholder and empty segments
  case "${_iwt_tool}" in
    "" | QUOTED) return 0 ;;
    *)
      # Check against whitelist
      for _iwt_allowed in ${WHITELIST_TOOLS}; do
        if [ "${_iwt_tool}" = "${_iwt_allowed}" ]; then
          return 0
        fi
      done
      return 1
      ;;
  esac
}

# Helper function to check if command contains a pattern
# Arguments:
#   $1: Command string
#   $2: Pattern to match
#   $3: Label for debug logging
# Returns:
#   0 if pattern found, 1 otherwise
_check_pattern_match() {
  _cpm_cmd="${1}"
  _cpm_pattern="${2}"
  _cpm_label="${3}"

  case "${_cpm_cmd}" in
    *"${_cpm_pattern}"*)
      _debug_log "${_cpm_label}: Pattern '${_cpm_pattern}' matched"
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# 3. Whitelist Logic
# Determines if a command string is permitted in Read-Only mode.
#
# Arguments:
#   $1: The command string to evaluate.
#
# Returns:
#   0 if the command is whitelisted, 1 otherwise.
#
# Logic:
#   1. Permits specific write-mode transition scripts (Rules 1 & 2).
#   2. Masks quoted content to prevent shell metacharacters inside strings
#      from interfering with chainer detection.
#   3. Blocks dangerous metacharacters (redirection, subshells, variables).
#   4. Splits chained commands (&&, ;, etc.) and validates that every
#      segment starts with a whitelisted diagnostic tool (Rule 3).
#   5. Permits 'rm' only when targeting the read-only marker file (Rule 4).
is_whitelisted() (
  cmd_str="${1}"
  _debug_log "Validating command: ${cmd_str}"

  # --- Rule 1: Inline Write-Mode Script Whitelist ---
  # shellcheck disable=SC2016
  case "${cmd_str}" in
    *'MARKER=".gemini_readonly"'*'rm "$MARKER"'*)
      _debug_log "Rule 1: Inline write-mode script matched"
      return 0
      ;;
    *)
      : # Continue to next rule
      ;;
  esac

  # --- Rule 2: Skill-based Write-Mode Transition ---
  # Note: Path validation happens after masking to prevent bypass via quotes
  case "${cmd_str}" in
    *skills/write-mode/scripts/enable-write-mode.sh* | *skills/readonly-mode/scripts/enable-readonly-mode.sh*)
      # Path found in original command - will be validated post-masking
      _debug_log "Rule 2: Transition script path found in original command"
      rule2_matched=1
      ;;
    *)
      rule2_matched=0
      ;;
  esac

  # --- Security Check: Dangerous Metacharacters (Pre-Masking) ---
  # Block command substitution and backticks in original command
  # These are dangerous even inside double quotes
  case "${cmd_str}" in
    *\$\(* | *\`*)
      _debug_log "Pre-masking: Blocked command substitution or backticks"
      return 1
      ;;
    *)
      : # Continue to masking
      ;;
  esac

  # --- Masking Logic: Handle Quotes and Chainers ---
  # Replace content inside quotes with 'QUOTED' to ignore chainers within strings.
  # Robust awk implementation handles: escaped quotes, ANSI-C quoting, nested quotes
  _debug_log "Masking quoted content..."
  masked_cmd=$(printf '%s\n' "${cmd_str}" | awk '
  BEGIN {
    SQ = sprintf("%c", 39)  # Single quote character
    DQ = sprintf("%c", 34)  # Double quote character
  }
  {
    result = ""
    in_sq = 0      # Inside single quote
    in_dq = 0      # Inside double quote
    in_ansi = 0    # Inside ANSI-C quote ($'"'"'...'"'"')
    escaped = 0    # Next character is escaped

    for (i = 1; i <= length($0); i++) {
      c = substr($0, i, 1)
      next_char = (i < length($0)) ? substr($0, i + 1, 1) : ""

      # State machine for quote handling
      if (escaped) {
        # Previous char was backslash - skip this char
        escaped = 0
      } else if (!in_sq && !in_dq && !in_ansi && c == "$" && next_char == SQ) {
        # Start of ANSI-C quote: $'"'"'
        in_ansi = 1
        i++  # Skip the opening single quote
      } else if (in_ansi) {
        # Inside ANSI-C quote
        if (c == "\\") {
          escaped = 1
        } else if (c == SQ) {
          in_ansi = 0
          result = result "QUOTED"
        }
        # Else: consume character (dont append)
      } else if (in_sq) {
        # Inside single quote
        if (c == SQ) {
          in_sq = 0
          result = result "QUOTED"
        }
        # Else: consume character (dont append)
      } else if (in_dq) {
        # Inside double quote
        if (c == "\\") {
          escaped = 1
        } else if (c == DQ) {
          in_dq = 0
          result = result "QUOTED"
        }
        # Else: consume character (dont append)
      } else {
        # Not inside any quote
        if (c == SQ) {
          in_sq = 1
        } else if (c == DQ) {
          in_dq = 1
        } else {
          result = result c
        }
      }
    }

    # Handle unclosed quotes - treat as quoted content
    if (in_sq || in_dq || in_ansi) {
      result = result "QUOTED"
    }

    print result
  }')
  _debug_log "Masked command: ${masked_cmd}"

  # --- Security Check: Dangerous Metacharacters (Post-Masking) ---
  # Block redirections, subshells, and variable expansions in unquoted parts
  case "${masked_cmd}" in
    *\>* | *\<* | *\$* | *\`* | *\(* | *\)*)
      _debug_log "Post-masking: Blocked dangerous metacharacters in unquoted parts"
      return 1
      ;;
    *)
      : # Continue to validation
      ;;
  esac

  # --- Rule 2 Validation (Post-Masking) ---
  # If Rule 2 matched in original command, verify path also appears in masked command
  # This prevents bypass via quotes: echo "skills/write-mode/scripts/enable-write-mode.sh"
  if [ "${rule2_matched}" = "1" ]; then
    case "${masked_cmd}" in
      *skills/write-mode/scripts/enable-write-mode.sh* | *skills/readonly-mode/scripts/enable-readonly-mode.sh*)
        _debug_log "Rule 2: Path verified in masked command - allowing"
        return 0
        ;;
      *)
        # Path was inside quotes - block
        _debug_log "Rule 2: Path only in quotes - blocking"
        return 1
        ;;
    esac
  fi

  # --- Rule 3: Segment Validation (Diagnostic Tools) ---
  # Split by chainers (&&, ||, ;, |, &) found in the MASKED command.
  _debug_log "Rule 3: Validating command segments..."
  ctrl_a=$(printf '\001')
  segments=$(printf '%s\n' "${masked_cmd}" | sed "s/&&/${ctrl_a}/g; s/||/${ctrl_a}/g; s/;/${ctrl_a}/g; s/|/${ctrl_a}/g; s/&/${ctrl_a}/g")

  all_valid=true
  remaining="${segments}"

  while [ "${remaining}" != "" ]; do
    case "${remaining}" in
      *"${ctrl_a}"*)
        segment="${remaining%%"${ctrl_a}"*}"
        remaining="${remaining#*"${ctrl_a}"}"
        ;;
      *)
        segment="${remaining}"
        remaining=""
        ;;
    esac

    # Trim whitespace and extract the first word
    clean_segment=$(printf '%s\n' "${segment}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    first_word="${clean_segment%% *}"

    # Check if tool is whitelisted
    # shellcheck disable=SC2310
    if ! _is_whitelisted_tool "${first_word}"; then
      _debug_log "Rule 3: Non-whitelisted tool '${first_word}' - blocking"
      all_valid=false
      break
    fi
  done

  if [ "${all_valid}" = "true" ] && [ "${segments}" != "" ]; then
    _debug_log "Rule 3: All segments valid - allowing"
    return 0
  fi

  # --- Rule 4: Write-Mode Transition (Strict Pattern) ---
  # Allow: rm .gemini_readonly (and absolute path variants)
  _debug_log "Rule 4: Checking rm marker file pattern..."
  executable="${cmd_str%% *}"
  if [ "${executable}" = "rm" ]; then
    if [ "${executable}" != "${cmd_str}" ]; then
      args="${cmd_str#* }"
      abs_arg=$(_get_abs_path "${args}")
      if [ "${abs_arg}" = "${MARKER_FILE}" ]; then
        _debug_log "Rule 4: rm targeting marker file - allowing"
        return 0
      fi
    fi
  fi

  _debug_log "No rules matched - blocking"
  return 1
)

# 4. Main Execution
main() {
  # Check if marker exists
  if [ ! -f "${MARKER_FILE}" ]; then
    printf '{"decision": "allow"}\n'
    exit 0
  fi

  # Check for jq
  if ! command -v jq > /dev/null 2>&1; then
    printf '{"decision": "block", "reason": "Security Error: jq missing in Read-Only Mode.", "systemMessage": "Security Error"}\n'
    exit 2
  fi

  # Extract command
  cmd=$(printf '%s\n' "${input}" | jq -r '.tool_input.command // empty')

  # Validate command is not empty
  if [ -z "${cmd}" ]; then
    printf '{"decision": "block", "reason": "Empty command received.", "systemMessage": "Security Error: Invalid Command"}\n'
    exit 1
  fi

  # shellcheck disable=SC2310
  if is_whitelisted "${cmd}"; then
    printf '{"decision": "allow", "reason": "Whitelisted diagnostic/transition command."}\n'
  else
    printf '{"decision": "block", "reason": "Operation blocked: Agent is in Read-Only Mode.", "systemMessage": "Action blocked by Read-Only Mode"}\n'
  fi
}

main
