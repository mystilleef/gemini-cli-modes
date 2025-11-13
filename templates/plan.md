# Strategic Plan

## 1. Understanding the Goal

**User Goal:** [Clear restatement of what the user wants to accomplish]

**Success Criteria:** [What "done" looks like]

---

## 2. Risk Level Assessment

**Risk Classification:** [TRIVIAL 🟢 / LOW 🟡 / MEDIUM 🟠 / HIGH 🔴]

**Justification:**
- **Scope of Impact:** [Localized/Multiple components/System-wide]
- **Verification Coverage:** [Existing tests/Partial coverage/No tests]
- **Architectural Complexity:** [Simple/Moderate/High coupling/Dependencies]
- **Security/Data Concerns:** [None/Authentication/Authorization/Sensitive data]
- **Reversibility:** [Easily reversible/Requires migration/Irreversible]

**PRAR Cycle Depth:** Based on this risk level, this plan follows [minimal/standard/comprehensive] PRAR rigor.

---

## 3. Investigation & Analysis

**Files Investigated:**
- [List key files read and their relevance]

**Search Results:**
- [Key findings from code searches]

**Knowledge Base References:**
- [Relevant kbase files consulted and applicable patterns]

**Critical Questions & Answers:**
- [What questions were answered during investigation]

**Dependencies Identified:**
- [Components, libraries, or systems this change depends on or affects]

---

## 4. Proposed Strategic Approach

**Phase 1: [Phase Name]** (e.g., Preparation, Test Setup)
- [Description of work in this phase]
- [Key deliverables]

**Phase 2: [Phase Name]** (e.g., Implementation - Red)
- [Description of work in this phase]
- [Key deliverables]

**Phase 3: [Phase Name]** (e.g., Implementation - Green)
- [Description of work in this phase]
- [Key deliverables]

**Phase 4: [Phase Name]** (e.g., Refactoring, Optimization)
- [Description of work in this phase]
- [Key deliverables]

**Note:** Emphasize Test-Driven Development (TDD) approach, including "Red-Green-Refactor" cycle where applicable.

---

## 5. Verification Strategy

### Explicit Test Plan

**New Test Cases:**
- `test_name_1` in `path/to/test_file.ext` - [What it verifies]
- `test_name_2` in `path/to/test_file.ext` - [What it verifies]

**Modified Test Cases:**
- `existing_test_name` in `path/to/test_file.ext` - [Changes needed]

**Test Types:**
- [ ] Unit tests
- [ ] Integration tests
- [ ] End-to-end tests
- [ ] Performance tests
- [ ] Security tests

### Mandatory Verification Checklist

- [ ] All code changes have corresponding tests
- [ ] Tests fail before implementation (Red phase)
- [ ] Tests pass after implementation (Green phase)
- [ ] Code quality checks pass (linting, type checking)
- [ ] Build succeeds
- [ ] Coverage thresholds maintained or improved
- [ ] No regressions in existing functionality

### Success Metrics

- **Coverage Target:** [Percentage or specific areas]
- **Performance Baseline:** [If applicable]
- **Quality Gates:** [Linting, type checking, build requirements]

---

## 6. Anticipated Challenges & Considerations

**Technical Challenges:**
- [Challenge 1 and mitigation strategy]
- [Challenge 2 and mitigation strategy]

**Dependencies & Risks:**
- [External dependency or risk and contingency plan]

**Trade-offs:**
- [Trade-off 1: what's gained vs. what's sacrificed]

**Edge Cases:**
- [Edge cases to handle and how]

---

## 7. Draft of Changes

**Files to Create:**
```
path/to/new_file.ext
```

**Files to Modify:**

```diff
path/to/existing_file.ext
--- before
+++ after
@@ line_numbers @@
-removed line
+added line
 unchanged line
```

**Files to Delete:**
- `path/to/obsolete_file.ext` - [Reason for deletion]

---

## 8. Context for Implementation

**Files to Monitor:**
- [List files that may be affected indirectly]
- [Configuration files that might need updates]

**Verification Artifacts:**
- Test files: [Paths]
- Coverage reports: [Where to find them]
- Build outputs: [What to check]

**Rollback Strategy:**
- [How to revert if implementation fails]
- [What state to restore]
- [Data migrations to reverse, if any]

**Implementation Notes:**
- [Special considerations for the ACT phase]
- [Sequence dependencies]
- [Manual steps required]
