# Gemini Project: Agent Workflow Templates

## Directory Overview

This directory contains a set of Markdown templates that define a
structured workflow for an AI agent. These templates guide the agent
through a systematic process of exploring a codebase, formulating a
plan, critically reviewing that plan, and tracking the execution of
tasks. The overall purpose is to ensure a rigorous, transparent, and
auditable process for any operation the agent performs.

This project works in conjunction with the `kbase` directory, which
provides the foundational knowledge, protocols, and conventions that the
agent references when filling out these templates.

## Key Files

The core of this directory is the set of templates for the agent's
operational phases:

- **`explore.md`**: A template for documenting the initial exploration
  of a codebase or system. It provides a structured format for
  explaining components, their responsibilities, data flow, and
  verification status. This phase is about building a mental model of
  the system.

- **`plan.md`**: A template for creating a detailed strategic plan
  before making any changes. It includes sections for defining the
  user's goal, assessing risk, summarizing the investigation, proposing
  a phased approach, and defining a comprehensive verification strategy.
  It emphasizes a Test-Driven Development (TDD) mindset.

- **`review.md`**: A critical checklist for reviewing a proposed plan
  from multiple engineering perspectives: Security, QA, Senior
  Architect, Performance, and DevOps. This ensures the plan is robust,
  secure, and well-architected before implementation. It forces a
  re-assessment of risk and concludes with a clear
  "APPROVE/REVISE/REJECT" decision.

- **`tasks.md`**: A template for tracking the live status of a session
  where a plan is being implemented. It serves as a "flight recorder,"
  logging completed, in-progress, and pending tasks, as well as
  verification results, session notes, and any deviations from the
  original plan.

- **`readonly.md`**: A file containing instructions on how to activate
  `readonly` mode. This involves creating a `.gemini_readonly` marker
  file.

- **`writable.md`**: A file containing instructions on how to disable
  `readonly` mode. This involves deleting the `.gemini_readonly` marker
  file.

## Usage

These templates are not meant for direct user editing. Instead, they are
used by the AI agent to structure its internal thought process and to
communicate its intentions and progress to the user in a clear and
consistent format.

1.  The agent starts by using `explore.md` to understand the current
    state of the system.
2.  It then uses `plan.md` to propose a detailed set of changes.
3.  Before execution, it uses `review.md` to self-critique the plan.
4.  Finally, during implementation, it uses `tasks.md` to log its
    actions and results.

The `readonly.md` and `writable.md` files are used to manage the agent's
permissions, ensuring that no modifications are made to the user's
system without explicit consent.

By following this workflow, the agent ensures that its actions are
deliberate, well-planned, and verifiable.
