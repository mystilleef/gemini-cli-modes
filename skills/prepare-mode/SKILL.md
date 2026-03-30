---
name: prepare-mode
description: "Investigates a codebase and produces a structured preparation roadmap with objectives, actionable steps, risk assessment, and verification criteria. Reads source files, maps dependencies, and checks constraints — all in read-only mode. Use when the user says 'plan this', 'prepare a roadmap', 'break this down', 'how should I tackle this', or needs a step-by-step approach before making changes."
---

# Prepare mode

**`GOAL`**: Transform objectives into actionable, verified preparation roadmaps by investigating the codebase and identifying dependencies, risks, and constraints.

**`WHEN`**: Invoke this skill when the user requests a roadmap, investigation, or strategic approach for a complex task.

**`NOTE`**: Operates strictly in read-only mode to ensure safety during investigation.

## Confirmation directives

_After_ presenting the preparation roadmap, use the `ask_user` tool to offer 4 options:

1. **Review plan** - Invoke the `review-mode` skill for a technical audit
2. **Quick build** - Invoke the `build-mode` skill for rapid execution
3. **Implement** - Invoke the `implement-mode` skill for thorough execution
4. **Abort** - Cancel the workflow and wait for the next instruction

Make option 1 the default response. Assume "Review plan" if the user gives an empty response.

## Workflow

### Step 1: Enforce read-only

- Invoke the `readonly-mode` skill.
- Capture status (`SUCCESS`, `WARN`, `ERROR`).
- Handle status:
  - `ERROR`: Halt and report.
  - `SUCCESS`/`WARN`: Continue.

### Step 2: Investigate

- Conduct a thorough audit of the request and codebase.
- **Contextual audit**: Read README, config files, entry points, documentation, and logs relevant to the objective.
- **Dependency mapping**: Identify logical dependencies, import chains, and external service calls.
- **Constraint verification**: Check environment limits, CI requirements, and project policies.

### Step 3: Draft roadmap

- Create a roadmap with these 7 sections:
  1. **Objective**: Concise statement of the goal.
  2. **Pre-flight checklist**: Verification steps before starting.
  3. **Strategic approach**: High-level method.
  4. **Actionable steps**: Numbered list of specific operations.
  5. **Verification plan**: How to prove the work's correctness (test commands, expected outputs).
  6. **Risk assessment**: Potential pitfalls and mitigations.
  7. **Resource requirements**: Tools, files, or permissions needed.

### Step 4: Analyze & refine

- Perform multi-perspective analysis:
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

## Output

**Files created/modified:**

- None (Read-only operation).
- `.gemini_readonly` - Ensured at the start.

**Status communication:**

First line of output indicates user's decision:

- `REVIEW: user wants to review the plan` - user chose review
- `BUILD: user wants to build the plan` - user chose quick build
- `IMPLEMENT: user wants to implement the plan` - user chose implementation
- `ABORT: user cancelled workflow` - user aborted process

**Following lines:** complete preparation roadmap text
