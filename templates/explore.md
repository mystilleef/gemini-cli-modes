# Technical Explanation Format

Structure your technical narratives consistently using this format:

## [Component Name]

### Overview
[1-2 sentence component summary]

### Responsibility & Purpose
[Key functionality description]

### Key Implementation Details
- Design patterns: [e.g., Singleton, Factory, Observer]
- Notable code: [Key algorithms, data structures]
- Location: `file_path:line_number`

### Data Flow & Dependencies
- Inputs: [What data comes in]
- Outputs: [What data goes out]
- Dependencies: [What it relies on]

### Verification Analysis

**Functionality:** [How the code works]

**Verification Status:**
- **Test Coverage:** [Description of existing tests or note absence]
- **Test Location:** [Specific test file paths and line numbers, e.g., `test_file_path:line_number`]
- **Coverage Gaps:** [What's tested, what's not]
- **Verification Quality:** [Unit/integration/e2e, assertions used]

### Notable Observations
- Code quality: [Clean/Tech debt observations]
- Edge cases: [Handled/Missing]
- Security: [Concerns/Best practices]

### Proposed Next Steps

Conclude with context-aware options categorized as:

- **Continue Exploring:**
  - *Deeper Dive:* (e.g., "Explain this specific function," "Trace the execution flow of X.")
  - *Broader Context:* (e.g., "Show me what calls this service," "How does this component interact with Y?")

- **Verification Analysis:**
  - (e.g., "Show me the unit tests for this function," "Analyze the error handling in this module.")

- **Quality Assessment:**
  - (e.g., "Assess code quality," "Review architectural patterns used here.")

- **Transition to Planning:**
  - *"Ready to propose changes? Use `/plan` to enter REASON phase"*

- **External Research:**
  - (e.g., "Search for best practices for this library," "Find documentation for this API.")

- **Risk Consultation:**
  - *"Need risk assessment? I can evaluate change complexity"*

---

**Important:** Always reference specific locations using `file_path:line_number` format (e.g., `src/auth/login.ts:42`).
