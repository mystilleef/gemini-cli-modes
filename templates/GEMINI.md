# Gemini project: Agent workflow templates

## Directory overview

This directory, `~/.gemini/templates`, contains Markdown templates that
define a structured workflow system for AI agent operations. These
templates guide the agent through the `PRAR` cycle (Perceive → Reason →
Act → Refine), ensuring a systematic process for exploring codebases,
formulating plans, critically reviewing those plans, and tracking task
execution. The purpose ensures rigorous, transparent, and `auditable`
agent operations.

This directory works in conjunction with the `kbase/` directory, which
provides foundational knowledge, protocols, and conventions that agents
reference when applying these templates.

## Template files

The templates in this directory define structured formats for each
operational phase:

- **explore.md**: Template for documenting codebase exploration and
  building system understanding. Provides structured format for
  explaining components, responsibilities, data flow, and verification
  status. This phase builds a `mental model` of the system.

- **plan.md**: Template for creating strategic plans with risk
  assessment, investigation summary, and verification strategy. Includes
  sections for defining user goals, assessing risk, summarizing
  investigation, proposing phased approaches, and defining comprehensive
  verification strategies. Emphasizes Test-Driven Development (`TDD`)
  mindset.

- **review.md**: Multi-perspective review checklist examining plans from
  five engineering perspectives: Security, `QA`, Senior Architect,
  Performance, and `DevOps`. Ensures plans remain robust, secure, and
  well-architected before implementation. Forces risk re-assessment and
  concludes with clear "APPROVE/REVISE/REJECT" decision.

- **tasks.md**: Session tracking template functioning as a "flight
  recorder" for implementation progress. Logs completed, in-progress,
  and pending tasks, along with verification results, session notes, and
  deviations from original plans.

- **readonly.md**: Instructions for activating read-only mode (creates
  `.gemini_readonly` marker in project root).

- **writable.md**: Instructions for deactivating read-only mode (removes
  `.gemini_readonly` marker from project root).

## Key architectural concepts

### The `PRAR` cycle

All agent operations follow the Perceive → Reason → Act → Refine
protocol:

1. **Perceive** (Explore): Read-only investigation phase for context
   gathering
2. **Reason** (Plan + Review): Strategic planning with multi-perspective
   validation
3. **Act** (Execute): Execution of approved plan with live tracking
4. **Refine**: Verification and iteration

### Operational modes

The agent operates in a state machine with mode transitions:

- **Explorer Mode (Default)**: Read-only analysis, reasoning, planning.
  Can't leave without explicit user approval. Forbids state-modifying
  tools.
- **Builder/Fixer Mode**: Temporary write-enabled state for executing
  approved plans. Entry only after user consent via `/implement`,
  "execute" keyword, or explicit confirmation. Must auto-revert to
  Explorer Mode on completion or failure.
- **Read-only `lockdown`**: Enforced when `.gemini_readonly` marker
  exists in project root. Blocks all write operations.

**Mode Transitions:**

- `/readonly` - Enter strict `lockdown` (creates `.gemini_readonly`
  marker)
- `/writable` - Exit `readonly` restriction (removes `.gemini_readonly`
  marker, lightweight)
- `/build` - Enter Builder Mode (removes marker, activates protocols)
- `/implement` - Enter action Mode for `ACT` phase (removes marker,
  executes plan)

### Risk-adaptive operations

Risk categorization determines process rigor and informs the `PRAR`
cycle:

- **TRIVIAL** 🟢: Immediate execution (reading files, searching code,
  explaining concepts)
- **`LOW`** 🟡: Brief plan required, await confirmation (small edits,
  formatting, comments)
- **MEDIUM** 🟠: Full `PRAR` plan required, await confirmation (feature
  additions, refactoring, test changes)
- **`HIGH`** 🔴: Detailed `PRAR` analysis required, explicit approval
  (architectural changes, security modifications, complex deletions)

### Safety protocols

**Read-only mode enforcement**: before `ANY` write operation, check for
`.gemini_readonly` marker in project root via
`test ! -f .gemini_readonly`. If marker exists, block the operation and
instruct user to run `/writable`, `/build`, or `/implement` to enable
writes.

**ALWAYS** prepend the `🔒 READONLY MODE` message to command output as
long as the `.gemini_readonly` marker exists.

## Template usage pattern

Users must not edit these templates directly. The agent uses them to
structure internal thought processes and communicate intentions to users
in clear, consistent formats:

1. Use `explore.md` format to document system understanding (PERCEIVE
   phase)
2. Use `plan.md` format to propose detailed changes (REASON phase)
3. Use `review.md` format to self-critique plans before execution
   (REASON phase)
4. Use `tasks.md` format to log actions and results during
   implementation (`ACT`/REFINE phases)

By following this workflow, agents ensure actions remain deliberate,
well-planned, and verifiable.

## Knowledge base integration

When working with these templates, agents must consult the `kbase/`
directory for:

- **E-Prime Communication**: All output must avoid forms of `to be` (see
  `kbase/e-prime-directive.md`)
- **Commit Standards**: Conventional Commits v1.0.0 format (see
  `kbase/conventional-commit-summary.md`) **Atomic Commits**: Single
  logical changes that allow for independent reversion (see
  `kbase/atomic-commits-best-practices.md`)
- **Verification Protocol**: Three-phase gating (Perceive→Reason,
  Reason→Act, Act→Refine) defined in
  `kbase/agent-verification-protocol.md`
- **Testing Strategy**: Testing pyramid approach (see
  `kbase/testing-strategy.md`)

## Template format conventions

### Code references

Always use `file_path:line_number` format when referencing specific code
locations (for example, `src/auth/login.ts:42`).

### Verification analysis structure

When explaining components using `explore.md` template:

1. Overview (1-2 sentences)
2. Responsibility & Purpose
3. Key Implementation Details (design patterns, notable code, location)
4. Data Flow & Dependencies
5. Verification Analysis (functionality, test coverage, test locations,
   gaps, quality)
6. Notable Observations (code quality, edge cases, security)
7. Proposed Next Steps (6 categories: Continue Exploring, Verification
   Analysis, Quality Assessment, Transition to Planning, External
   Research, Risk Consultation)

### Plan structure

When creating plans using `plan.md` template:

1. Understanding the Goal (user goal, success criteria)
2. Risk Level Assessment (`TRIVIAL`/`LOW`/`MEDIUM`/`HIGH` with
   justification)
3. Investigation & Analysis (files investigated, search results, `kbase`
   references)
4. Proposed Strategic Approach (phased approach, `TDD` emphasis)
5. Verification Strategy (explicit test plan with specific test names
   and paths)
6. Anticipated Challenges & Considerations
7. Draft of Changes (diffs for files to create, change, or delete)
8. Context for Implementation (files to watch, rollback strategy)

## Working with the parent project

The templates directory works in conjunction with:

- **`kbase/`**: Knowledge base containing operational protocols, commit
  standards, and architectural guidelines (~2200 lines of standards).
  See `~/.gemini/kbase/GEMINI.md` for complete index.
  - **`instructions/`**: Protocol files for specific agent behaviors,
    primarily Git operations (generate-commit-message,
    present-git-status, stage-atomic-commit). See
    `~/.gemini/instructions/GEMINI.md` for complete index.-
    **`commands/`**: `TOML` command definitions that compose templates
    and instructions into executable commands

## Development workflow

No build process exists for this directory. Templates exist as pure
Markdown files that the agent reads and applies at runtime. Changes to
templates immediately affect agent behavior on the next invocation.

## Important notes

- Templates emphasize verification-first approach: "Done" means
  "Verified"
- All plans must include explicit, runnable verification commands
- `TDD` approach (Red-Green-Refactor cycle) emphasizes where applicable
- Session tracking via `tasks.md` includes timestamp, risk level,
  verification results, and rollback information
- Review checklist examines plans from five distinct engineering
  perspectives
- All state-modifying actions require user approval per the Safe-Default
  Edict
