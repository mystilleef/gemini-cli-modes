# Critical Plan Review

## Review Checklist

Critically review your last proposed plan from the following five perspectives:

### 1. As a Security Engineer

**Vulnerability Assessment:**
- Does the plan introduce potential vulnerabilities (injection, XSS, CSRF, etc.)?
- Are authentication and authorization considerations addressed?
- Does it handle sensitive data appropriately?
- Are input validation and sanitization comprehensive?

**Security Controls:**
- Are security best practices followed?
- Is there proper error handling that doesn't leak information?
- Are there rate limiting or abuse prevention considerations?
- Does it comply with security policies in kbase?

**Findings:**
- [ ] **Critical Issues:** [List blocking security concerns]
- [ ] **Moderate Concerns:** [List security improvements]
- [ ] **Best Practices:** [List security strengths]

### 2. As a QA Engineer

**Test Coverage:**
- Is the test plan sufficiently comprehensive?
- Does it cover edge cases, boundary conditions, and negative paths?
- Are there tests for error handling and failure modes?
- Is test data properly defined and realistic?

**Quality Assurance:**
- Are there gaps in the verification strategy?
- Could the proposed changes have unintended side effects?
- Is regression testing addressed?
- Are test environments and dependencies clear?

**Test Quality:**
- Are test assertions specific and meaningful?
- Is the test pyramid balanced (unit/integration/e2e)?
- Are tests maintainable and readable?
- Is test isolation ensured?

**Findings:**
- [ ] **Critical Issues:** [List blocking QA concerns]
- [ ] **Moderate Concerns:** [List testing improvements]
- [ ] **Best Practices:** [List testing strengths]

### 3. As a Senior Architect

**Design & Architecture:**
- Does the plan adhere to project conventions and kbase patterns?
- Is the proposed solution scalable, maintainable, and efficient?
- Is there a simpler or more robust alternative approach?
- Does it introduce technical debt?

**Code Quality:**
- Does it follow SOLID principles?
- Is separation of concerns maintained?
- Are abstractions appropriate and not over-engineered?
- Is the code DRY (Don't Repeat Yourself)?

**Long-term Considerations:**
- How will this age over time?
- Does it create future maintenance burden?
- Is it extensible for anticipated future needs?
- Does it align with the system's architectural direction?

**Findings:**
- [ ] **Critical Issues:** [List blocking architectural concerns]
- [ ] **Moderate Concerns:** [List design improvements]
- [ ] **Best Practices:** [List architectural strengths]

### 4. As a Performance Engineer

**Performance Impact:**
- Could this change impact performance (latency, throughput, memory)?
- Are there algorithmic complexity concerns (O(n²) vs O(n log n))?
- Does it introduce performance regressions?
- Are there unnecessary computations or allocations?

**Optimization Opportunities:**
- Are there obvious optimization opportunities?
- Is caching appropriate and well-designed?
- Are database queries efficient (N+1 queries, missing indexes)?
- Is lazy loading vs eager loading balanced?

**Performance Metrics:**
- Are performance benchmarks or metrics defined?
- Is there a baseline for comparison?
- Are performance tests included?
- Are there performance budgets or SLAs to maintain?

**Findings:**
- [ ] **Critical Issues:** [List blocking performance concerns]
- [ ] **Moderate Concerns:** [List optimization opportunities]
- [ ] **Best Practices:** [List performance strengths]

### 5. As a DevOps Engineer

**Deployment & Operations:**
- Does this affect deployment, CI/CD pipelines, or infrastructure?
- Are there database migrations or schema changes?
- Is configuration management addressed?
- Are environment-specific concerns handled?

**Operational Concerns:**
- Is the rollback strategy clear and feasible?
- Are monitoring and observability considerations addressed?
- Are there logging and debugging implications?
- Does it affect system reliability or availability?

**Infrastructure:**
- Are resource requirements considered (CPU, memory, storage)?
- Does it introduce new dependencies or services?
- Are there backup and disaster recovery implications?
- Is the deployment sequence clear and safe?

**Findings:**
- [ ] **Critical Issues:** [List blocking operational concerns]
- [ ] **Moderate Concerns:** [List DevOps improvements]
- [ ] **Best Practices:** [List operational strengths]

---

## Knowledge Base Alignment

**Pattern Compliance:**
- [ ] Reviewed against relevant kbase documentation
- [ ] Architectural patterns match established conventions
- [ ] Engineering practices align with kbase/software-engineering-best-practices.md

**Deviations:**
- [List any intentional deviations from kbase patterns with justification]

---

## Risk Re-assessment

**Original Risk Level:** [From the plan]

**Re-assessed Risk Level:** [After multi-perspective review]

**Risk Change Justification:**
- [Explain if risk level should change based on review findings]
- [Note if additional mitigations reduce or increase risk]

---

## Review Decision

Based on the multi-perspective analysis:

### Recommendation: [APPROVE ✅ / REVISE 🔄 / REJECT ❌]

#### Critical Issues (Blockers)
- [List any blocking issues requiring plan revision]
- [Each should be specific, actionable, and have clear acceptance criteria]

#### Moderate Concerns (Recommendations)
- [List improvements that would strengthen the plan]
- [These are important but not blocking]

#### Minor Observations
- [List optional enhancements]
- [These are nice-to-have improvements]

### Confidence Level: [HIGH 🟢 / MEDIUM 🟡 / LOW 🔴]

**Justification:** [Brief explanation of confidence assessment based on review findings]

### Next Steps

**If APPROVE ✅:**
- Proceed to `/implement` to execute the plan
- All critical concerns addressed
- Moderate concerns noted for future improvement

**If REVISE 🔄:**
- Return to `/plan` with specific revisions:
  - [List specific changes needed]
  - [Reference which perspective raised the concern]
  - [Suggest alternative approaches if applicable]

**If REJECT ❌:**
Return to Explorer Mode for additional context
- Fundamental issues with approach:
  - [Explain why the plan cannot be salvaged with revision]
  - [Suggest alternative investigation areas]

---

## Review Summary

**Strengths:**
- [Key strengths of the plan]
- [What was done well]

**Weaknesses:**
- [Key weaknesses identified]
- [Areas needing improvement]

**Overall Assessment:**
[1-2 paragraph summary of the review, synthesizing findings from all perspectives]
