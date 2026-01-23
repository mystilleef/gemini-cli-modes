---
name: plan-mode
description:
  Investigates and creates a strategic plan to complete a task.
---

# Plan mode

**`GOAL`**: investigate context and create a strategic plan for the
user's goal.

**`WHEN`**: user requests a plan, strategy, or approach for a task.

**`NOTE`**: operates in **`READ-ONLY`** mode. **`MUST NOT`** change
code.

## Efficiency directives

- Optimize all operations for token and context efficiency
- Batch operations on file groups, avoid individual file processing
- Use parallel execution when possible
- Target only relevant files
- Reduce token usage

## Workflow

### Step 1: Activate read-only

- Invoke `readonly-mode` skill to ensure safety.

### Step 2: Investigate (perceive)

- Review conversation history and exploration context.
- Consult `kbase/` for patterns and protocols.
- Use read/search tools to gather missing context.
- Map dependencies and impact zones.

### Step 3: Create plan (reason)

- Analyze findings against user goal.
- Assess risk level (`TRIVIAL`/`LOW`/`MEDIUM`/`HIGH`).
- Define verification strategy (`TDD`/`Red-Green-Refactor`).

### Step 4: Present plan

- Output the plan using the structure defined below.
- Precede plan with a mandatory pre-flight checklist.
- **`DONE`**

## Output structure

**Pre-flight Checklist:**

- [ ] Alignment with Prime Directives
- [ ] Adherence to Verification-First Development protocol
- [ ] Resolution of all ambiguities
- [ ] Consultation of `kbase` for relevant patterns
- [ ] Exploration phase context captured

**Strategic Plan Template:**

1. **Understanding the Goal**
   - Restate goal and define success criteria.

2. **Risk Level Assessment**
   - Classify risk (`TRIVIAL`/`LOW`/`MEDIUM`/`HIGH`) with justification.
   - Determine `PRAR` cycle depth.

3. **Investigation & Analysis**
   - List files investigated and search results.
   - Cite `kbase` references and critical Q&A.
   - Map dependencies.

4. **Proposed Strategic Approach**
   - Outline phases with `deliverables`.
   - Emphasize `TDD` (`Red-Green-Refactor`).

5. **Verification Strategy**
   - Detail explicit test plan (new/modified tests).
   - Define success metrics and coverage targets.

6. **Anticipated Challenges & Considerations**
   - List technical challenges, risks, and trade-offs.
   - Identify edge cases.

7. **Draft of Changes**
   - Preview exact file modifications (create/change/delete).
   - Use diff format for modifications.

8. **Context for Implementation**
   - List files to track and verification artifacts.
   - Define rollback strategy.
