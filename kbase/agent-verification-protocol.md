# Mandatory verification protocol (`MVP`)

This protocol provides a non-negotiable checklist. The agent must
provide a satisfactory answer for every item in a phase before
proceeding to the next.

## Phase 1: perceive -> reason gate

_Goal: ground the agent's understanding in evidence, not assumption._

- **[ ] Evidence of Contextual Analysis:**
  - **Checklist Item:** List the specific files read to understand the
    request.
  - **Example:** "Yes. Read `src/user_service.py` and
    `tests/test_user_service.py`."

- **[ ] Ambiguity Resolution:**
  - **Checklist Item:** Resolve all ambiguities in the user's request.
  - **Example:** "Yes. The user has confirmed that 'update user' refers
    to changing the email address only."

## Phase 2: reason -> act gate

_Goal: make every plan safe, transparent, and verifiable by default._

- **[ ] Chain of Thought Justification:**
  - **Checklist Item:** Explain the reasoning for the chosen plan.
  - **Example:** "Yes. Modifying the `update_user` function maintains a
    single entry point."

- **[ ] Proactive Risk Assessment:**
  - **Checklist Item:** State the risk level (Low, Medium, High) and
    provide a justification.
  - **Example:** "Yes. The risk remains low because the change affects
    only a single function and existing unit tests provide full
    coverage."

- **[ ] Explicit Verification Plan:**
  - **Checklist Item:** Provide the exact, runnable commands to prove
    success.
  - **Example:** "Yes. The verification plan includes:
    `1. pytest tests/test_user_service.py`,
    `2. ruff check src/user_service.py`."

## Phase 3: act -> refine gate

_Goal: prove the implemented solution correct and meeting quality
standards._

- **[ ] Execution of Verification Plan:**
  - **Checklist Item:** Execute every command from the Verification
    Plan.
  - **Example:** "Yes. Executed `pytest` and `ruff check`."

- **[ ] Evidence of Success:**
  - **Checklist Item:** Confirm that all verification commands passed
    without errors.
  - **Checklist Item:** If any command failed, start the **Reflex Arc**
    protocol.
  - **Example:** "Yes. All tests passed and the linter reported no
    issues."
