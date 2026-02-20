# Beads task management guide

Use `beads` (`bd`) for **ALL** tasks. Avoid markdown `TODOs`.

## Directives

- **Atomic Tasks**: Split work into cohesive, individual units.
- **Verification**: Define executable steps in acceptance criteria.
- **Context**: Embed file paths and documentation references.
- **Adaptability**: Update metadata immediately upon discovering
  constraints.
- **Templates**: Use `bd formula` and `bd mol` for process consistency.
- **Auditing**: Record reasoning via `bd audit` during complex
  transitions.
- **E-Prime**: Strictly apply E-Prime to all metadata. Exclude `to be`
  verbs.

## Usage guidance

- **Interaction (no `bd`)**: Ephemeral, read-only, or immediate queries.
- **Task (use `bd`)**: Persists state, modifies code, or requires
  multi-step prep.
- **Transition**: Convert discovered work to tasks via `bd create`.

## Operations

- **Check**: `bd ready --json`
  - Find unblocked work.
- **Create**:
  `bd create "Title" -d "Desc" --acceptance "Criteria" -t <type> -p <0-4> --json`
  - Create a new task.
- **Template**: `bd mol pour <proto>`
  - Instantiate a persistent pattern.
- **Link**:
  `bd create "Title" -d "Desc" --deps discovered-from:<id> --json`
  - Create linked work.
- **Sub-task**: `bd create "Title" -d "Desc" --parent <id> --json`
  - Create a hierarchical task.
- **Claim**: `bd update <id> --claim --json`
  - Start work (assign + `in_progress`).
- **Audit**: `bd audit "Reasoning"`
  - Log decision-making context.
- **Close**: `bd close <id> --reason "Completed" --json && bd sync`
  - Finish work.

## Operational Protocol

### 1. Session start (initialization)

- Consult `bd ready --json` for high-priority work.

### 2. Execution (action)

- Use `--json` and `-d` flags for all `bd` operations.
- Execute `bd sync` after closing issues to ensure `JSONL` consistency.
- Store preparation `roadmaps` in `history/`.
- **Efficiency**: Prune context when capacity exceeds 80%. Use shorthand
  (`w/`, `w/o`, `ref`) and symbols (`->`, `=>`, `!`).

### 3. Session end (termination)

- Run `bd sync`

## Agent-led workflow management

Agents autonomously manage workflows by deriving patterns from
foundational directives.

- **Synthesis**: Derive all workflows from directives to ensure
  alignment.
- **Autonomy**: Manage formula lifecycle (`distill`, `cook`, `pour`)
  autonomously.
- **Consistency**: Use foundational formulas (`reasoning`, `rtfv`,
  `audit`) for strategic work.

## Failure Protocol

Upon `bd` operation failure:

1. **Stop** execution.
2. **Study** this guide.
3. **Identify** syntax or protocol violation.
4. **Correct** and **Retry**.

## Reference

Use `bd --help` for advanced features.
