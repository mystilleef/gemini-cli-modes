# Mode-based workflow for the Gemini CLI

Enforce structured workflows and safety protocols for the Gemini CLI
agent. This project prevents accidental file modifications through a
"Safe-Default" read-only system.

## Use case

The system enforces a four-phase workflow to ensure project safety and
code quality.

1. **Explore (Default):** Every session starts in read-only mode. Use
   this phase to investigate the codebase and define requirements
   without risk of accidental changes.

2. **Plan & Review (Optional):** Use `/plan` to generate a roadmap and
   `/review` to audit it for flaws. These read-only commands ensure
   strategic alignment before execution.

3. **Build (Write):** Execute the plan using `/build` (fast) or
   `/implement` (thorough). These commands grant temporary write access
   to the project.

4. **Reset (Automatic):** The system automatically restores read-only
   mode upon task completion, returning the agent to a safe state.

## Operational modes

| Command      | Mode    | Access | Description                 |
| :----------- | :------ | :----- | :-------------------------- |
| `/readonly`  | Strict  | RO     | Default safety state.       |
| `/plan`      | Plan    | RO     | Strategic investigation.    |
| `/review`    | Review  | RO     | Multi-perspective critique. |
| `/build`     | Builder | RW     | Structured execution.       |
| `/implement` | Exec    | RW     | Autonomous execution.       |
| `/writable`  | Direct  | RW     | Unstructured write access.  |

## Installation

### 1. Deploy files

Place all project files and directories directly into `~/.gemini/`.

```bash
~/.gemini/
├── settings.json   # CRITICAL: Hook configuration
├── SYSTEM.md       # Core operating principles
├── GEMINI.md       # Global directives
├── commands/       # Custom CLI commands
├── hooks/          # Enforcement scripts
├── kbase/          # Knowledge base
└── skills/         # Encapsulated workflows
```

### 2. Configure `settings.json` (CRITICAL)

The Gemini CLI requires `~/.gemini/settings.json` to trigger the hooks
that manage read-only mode. Without this file in the correct location,
the safety system fails to activate.

```json
{
  "context": {
    "loadMemoryFromIncludeDirectories": true,
    "includeDirectories": ["~/.gemini/kbase"]
  },
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "command": ".../enable-readonly-startup.sh"
      }
    ],
    "BeforeAgent": [
      {"matcher": "*", "command": ".../remind-readonly-dynamic.sh"}
    ],
    "BeforeTool": [
      {
        "matcher": "write_file|replace|...",
        "command": ".../enforce-readonly.sh"
      }
    ],
    "SessionEnd": [
      {
        "matcher": "exit",
        "command": ".../disable-readonly-sessionend.sh"
      }
    ]
  }
}
```

### 3. Enable `SYSTEM.md`

Set the environment variable in your shell profile to activate core
principles:

```bash
export GEMINI_SYSTEM_MD="~/.gemini/SYSTEM.md"
```

## System architecture

### Skills system

Skills encapsulate complex logic in `~/.gemini/skills/`. Each directory
contains a `SKILL.md` defining the workflow and efficiency directives.
Commands invoke these skills to maintain consistency across sessions.

### Enforcement hooks

The system relies on four core hooks to manage the `.gemini_readonly`
marker. The `enforce-readonly.sh` hook provides multi-layered security
by blocking write tools and preventing command injection.

## Knowledge base

The `kbase/` directory provides automatic access to technical guides:

- `agent-protocols.md`: `MVP` checklist for evidence-based execution.
- `bd-guide.md`: Task management with beads.
- `cloud-patterns.md`: Deployment, CI/CD, data storage, and production readiness.
- `data-science-workflow.md`: 5-phase analysis workflow.
- `e-prime-protocol.md`: E-Prime communication rules.
- `engineering-principles.md`: Core standards and testing.
- `gemini-prompt-engineering.md`: Prompt engineering best practices.
- `response-presentation-guide.md`: High-bandwidth information interface guidelines.
- `shell-scripting-guide.md`: `POSIX` compliance and portability.
- `ui-ux-design.md`: UI/UX layout, typography, color, and accessibility.
- `vibe-check-guide.md`: `Metacognitive` oversight and pattern interrupts.

## Workflow example

1.  **Start:** Session begins in read-only Explorer Mode via
    `settings.json` hooks.
2.  **Investigate:** Use read-only tools to map the codebase.
3.  **`/plan`:** Generate a strategic roadmap.
4.  **`/review`:** Critique the plan from diverse perspectives.
5.  **`/build`:** Execute the approved plan with write access.
6.  **Exit:** Session cleanup removes the read-only marker.
