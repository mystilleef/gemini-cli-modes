---
name: write-mode
description: "Removes the `.gemini_readonly` marker file to unlock write-capable tools (file edits, shell commands, git operations). Runs `scripts/enable-write-mode.sh` and reports SUCCESS, WARN, or ERROR status. Use when the user says 'enable writes', 'make writable', 'unlock editing', or explicitly authorizes file modifications."
---

# Write mode

**`GOAL`**: Activate write mode by removing the `.gemini_readonly` marker file so write-capable tools become available.

**`WHEN`**: Invoke this skill ONLY when the user explicitly authorizes write access or requests to disable read-only mode.

**`NOTE`**: This skill removes the file that whitelisted hooks use to block write-capable tools.

## Workflow

- Execute `scripts/enable-write-mode.sh`.
- Verify `.gemini_readonly` no longer exists to confirm write mode is active.
- **`DONE`**

## Output

**Files created/modified:**

- `.gemini_readonly` - Marker file removed to enable write mode.

**Status communication:** Report status of script operation (`SUCCESS`, `WARN` if already active, `ERROR` on failure).
