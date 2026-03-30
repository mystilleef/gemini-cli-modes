---
name: review-mode
description: "Performs a multi-perspective technical review of roadmaps, code, or architecture — checking for security vulnerabilities, missing edge cases, scalability issues, and regression risks. Produces a structured report with APPROVE, REVISE, or REJECT recommendation. Use when the user says 'review this', 'critique the plan', 'code review', 'find weaknesses', 'red team this', or needs a devil's advocate analysis before implementation."
---

# Review mode

**`GOAL`**: Conduct critical technical reviews of roadmaps, code, and strategies — identify flaws, risks, and improvements across security, QA, architecture, performance, and DevOps.

**`WHEN`**: Invoke this skill when the user requests a critical review of a roadmap, code, or proposed changes.

**`NOTE`**: Operates strictly in read-only mode to ensure safety during analysis.

## Confirmation directives

_After_ reporting the review decision, use the `ask_user` tool to offer 4 options:

1. **Revise plan** - Invoke the `prepare-mode` skill to address findings
2. **Quick build** - Invoke the `build-mode` skill for rapid execution
3. **Implement** - Invoke the `implement-mode` skill for thorough execution
4. **Abort** - Cancel the workflow and wait for the next instruction

Set the default response based on the review recommendation:

- If recommendation indicates `REVISE` or `REJECT`, make option 1 the default.
- If recommendation indicates `APPROVE`, make option 2 the default.

## Workflow

### Step 1: Enforce read-only

- Invoke the `readonly-mode` skill.
- Capture status (`SUCCESS`, `WARN`, `ERROR`).
- Handle status:
  - `ERROR`: Halt and report.
  - `SUCCESS`/`WARN`: Continue.

### Step 2: Perceive

- Read the roadmap, code, or context provided for review.

### Step 3: Analyze

- Evaluate the subject across five viewpoints:
  - **Security**: Vulnerabilities, permissions, data handling, injection risks.
  - **QA**: Test coverage, testability, regression risks, missing edge cases.
  - **Architecture**: Design patterns, scalability, maintainability, coupling.
  - **Performance**: Latency, resource usage, N+1 queries, unnecessary allocations.
  - **DevOps**: Deployment impact, monitoring gaps, infrastructure changes.
- Cross-reference findings with `KBase` patterns and project constraints.

### Step 4: Critique & assess risk

- Compare against best practices from `KBase`.
- Re-evaluate the risk level (`TRIVIAL`, `LOW`, `MEDIUM`, `HIGH`).

### Step 5: Report

- Output the structured review decision using the format below.

### Step 6: Confirmation

- Use the `ask_user` tool for confirmation with 4 options.
- Await user response before further action.
- **`DONE`**

## Review report format

**Review checklist:**

1. **Security**: [Findings/None]
2. **QA**: [Findings/None]
3. **Architecture**: [Findings/None]
4. **Performance**: [Findings/None]
5. **DevOps**: [Findings/None]

**Risk re-assessment:**

- **Level**: [TRIVIAL/LOW/MEDIUM/HIGH]
- **Justification**: [Reasoning]

**Decision:**

- **Recommendation**: [APPROVE ✅ / REVISE 🔄 / REJECT ❌]
- **Blockers**: [Critical Issues]
- **Concerns**: [Moderate Issues]
- **Next Steps**: [Actionable advice]

## Output

**Files created/modified:**

- None (Read-only operation).
- `.gemini_readonly` - Ensured at the start.

**Status communication:**

First line of output indicates user's decision:

- `REVISE: user wants to revise the plan` - user chose revision
- `BUILD: user wants to build the plan` - user chose quick build
- `IMPLEMENT: user wants to implement the plan` - user chose implementation
- `ABORT: user cancelled workflow` - user aborted process

**Following lines:** complete review report text
