---
name: readonly-mode
description:
  Activates project-wide read-only safety. Use for lockdown and safety
  enforcement.
---

# Read-only mode

**`GOAL`**: enforce read-only safety on the project.

**`WHEN`**: user or agent requests `lockdown` or safety enforcement.

## Efficiency directives

- **`DON'T`** use your task management tool for this skill
- Optimize all operations for agent, token, and context efficiency
- Optimize for minimal output
- Reduce token usage

## Workflow

- Run `skills/readonly-mode/scripts/readonly-mode.sh`
- Capture status from output (`SUCCESS`, `WARN`, `ERROR`)
- Report status to user
- **`DONE`**
