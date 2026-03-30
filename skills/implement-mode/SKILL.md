---
name: implement-mode
description: "Executes an approved roadmap end-to-end: edits source files, refactors modules, updates configs, runs tests and linters, auto-fixes failures, and produces a detailed session summary. Use when the user says 'implement this', 'execute the plan', 'apply these changes thoroughly', or needs autonomous multi-step code changes with built-in troubleshooting."
---

# Implement mode

**`GOAL`**: Execute an approved roadmap or request end-to-end — activate write access, apply changes, verify and fix, then restore read-only mode and report.

**`WHEN`**: Invoke this skill when the user explicitly requests execution of an approved roadmap or request with thorough verification.

**`NOTE`**: Requires explicit user authorization for high-risk operations. Always restores read-only mode upon completion.

## Task management

- Use the native `write_todos` tool for all task management.
- Break down complex work into cohesive subtasks.
- Maintain accurate task statuses (`pending`, `in_progress`, `completed`) to provide visibility via the CLI progress indicator.

## Workflow

### Step 1: Activate write access

- Invoke the `write-mode` skill.
- Capture status (`SUCCESS`, `WARN`, `ERROR`).
- Handle status:
  - `ERROR`: Halt and report.
  - `SUCCESS`/`WARN`: Continue.

### Step 2: Initialize

- Initialize the task list using `write_todos`.
- State the goal, risk level, and management method.

### Step 3: Execute changes

- Review the roadmap to identify prerequisites and order of operations.
- Assess risk level for each change:
  - **TRIVIAL**: Typos, comments, formatting — apply directly.
  - **LOW**: Single-file edits with clear scope — apply and verify.
  - **MEDIUM**: Multi-file changes or dependency updates — verify each step before proceeding.
  - **HIGH**: Architectural changes, security-sensitive code, or data migrations — confirm with user before each major step.
- Perform modifications in the determined order.

### Step 4: Verify & fix

- Run the project's test suite, linter, and build command.
- **On failure:**
  1. **Diagnose:** Read the error output to identify the root cause.
  2. **Fix:** Apply a targeted fix to the failing code.
  3. **Retry:** Re-run the failing command to confirm the fix.
- **Escalation:** If the issue persists after three attempts, halt and report the error details to the user.

### Step 5: Restore safety

- Invoke the `readonly-mode` skill.

### Step 6: Report

- Provide the session summary.
- **`DONE`**

## Session summary format

**Overview:**

- **Objective:** [Goal]
- **Risk:** [Level]
- **Duration:** [Time]

**Tasks:**

- ✅ [Task] - [Result]
- 🔄 [Task] - [Status]
- 📋 [Task] - [Pending]

**Verification:**

- **Tests:** [Pass/Fail]
- **Quality:** [Lint/Build Status]
- **Coverage:** [Status]

**Notes:**

- [Key decisions/blockers]

## Output

**Files created/modified:**

- Project files modified during execution.
- `.gemini_readonly` - Restored at the end.

**Status communication:** Report the detailed session summary.
