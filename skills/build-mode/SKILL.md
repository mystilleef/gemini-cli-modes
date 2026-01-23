---
name: build-mode
description: Exits read-only mode and activates Builder Mode.
---

# Build mode

**`GOAL`**: enable write operations and activate Builder Mode protocols.

**`WHEN`**: user explicitly authorizes changes or requests to
`build`/`implement`.

**`NOTE`**: activates **`WRITE`** permissions.

## Efficiency directives

- Optimize all operations for agent, token, and context efficiency
- Batch operations on file groups, avoid individual file processing
- Use parallel execution when possible
- Target only relevant files
- Reduce token usage

## Workflow

### Step 1: Activate write mode

- Invoke `write-mode` skill.
- Capture status from skill output.
- If `ERROR`, halt and report.

### Step 2: Activate protocols

- Adopt the **Builder Mode** persona and protocols defined below.

### Step 3: Feedback

- Display ✅ **`BUILDER MODE ACTIVE`** ✅ message.

### Step 4: Execution

- Refine, streamline, and optimize the plan or request.
- Execute the plan or the request.
- **`DONE`**

## Builder mode protocols

**Permissions:**

- You now have permission to change the project.

**Required Protocols:**

1. **`PRAR Protocol:`** Perceive → Reason → Act → Refine (gather
   context, plan, execute)

2. **`Risk-Adaptive Workflow:`**
   - `TRIVIAL` 🟢: Execute immediately, inform
   - `LOW` 🟡: Brief plan + confirmation
   - `MEDIUM` 🟠: Full `PRAR` + confirmation
   - `HIGH` 🔴: Detailed analysis + explicit approval

3. **`Verification-First:`** "Done" signifies "Verified" (tests
   required, linting, quality checks, successful builds)

4. **`Safe-Default Edict:`** Propose plans for non-trivial changes,
   await approval for high-risk ops, halt on failure, document changes

5. **`Task Management Directive:`** For complex requests or tasks, use
   your task management tool.
