---
name: implement-mode
description:
  Executes approved plans or requests with a verification-first mindset
  and robust troubleshooting. Use when you need to implement specific
  changes and provide a detailed session summary.
---

# Implement-Mode

**`GOAL`**: Execute approved project modifications safely and
efficiently following standard implementation protocols.

**`WHEN`**: Invoke this skill when the user explicitly requests the
execution of an approved plan or request.

**`NOTE`**: This skill requires explicit user authorization for
high-risk operations and always restores read-only mode upon completion.

## Efficiency directives

- Optimize all operations for agent, token, and context efficiency
- Optimize for minimal output
- Batch operations on file groups, avoid individual file processing
- Use parallel execution when possible
- Target only relevant files
- Reduce token usage

## Task management

- Use the `beads` (`bd`) tool for task management if available.
- Always study the `bd guide` before the first invocation of the `bd`
  tool.
- If `beads` is unavailable, fallback to the internal `todo` tool.
- Use the selected task management system to break down, plan, and
  optimize workflow.

## Workflow

### Step 1: Activate write access

- Invoke the `write-mode` skill.
- Capture status (`SUCCESS`, `WARN`, `ERROR`).
- Handle status:
  - `ERROR`: Halt and report.
  - `SUCCESS`/`WARN`: Continue.

### Step 2: Initialize

- Activate the task management system (`beads` or `todo`).
- State the goal, risk level, and management method.

### Step 3: Execute plan

- Apply the 6-step reasoning engine:
  1. **Analyze**: Prerequisites and order of operations.
  2. **Evaluate**: Consequences and risks.
  3. **Identify**: Likely causes and edge cases.
  4. **Revise**: Plans based on observations.
  5. **Incorporate**: All tools, policies, and constraints.
  6. **Retry**: Transient errors.
- Follow the risk-adaptive workflow (`TRIVIAL`, `LOW`, `MEDIUM`,
  `HIGH`).
- Perform modifications.

### Step 4: Verify & fix

- Run tests, linters, and builds.
- **On failure:**
  1. **Diagnose:** Analyze the error to identify the root cause.
  2. **Fix:** Attempt to resolve the issue autonomously.
  3. **Retry:** Verify the fix.
- **Escalation:** If the issue persists after reasonable attempts, halt
  and report.

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
