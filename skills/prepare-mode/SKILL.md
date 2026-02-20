---
name: prepare-mode
description:
  Investigates and creates a preparation roadmap to accomplish a task.
  Use when you need a detailed roadmap for a complex objective.
---

# Prepare mode

**`GOAL`**: Transform vague objectives into actionable, verified
preparation roadmaps following standard preparation protocols.

**`WHEN`**: Invoke this skill when the user requests a roadmap,
investigation, or strategic approach for a complex task.

**`NOTE`**: This skill operates strictly in read-only mode to ensure
safety during investigation.

## Efficiency directives

- Optimize all operations for agent, token, and context efficiency
- Prefer reading over writing during the preparation phase
- Batch information gathering to reduce tool calls
- Target only relevant files
- Reduce token usage

## Confirmation directives

_After_ presenting the preparation roadmap, use the `ask_user` tool to
offer 4 options:

1. **Review plan** - Invoke the `review-mode` skill for a technical audit
2. **Quick build** - Invoke the `build-mode` skill for rapid execution
3. **Implement** - Invoke the `implement-mode` skill for thorough
   execution
4. **Abort** - Cancel the workflow and wait for the next instruction

Make option 1 the default response. Assume "Review plan" if the user
gives an empty response.

## Workflow

### Step 1: Enforce read-only

- Invoke the `readonly-mode` skill.
- Capture status (`SUCCESS`, `WARN`, `ERROR`).
- Handle status:
  - `ERROR`: Halt and report.
  - `SUCCESS`/`WARN`: Continue.

### Step 2: Investigate

- Conduct a thorough audit of the request and codebase.
- **Contextual audit**: Read relevant files, documentation, and logs.
- **Dependency mapping**: Identify logical dependencies and risks.
- **Constraint verification**: Verify environment limits and policies.

### Step 3: Draft roadmap

- Create a roadmap following the 8-part structure:
  1. **Objective**: Concise statement of the goal.
  2. **Pre-flight checklist**: Verification steps before starting.
  3. **Strategic approach**: High-level method.
  4. **Actionable steps**: Numbered list of specific operations.
  5. **Verification roadmap**: How to prove the work's correctness.
  6. **Risk assessment**: Potential pitfalls and solutions.
  7. **Resource requirements**: Tools, files, or permissions needed.

### Step 4: Analyze & refine

- Perform Multi-perspective analysis:
  - **The Architect**: Structural integrity and scalability.
  - **The Security Engineer**: Safety, permissions, and vulnerabilities.
  - **The Implementer**: Practicality, efficiency, and clarity.
- Adjust the roadmap based on analysis results.
- Verify compliance with `kbase/agent-protocols.md`.

### Step 5: Present

- Deliver the final preparation roadmap to the user for approval.

### Step 6: Confirmation

- Use the `ask_user` tool for confirmation with 4 options.
- Await user response before further action.
- **`DONE`**

## Preparation roadmap format

**Preparation roadmap:**

1. **Objective**: [Goal]
2. **Pre-flight checklist**: [Steps]
3. **Strategic approach**: [Method]
4. **Actionable steps**: [List]
5. **Verification roadmap**: [Proof]
6. **Risk assessment**: [Pitfalls]
7. **Resource requirements**: [Needs]

## Output

**Files created/modified:**

- None (Read-only operation).
- `.gemini_readonly` - Ensured at the start.

**Status communication:**

First line of output indicates user's decision:

- `REVIEW: user wants to review the plan` - user chose review
- `BUILD: user wants to build the plan` - user chose quick build
- `IMPLEMENT: user wants to implement the plan` - user chose
  implementation
- `ABORT: user cancelled workflow` - user aborted process

**Following lines:** complete preparation roadmap text
