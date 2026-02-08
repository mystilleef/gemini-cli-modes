---
name: review-mode
description:
  Critically reviews plans, code, and strategies. Use when you need a
  technical review to identify flaws, risks, and improvements.
---

# Review mode

**`GOAL`**: Conduct critical technical reviews of plans, code, and
strategies following standard review protocols.

**`WHEN`**: Invoke this skill when the user requests a critical review
of a plan or proposed changes.

**`NOTE`**: This skill operates strictly in read-only mode to ensure
safety during analysis.

## Efficiency directives

- Optimize all operations for agent, token, and context efficiency
- Optimize for minimal output
- Batch operations on file groups, avoid individual file processing
- Target only relevant files
- Reduce token usage

## Workflow

### Step 1: Enforce Read-Only

- Invoke the `readonly-mode` skill.
- Capture status (`SUCCESS`, `WARN`, `ERROR`).
- Handle status:
  - `ERROR`: Halt and report.
  - `SUCCESS`/`WARN`: Continue.

### Step 2: Perceive

- Read the plan, code, or context provided for review.

### Step 3: Analyze

- Apply the 6-step reasoning engine:
  1. **Analyze**: Context, objectives, and proposed changes.
  2. **Evaluate**: Risks from Security, QA, and Ops perspectives.
  3. **Identify**: Missing edge cases, logical flaws, and debt.
  4. **Revise**: Understanding based on deep-dive analysis.
  5. **Incorporate**: `KBase` patterns and project constraints.
  6. **Retry**: If analysis yields insufficient confidence.
- Execute Multi-perspective analysis across five viewpoints:
  - **Security**: Vulnerabilities, permissions, data handling.
  - **QA**: Test coverage, testability, regression risks.
  - **Architecture**: Design patterns, scalability, maintainability.
  - **Performance**: Latency, resource usage, optimization.
  - **DevOps**: Deployment, monitoring, infrastructure impact.

### Step 4: Critique & assess risk

- Compare against `KBase` and best practices.
- Re-evaluate the risk level (`TRIVIAL`, `LOW`, `MEDIUM`, `HIGH`).

### Step 5: Report

- Output the structured review decision.
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

**Status communication:** Report the detailed review decision.
