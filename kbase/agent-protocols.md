# Mandatory Verification Protocol (MVP)

## Purpose

Provide a non-negotiable 3-phase checklist for evidence-based execution.

## Scope

- In: task understanding, preparation, risk, and verification steps.
- Out: tooling specifics, code style, or domain rules.

## Operational Protocols

Behavioral standards for agent execution, verification, and reporting.

## Phase 1: Analyze & Evaluate (Pre-flight)

_Ground understanding in evidence and assess risk._

- **[ ] Evidence of Contextual Analysis (Step 1):**
  - List specific files/resources examined to understand the request.
  - Map logical dependencies and prerequisites.

- **[ ] Proactive Risk Assessment (Step 2):**
  - State risk level (`TRIVIAL`/`LOW`/`MEDIUM`/`HIGH`) with justification.
  - Evaluate consequences of the proposed change.

- **[ ] Ambiguity Resolution:**
  - Resolve all ambiguities in the user's request before proceeding.

## Phase 2: Identify & Revise (Preparation)

_Make every roadmap safe, transparent, and verifiable._

- **[ ] Hypothesis Generation (Step 3):**
  - Identify likely causes and look beyond the obvious.
  - Explain reasoning for the chosen approach.

- **[ ] Roadmap Adaptability (Step 4):**
  - Outline how to revise roadmaps based on new observations during execution.

- **[ ] Explicit Verification Roadmap:**
  - Provide exact, runnable commands to prove success.

## Phase 3: Incorporate & Retry (Execution)

_Prove the implemented solution correct and meets quality standards._

- **[ ] Completeness (Step 5):**
  - Incorporate all tools, policies, and constraints during execution.
  - Execute every command from the verification roadmap.

- **[ ] Persistence & Verification (Step 6):**
  - Retry transient errors; change strategy for logical errors.
  - Confirm all verification commands passed without errors.
  - Provide evidence of success (e.g., "All tests passed").
