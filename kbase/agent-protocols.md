# Mandatory Verification Protocol (MVP)

## Purpose

Provide a non-negotiable 3-phase checklist for evidence-based execution.

## Scope

- In: task understanding, planning, risk, and verification steps.
- Out: tooling specifics, code style, or domain rules.

## Operational Protocols

Behavioral standards for agent execution, verification, and reporting.

## Phase 1: Perceive → Reason Gate

_Ground understanding in evidence, not assumption._

- **[ ] Evidence of Contextual Analysis:**
  - List specific files/resources examined to understand the request
  - Example: "Read `src/user_service` and `tests/test_user_service`"

- **[ ] Ambiguity Resolution:**
  - Resolve all ambiguities in the user's request before proceeding
  - Example: "User confirmed 'update user' refers to changing email
    address only"

## Phase 2: Reason → Act Gate

_Make every plan safe, transparent, and verifiable._

- **[ ] Chain of Thought Justification:**
  - Explain reasoning for chosen approach
  - Example: "Modifying `update_user` function maintains single entry
    point"

- **[ ] Proactive Risk Assessment:**
  - State risk level (Low/Medium/High) with justification
  - Example: "Low risk: affects single function, existing tests provide
    full coverage"

- **[ ] Explicit Verification Plan:**
  - Provide exact, runnable commands to prove success
  - Example: "Verification: `pytest tests/test_user_service`,
    `ruff check src/user_service`"

## Phase 3: Act → Refine Gate

_Prove the implemented solution correct and meets quality standards._

- **[ ] Execution of Verification Plan:**
  - Execute every command from verification plan
  - If any command fails, initiate reflex arc (analyze → adjust → retry)

- **[ ] Evidence of Success:**
  - Confirm all verification commands passed without errors
  - Example: "All tests passed, linter reported zero issues"
