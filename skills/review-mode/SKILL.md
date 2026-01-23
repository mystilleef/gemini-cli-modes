---
name: review-mode
description:
  Critically reviews the last proposed plan for flaws and improvements.
---

# Review mode

**`GOAL`**: critically review the last strategic plan to identify flaws,
logical errors, missed edge cases, or improvements _before_ user
approval.

**`WHEN`**: user requests a review of a plan or strategy.

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

- Invoke `readonly-mode` skill.

### Step 2: Analyze plan (perceive)

- Fully understand plan objectives.
- Assess from all specialist perspectives (Security, QA, Architecture,
  Performance, DevOps).
- Compare against `kbase` best practices.

### Step 3: Critique (reason)

- Check risk classification.
- Surface missing considerations.
- Synthesize decision (APPROVE/REVISE/REJECT).

### Step 4: Present review

- Output the review using the structure defined below.
- **`DONE`**

## Output structure

**Review checklist:**

1. **As a Security Engineer**
   - Vulnerability Assessment
   - Security Controls
   - Findings (Critical, Moderate, Best Practices)

2. **As a QA Engineer**
   - Test Coverage
   - Quality Assurance
   - Test Quality
   - Findings (Critical, Moderate, Best Practices)

3. **As a Senior Architect**
   - Design & Architecture
   - Code Quality
   - Long-term Considerations
   - Findings (Critical, Moderate, Best Practices)

4. **As a Performance Engineer**
   - Performance Impact
   - Optimization Opportunities
   - Performance Metrics
   - Findings (Critical, Moderate, Best Practices)

5. **As a DevOps Engineer**
   - Deployment & Operations
   - Operational Concerns
   - Infrastructure
   - Findings (Critical, Moderate, Best Practices)

**Knowledge base alignment:**

- Pattern Compliance
- Deviations

**Risk re-assessment:**

- Original vs. Re-assessed Risk Level
- Justification

**Review decision:**

- Recommendation: APPROVE ✅ / REVISE 🔄 / REJECT ❌
- Critical Issues (Blockers)
- Moderate Concerns (Recommendations)
- Minor Observations
- Confidence Level: `HIGH` 🟢 / `MEDIUM` 🟡 / `LOW` 🔴
- Next Steps

**Review summary:**

- Strengths
- Weaknesses
- Assessment
