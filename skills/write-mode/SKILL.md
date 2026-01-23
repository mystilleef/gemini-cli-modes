---
name: write-mode
description:
  Deactivates read-only safety. Use when the user authorizes changes or
  requests write access.
---

# Write mode

**`GOAL`**: enable write operations by removing the `lockdown` marker.

**`WHEN`**: user explicitly authorizes changes or requests write access.

## Efficiency directives

- **`DON'T`** use your task management tool for this skill
- Optimize all operations for agent, token, and context efficiency
- Optimize for minimal output
- Reduce token usage

## Workflow

- Run `skills/write-mode/scripts/write-mode.sh`
- Capture status from output (`SUCCESS`, `WARN`, `ERROR`)
- Report status to user
- **`DONE`**
