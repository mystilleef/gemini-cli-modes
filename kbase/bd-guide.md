# Task management guide for beads

Use `beads` (`bd`) as your default task management tool for **`ALL`**
tasks.

**`NOTE`**: don't use markdown `TODOs`.

## Task management protocol

Use your task management system to manage and optimize tasks, requests,
plans, memory, state, context, and workflows.

## Task management directives

For complex work:

- Split the work into cohesive individual tasks.
- Track, revise, merge, update, and optimize tasks, as needed.
- Address every task to completion.

## Usage guidance

**Interaction (no `bd`)**: ephemeral, read-only, or immediate queries.

- _Examples:_ "What does this function do?" "List files in `src`."

**Task (use `bd`)**: persists state, modifies code, or requires
multi-step planning.

- _Examples:_ "Refactor `auth.ts`." "Fix bug #123." "Investigate
  performance issues."

**Transition rule**: if an interaction reveals necessary work,
immediately convert it to a task via `bd create`.

## Operations

| Action       | Command                                                                         | Context                             |
| :----------- | :------------------------------------------------------------------------------ | :---------------------------------- |
| **Check**    | `bd ready --json`                                                               | Find unblocked work                 |
| **Create**   | `bd create "Title" -d "Desc" --acceptance "Criteria" -t <type> -p <0-4> --json` | New task                            |
| **Link**     | `bd create "Title" -d "Desc" --deps discovered-from:<id> --json`                | Linked work                         |
| **Sub-task** | `bd create "Title" -d "Desc" --parent <id> --json`                              | Hierarchical task                   |
| **Claim**    | `bd update <id> --claim --json`                                                 | Start work (assign + `in_progress`) |
| **Close**    | `bd close <id> --reason "Completed" --json`                                     | Finish work                         |

## Definitions

**Types**: `bug` (broken), `feature` (new), `task` (general), `epic`
(parent), `chore` (maintenance) **Priorities**: `0` (Critical), `1`
(High), `2` (Medium), `3` (Low), `4` (Backlog)

## Protocol

1.  **Always** use `--json` and `--description` (or `-d`) flags.
2.  **Always** commit `.beads/issues.jsonl` with code changes.
3.  **Consult** `bd ready` to identify high-priority work.
4.  **Store** planning docs in `history/`.
5.  **Sync** occurs automatically on file change.

## Reference

Use `bd --help` to explore more advanced features and workflows.
