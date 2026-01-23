#!/usr/bin/env bash

# Read input from stdin
input=$(cat)

# Define the project root and marker file
PROJECT_DIR="${GEMINI_PROJECT_DIR:-.}"
# Use readlink -f to get the absolute path for robust comparison
MARKER_FILE=$(readlink -f "$PROJECT_DIR/.gemini_readonly")

# Check if the marker exists
if [ -f "$MARKER_FILE" ]; then
  
  # Extract the command string safely using jq
  COMMAND_STR=$(echo "$input" | jq -r '.tool_input.command // empty')

  # Function to determine if a command is allowed
  is_whitelisted() {
    local cmd="$1"
    
    # --- Rule 1: Simple check for the static write-mode script ---
    # Matches the standard invocation path for the skill
    # Relaxed to match 'skills/write-mode/scripts/write-mode.sh' with or without .gemini prefix
    if [[ "$cmd" == *"skills/write-mode/scripts/write-mode.sh"* ]]; then
      return 0
    fi

    # --- Rule 2: Robust check for 'rm' ---
    # Tokenize the command string into an array
    read -ra PARTS <<< "$cmd"
    local executable="${PARTS[0]}"

    # Check if the executable is 'rm' (or /bin/rm, /usr/bin/rm)
    if [[ "$executable" =~ (^|/)rm$ ]]; then
      local target_found=false
      
      # Iterate through arguments to verify targets
      for arg in "${PARTS[@]:1}"; do
        # Stop processing at command separators
        if [[ "$arg" == "&&" || "$arg" == ";" || "$arg" == "|" || "$arg" == "||" ]]; then
            break
        fi
        
        # Ignore flags (arguments starting with -)
        if [[ "$arg" == -* ]]; then
          continue
        fi

        # Resolve the argument to an absolute path
        # Use || true to prevent failure if file doesn't exist (though readlink -f usually handles it)
        local abs_arg=$(readlink -f "$arg" 2>/dev/null)

        if [[ "$abs_arg" == "$MARKER_FILE" ]]; then
          target_found=true
        else
          # If ANY argument is not the marker file, deny the command
          return 1
        fi
      done

      # Only allow if we found the target and didn't return 1 above
      if [ "$target_found" = true ]; then
        return 0
      fi
    fi

    # Default: Deny
    return 1
  }

  if is_whitelisted "$COMMAND_STR"; then
     echo '{"decision": "allow", "reason": "Whitelisted command for disabling read-only mode."}'
     exit 0
  fi

  # Block if not whitelisted
  echo '{"decision": "block", "reason": "Operation blocked: Agent is in Read-Only Mode (.gemini_readonly marker exists).", "systemMessage": "Action blocked by Read-Only Mode"}'

else
  # Allow if marker does not exist
  echo '{"decision": "allow"}'
fi

exit 0