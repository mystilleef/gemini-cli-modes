---
name: implement-mode
description: Executes a strategic plan using `bd` for task management.
---

# `Implement mode`

**`GOAL`**: execute the approved plan autonomously, managing tasks via
`bd` or an internal system.

**`WHEN`**: user approves a plan and requests implementation.

**`NOTE`**: operates in **BUILDER** mode. Activates **`WRITE`**
permissions.

## Efficiency directives

- Optimize all operations for agent, token, and context efficiency
- Optimize for minimal output
- Batch operations on file groups
- Use parallel execution when possible
- Target only relevant files
- Reduce token usage

## Workflow

### Step 1: Activate write mode

- Invoke `write-mode` skill.
- Capture status from skill output.
- If `ERROR`, halt and report.

### Step 2: Initialization

- **Setup:** Following your task management directive, configure your
  task management tool to start tracking and managing tasks.
- **Announce:** State the goal, risk level, and management method.

### Step 3: Execution loop

- Refine, streamline, and optimize the plan, or user's request.
- Use your task management protocol and directives to manage the plan or
  request
- Execute the plan or request.

### Step 4: Troubleshooting & safety

- **On failure:** don't halt immediately.
  1. **Diagnose:** Analyze the error to identify the root cause.
  2. **Fix:** Attempt to resolve the issue autonomously (for example,
     fix code, adjust tests).
  3. **Retry:** Verify the fix.
- **Escalation:** If the issue persists after reasonable attempts (for
  example, 11) or proves critical/unsafe, **`THEN`** halt.
- **Recovery:** If halting, roll back changes if safe, report to the
  user, and revert to Explorer Mode.

### Step 5: Verification & completion

- **Verify:** Run all relevant tests, `linters`, and builds.
- **Finish:** If verification passes, update documentation and provide a
  session summary using the structure below.
- **Exit:** Revert to Explorer Mode.

## Session summary structure

**Overview:**

- **`Objective`:** [Goal]
- **Risk:** [Level]
- **Duration:** [Time]

**Tasks:**

- ✅ [Task] - [Result]
- 🔄 [Task] - [Status]
- 📋 [Task] - [Pending]

**Verification:**

- **Tests:** [Pass/`Fail`]
- **Quality:** [Lint/Build Status]
- **Coverage:** [Status]

**Notes:**

- [Key decisions/blockers]
