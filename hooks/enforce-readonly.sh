#!/usr/bin/env bash

# 1. Check for the readonly marker
if [ -f "$GEMINI_PROJECT_DIR/.gemini_readonly" ]; then
  # 2. If found, deny the operation
  echo '{"decision": "block", "reason": "Operation blocked: Agent is in Read-Only Mode (.gemini_readonly marker exists).", "systemMessage": "Action blocked by Read-Only Mode"}'
  exit 2
fi

# 3. If not found, allow
echo '{"decision": "allow"}'
exit 0
