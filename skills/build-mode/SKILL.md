---
name: build-mode
description:
  Executes plans and requests requiring project modifications with a
  verification-first mindset. Use when you need to perform write
  operations and ensure quality standards.
---

# Build mode

**`GOAL`**: Execute project modifications safely and efficiently
following standard build protocols.

**`WHEN`**: Invoke this skill when the user requests changes to the
codebase, refactoring, or feature implementation.

**`NOTE`**: This skill requires explicit user authorization for
high-risk operations and always restores read-only mode upon completion.

## Efficiency directives

- Optimize all operations for agent, token, and context efficiency
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

### Step 2: Execute plan

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
- Verify changes through tests, linting, or builds.

### Step 3: Restore safety

- Invoke the `readonly-mode` skill.

### Step 4: Report

- Provide a concise summary of the work completed and verification
  results.
- **`DONE`**

## Output

**Files created/modified:**

- Project files modified during execution.
- `.gemini_readonly` - Restored at the end.

**Status communication:** Report summary of modifications and
verification status.
