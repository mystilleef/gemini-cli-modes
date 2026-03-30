---
name: build-mode
description: "Edits source files, updates configurations, and runs tests to execute a prepared roadmap or user request. Activates write access, applies changes, verifies with tests/lints/builds, then restores read-only mode. Use when the user says 'build this', 'make these changes', 'implement the plan quickly', or requests codebase modifications, refactoring, or feature implementation."
---

# Build mode

**`GOAL`**: Execute project modifications safely — activate write access, apply changes, verify correctness, and restore read-only mode.

**`WHEN`**: Invoke this skill when the user requests changes to the codebase, refactoring, or feature implementation.

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

### Step 2: Execute changes

- Review the roadmap or request to identify prerequisites and order of operations.
- Assess risk level for each change:
  - **TRIVIAL**: Typos, comments, formatting — apply directly.
  - **LOW**: Single-file edits with clear scope — apply and verify.
  - **MEDIUM**: Multi-file changes or dependency updates — verify each step before proceeding.
  - **HIGH**: Architectural changes, security-sensitive code, or data migrations — confirm with user before each major step.
- Perform modifications.
- After each logical group of changes, run the project's test suite, linter, or build command to catch regressions early.

### Step 3: Restore safety

- Invoke the `readonly-mode` skill.

### Step 4: Report

- Provide a concise summary of the work completed and verification results.
- **`DONE`**

## Output

**Files created/modified:**

- Project files modified during execution.
- `.gemini_readonly` - Restored at the end.

**Status communication:** Report summary of modifications and verification status.
