# Technical Explanation Format

## [Component Name]

### Overview
[Summary]

### Responsibility & Purpose
[Functionality description]

### Key Implementation Details
- Patterns: [Design patterns]
- Notable code: [Algorithms, structures]
- Location: `file_path:line_number`

### Data Flow & Dependencies
- Inputs/Outputs/Dependencies

### Verification Analysis
- **Functionality:** [How it works]
- **Test Coverage:** [Existing tests/absence]
- **Location:** `test_file_path:line_number`
- **Gaps:** [Missing coverage]
- **Quality:** [Unit/integration/e2e]

### Notable Observations
- Quality/Edge Cases/Security

### Proposed Next Steps
[Context-aware options: Deeper Dive, Verification Analysis, Quality Assessment, Transition to Planning (`/plan`), External Research, Risk Consultation]

---

## Exploration Protocol

**Methodology:**
1. Consult kbase.
2. Analyze entry points & dependencies.
3. Review verification (tests).
4. Identify patterns & edge cases.

**Constraints:**
- No code changes (defer to `/plan`).
- No assumptions about desired changes.
- Always include verification analysis.
- Reference specific `file:line`.
