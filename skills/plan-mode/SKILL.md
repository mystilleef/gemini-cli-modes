---
name: plan-mode
description:
  Investigates and creates a strategic plan to accomplish a task. Use
  when you need a detailed roadmap for a complex objective.
---

# Plan mode

**`GOAL`**: Transform vague objectives into actionable, verified
strategic plans following standard planning protocols.

**`WHEN`**: Invoke this skill when the user requests a roadmap,
investigation, or strategic approach for a complex task.

**`NOTE`**: This skill operates strictly in read-only mode to ensure
safety during investigation.

## Efficiency directives

- Optimize all operations for agent, token, and context efficiency
- Prefer reading over writing during the planning phase
- Batch information gathering to reduce tool calls
- Target only relevant files
- Reduce token usage

## Workflow

### Step 1: Enforce Read-Only

- Invoke the `readonly-mode` skill.
- Capture status (`SUCCESS`, `WARN`, `ERROR`).
- Handle status:
  - `ERROR`: Halt and report.
  - `SUCCESS`/`WARN`: Continue.

### Step 2: Investigate

- Conduct a thorough audit of the request and codebase.
- **Contextual Audit**: Read relevant files, documentation, and logs.
- **Dependency Mapping**: Identify logical dependencies and risks.
- **Constraint Verification**: Verify environment limits and policies.

### Step 3: Draft plan

- Create a plan following the 8-part structure:
  1. **Objective**: Concise statement of the goal.
  2. **Pre-flight Checklist**: Verification steps before starting.
  3. **Strategic Approach**: High-level method.
  4. **Actionable Steps**: Numbered list of specific operations.
  5. **Verification Plan**: How to prove the work's correctness.
  6. **Risk Assessment**: Potential pitfalls and solutions.
  7. **Resource Requirements**: Tools, files, or permissions needed.
  8. **Vibe Check Points**: Specific moments to pause and re-evaluate.

### Step 4: Analyze & refine

- Perform Multi-Perspective Analysis:
  - **The Architect**: Structural integrity and scalability.
  - **The Security Engineer**: Safety, permissions, and vulnerabilities.
  - **The Implementer**: Practicality, efficiency, and clarity.
- Adjust the plan based on analysis.
- Verify compliance with `kbase/engineering-principles.md` and
  `kbase/agent-protocols.md`.

### Step 5: Present

- Deliver the final strategic plan to the user for approval.
- **`DONE`**

## Strategic plan format

**Strategic plan:**

1. **Objective**: [Goal]
2. **Pre-flight Checklist**: [Steps]
3. **Strategic Approach**: [Method]
4. **Actionable Steps**: [List]
5. **Verification Plan**: [Proof]
6. **Risk Assessment**: [Pitfalls]
7. **Resource Requirements**: [Needs]
8. **Vibe Check Points**: [Pauses]

## Output

**Files created/modified:**

- None (Read-only operation).
- `.gemini_readonly` - Ensured at the start.

**Status communication:** Report the detailed strategic plan.
