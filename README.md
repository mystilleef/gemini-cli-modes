# Gemini CLI operational modes: a structured workflow

![Read-only Mode Diagram](assets/readonly.png)

This project provides a set of custom commands and templates to enforce
a structured, mode-based workflow for the Gemini CLI agent. These modes
guide the agent through the distinct phases of a software engineering
task—Perceive, Reason, Act, and Refine (`PRAR`)—ensuring a safe,
deliberate, and verifiable process.

**Important:** _Assuming you have hooks properly installed, all sessions
begin in `readonly` mode._

## Core concepts: Operational modes

Each custom command transitions the Gemini CLI agent into a specific
**operational mode**, each with its own set of permissions and
protocols. The system relies on the `.gemini_readonly` marker file,
which enforces a "Safe-Default" `readonly` state, preventing accidental
modifications.

- **Read-Only Modes (`/readonly`):** Assuming you have hooks properly
  installed, the agent starts all sessions in `readonly` mode. The mode
  serves as a perfect base for investigation, analysis, and planning.
  The system disables all file modification tools.
- **Write-Enabled Modes (`/writable`, `/build`, `/implement`):** Use
  these set of commands to disable `readonly` mode and enable file
  modification tools. These modes allow executing an approved plan. The
  agent removes the `.gemini_readonly` marker and enables file
  modification tools under strict protocols.

## Setup and installation

To use these custom modes, place the project files into your
`~/.gemini/` directory and configure your `settings.json` file.

### 1. Required directory structure

Place the files and directories from this project directly inside your
`~/.gemini/` directory. Your `~/.gemini/` folder should look like this:

```bash
~/.gemini/
├── settings.json
├── SYSTEM.md                    # Foundational operating principles
├── GEMINI.md                    # Project-specific directives
├── commands/
│   ├── build.toml
│   ├── implement.toml
│   ├── plan.toml
│   ├── readonly.toml
│   ├── review.toml
│   └── writable.toml
├── hooks/                        # Enforcement and behavior hooks
│   ├── enable-readonly-startup.sh
│   ├── enforce-eprime.sh
│   ├── enforce-readonly.sh
│   └── remind-readonly-dynamic.sh
├── kbase/
│   └── [knowledge base files]
└── templates/
    ├── explore.md
    ├── plan.md
    ├── readonly.md
    ├── review.md
    ├── tasks.md
    └── writable.md
```

### 2. `settings.json` configuration

The `settings.json` file plays a crucial role for the Gemini CLI agent
to locate the `kbase` and `templates` directories, load the main
`GEMINI.md` directive, and configure the required hooks. Copy the
settings in `settings.json` from this project to your own in
`~/.gemini/`. The file includes:

- Context configuration for loading knowledge base and templates
- Model aliases for temperature and output control
- Hook definitions for read-only enforcement

**Key hooks configured:**

- `SessionStart`: Creates `.gemini_readonly` marker and injects
  `readonly` reminders when session begins
- `BeforeAgent`: Injects `readonly` reminders and enforces E-Prime
  communication protocol before agent execution
- `BeforeTool`: Blocks write operations (`WriteFile`, `Edit`, etc.) when
  `.gemini_readonly` marker exists

The configuration follows this structure:

```json
{
  "context": {
    "loadMemoryFromIncludeDirectories": true,
    "includeDirectories": ["~/.gemini/kbase", "~/.gemini/templates"]
  },
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "name": "enable-readonly-startup",
            "type": "command",
            "command": "~/.gemini/hooks/enable-readonly-startup.sh",
            "description": "Enables readonly mode automatically when a session starts"
          }
        ]
      },
      {
        "matcher": "*",
        "hooks": [
          {
            "name": "remind-readonly-session-start",
            "type": "command",
            "command": "~/.gemini/hooks/remind-readonly-dynamic.sh",
            "description": "Injects readonly reminders into agent context at startup"
          }
        ]
      }
    ],
    "BeforeAgent": [
      {
        "matcher": "*",
        "hooks": [
          {
            "name": "remind-readonly-before-agent",
            "type": "command",
            "command": "~/.gemini/hooks/remind-readonly-dynamic.sh",
            "description": "Injects readonly mode reminders into agent context"
          },
          {
            "name": "enforce-eprime",
            "type": "command",
            "command": "~/.gemini/hooks/enforce-eprime.sh",
            "description": "Enforces E-Prime directive by injecting system message"
          }
        ]
      }
    ],
    "BeforeTool": [
      {
        "matcher": "WriteFile|Edit|write_file|replace",
        "hooks": [
          {
            "name": "enforce-readonly",
            "type": "command",
            "command": "~/.gemini/hooks/enforce-readonly.sh",
            "description": "Blocks write operations when .gemini_readonly exists"
          }
        ]
      }
    ]
  }
}
```

### 3. `SYSTEM.md` configuration (environment variable setup)

The `SYSTEM.md` file provides foundational operating principles
including the `PRAR` method, safety philosophy, risk assessment
framework, and operational modes. This file overrides the agent's core
directives when properly configured.

**To enable `SYSTEM.md`:**

Set the `GEMINI_SYSTEM_MD` environment variable to point to the file:

```bash
export GEMINI_SYSTEM_MD="~/.gemini/SYSTEM.md"
```

Or add it to your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):

```bash
echo 'export GEMINI_SYSTEM_MD="~/.gemini/SYSTEM.md"' >> ~/.bashrc
source ~/.bashrc
```

**Important:** The `GEMINI_SYSTEM_MD` environment variable must exist
for `SYSTEM.md` to take effect. Without this variable, the agent uses
its default core directives.

---

### 4. `GEMINI.md` directive configuration

Choose between two options for configuring your main `GEMINI.md`
directive.

#### Option A (recommended): Full integration

For the most robust experience, use the full configuration provided in
this project:

1. Place the `SYSTEM.md` file at the root of your `~/.gemini/` directory
   (and set `GEMINI_SYSTEM_MD` environment variable per section 3).
2. Place the `GEMINI.md` file at the root of your `~/.gemini/`
   directory.
3. Place the `kbase/` directory at the root of your `~/.gemini/`
   directory.
4. Place the `hooks/` directory at the root of your `~/.gemini/`
   directory.
5. Configure hooks in your `~/.gemini/settings.json` (see "Hooks
   integration" section below). **This step ensures the read-only system
   functions correctly.**

`SYSTEM.md` establishes core foundational principles (via
`GEMINI_SYSTEM_MD` environment variable), while `GEMINI.md` provides
global project-specific directives and protocols. The `kbase/` directory
supplies detailed reference documentation. Together they create a
comprehensive operational framework ensuring the agent fully understands
and adheres to the underlying protocols and architectural knowledge
base.

#### Option B: Custom directive integration

If you prefer to use your own `GEMINI.md` directive, ensure you have a
read-only directive in yours. Preferably, just copy the read-only
directive sections from the `GEMINI.md` file provided in this project.

### 5. `.gitignore` configuration

To prevent committing the temporary `.gemini_readonly` marker to your
projects, add it to your global or project-specific `.gitignore` file.

```bash
# .gitignore
.gemini_readonly
```

## Hooks integration (required)

This project includes shell hooks that the read-only mode system
**requires** to function properly. These hooks enforce read-only mode at
the system level and serve as a critical component of the security
model.

**Prerequisite:** _Hooks require the nightly version of the Gemini CLI
app. Ensure you have the nightly build installed. Check your Gemini CLI
version with `gemini --version` and update to the nightly release if you
haven't already._

### Available hooks

#### `enforce-readonly.sh`

Blocks write operations when the `.gemini_readonly` marker exists.
Returns a JSON response denying the operation with clear messaging. This
script functions as a pre-flight check before any write tools execute.

**Location:** `~/.gemini/hooks/enforce-readonly.sh`

#### `remind-readonly-dynamic.sh`

Dynamically injects read-only reminders into agent context based on hook
events. Outputs contextual system messages reinforcing read-only
constraints and operational directives.

**Location:** `~/.gemini/hooks/remind-readonly-dynamic.sh`

#### `enable-readonly-startup.sh`

Automatically creates the `.gemini_readonly` marker file when a new
session starts, ensuring all sessions begin in read-only mode by default
(Safe-Default principle). This hook runs once at session initialization.

**Location:** `~/.gemini/hooks/enable-readonly-startup.sh`

#### `enforce-eprime.sh`

Enforces the E-Prime communication protocol by injecting system messages
that remind the agent to avoid `to be` verbs. E-Prime encourages more
precise, active language and clearer technical communication.

**Location:** `~/.gemini/hooks/enforce-eprime.sh`

### How hooks work

The `settings.json` file configures the hooks to operate as follows:

1. **SessionStart hooks**: When you start a Gemini CLI session:
   - First, `enable-readonly-startup.sh` executes to create the
     `.gemini_readonly` marker (Safe-Default principle)
   - Then, `remind-readonly-dynamic.sh` executes and injects `readonly`
     mode context

2. **BeforeAgent hooks**: Before the agent processes any input:
   - `remind-readonly-dynamic.sh` runs to reinforce `readonly`
     constraints
   - `enforce-eprime.sh` runs to inject E-Prime communication reminders

3. **BeforeTool hook**: When the agent attempts to use write tools
   (`WriteFile`, `Edit`, `write_file`, `replace`), the
   `enforce-readonly.sh` hook intercepts and blocks the operation if
   `.gemini_readonly` marker exists

The hooks use pattern matching (`matcher` field) to apply only when
relevant:

- `SessionStart:` Two `matchers` configured:
  - `matcher: "startup"` for `enable-readonly-startup.sh` (runs once at
    session start)
  - `matcher: "*"` for `remind-readonly-dynamic.sh` (runs on all startup
    events)
- `BeforeAgent`: `matcher: "*"` applies both hooks to all agent
  executions
- `BeforeTool`: `matcher: "WriteFile|Edit|write_file|replace"` applies
  only to write operations

The system requires no further configuration—hooks come pre-configured
in the provided `settings.json` file.

---

## Understanding the operational modes

### `/readonly`

- **Mode:** Strict Read-Only
- **Phase:** PERCEIVE
- **Description:** The default, most restrictive mode forbids all write
  operations.

### Explorer mode (default)

- **Mode:** Explorer Mode
- **Phase:** PERCEIVE
- **Description:** The default read-only mode for understanding code,
  mapping dependencies, and reviewing tests. This mode activates by
  default when a session starts (via `.gemini_readonly` marker). Note:
  The project removed the `/explore` command; Explorer Mode now
  functions as the default operational state.

### `/plan`

- **Mode:** Plan Mode
- **Phase:** REASON
- **Description:** For creating a comprehensive, strategic plan to
  achieve a goal.

### `/review`

- **Mode:** Review Mode
- **Phase:** REFINE
- **Description:** For critically self-reviewing a plan before
  execution.

### `/build`

- **Mode:** Builder Mode
- **Phase:** Act & REFINE
- **Description:** A write-enabled mode for executing plans and building
  solutions.

### `/implement`

- **Mode:** `Execution` Mode
- **Phase:** Act & REFINE
- **Description:** A more structured version of Builder Mode for
  autonomous plan execution.

### `/writable`

- **Mode:** Writable Mode
- **Phase:** Act
- **Description:** Removes the read-only lock, permitting direct write
  operations without a formal plan.

## `E-Prime` Communication protocol

E-Prime represents a variant of English that excludes all forms of the
verb `to be`. This project enforces E-Prime through the
`enforce-eprime.sh` hook to encourage more precise, active technical
communication.

**Why E-Prime?**

- **Clarity**: Forces more specific, descriptive language
- **Precision**: Eliminates ambiguous identity statements
- **Active Voice**: Encourages action-oriented descriptions
- **Reduced Assumptions**: Prevents treating opinions as facts

**Example transformations:**

- `The bug is in the parser` → `The parser contains the bug`
- `This is a security issue` → `This presents a security risk`
- `The code is inefficient` → `The code performs inefficiently`
- `It was fixed yesterday` → `We fixed it yesterday`
- `This approach is better` → `This approach performs better`

**Note:** The E-Prime hook injects reminders without blocking agent
responses. It serves as a communication guideline rather than a strict
enforcement mechanism.

---

![Fix Mode Diagram](assets/fix.png)

## Illustrative workflow example

The following list outlines a typical workflow for using these modes to
fix a bug:

1. **Session Starts in Read-Only Mode:** Your session automatically
   begins with the `.gemini_readonly` marker created by
   `enable-readonly-startup.sh`, ensuring a safe-default state. You
   operate in Explorer Mode, which provides read-only access for
   investigation.
2. **Explore & Gather Context:** You ask the agent to investigate the
   bug. It uses read-only tools to understand the relevant code, trace
   dependencies, and review test coverage.
3. **/plan:** Once enough context accumulates, you ask the agent to
   create a strategic plan. It outlines the steps to fix the bug and,
   crucially, how to verify the fix.
4. **/review:** The agent performs a self-critique of its plan, checking
   for flaws from five engineering perspectives (security, QA,
   architecture, performance, DevOps).
5. **/implement:** With an approved plan, you instruct the agent to
   execute it. The agent removes the read-only lock and performs the
   changes, runs tests, and verifies the fix.
6. **Return to Read-Only:** Upon completion, the agent automatically
   returns to a safe, read-only mode with the `.gemini_readonly` marker
   restored.

## Alternative workflows (expert use)

While the full cycle of `plan`, `review`, and `implement` (with
automatic initial Explorer Mode) provides the most safety and structure,
it often exceeds the needs of simpler tasks or more experienced users.
Here follow two more direct, less token-intensive workflows.

### Direct build workflow: default explorer mode → `/build`

This workflow suits situations where you have a clear goal and don't
need the formal planning and review phases.

1. **Session Starts in Read-Only Mode:** Your session automatically
   begins in Explorer Mode with the `.gemini_readonly` marker enabled
   (Safe-Default).
2. **/build:** Transition directly to the write-enabled "Builder Mode."
   The agent can now change files and execute commands, while still
   benefiting from the structured protocols of this mode.

### Direct write workflow: default explorer mode → `/writable`

This path offers the most direct way to enable write operations and
suits quick, straightforward edits where the overhead of a structured
mode proves unnecessary.

1. **Session Starts in Read-Only Mode:** Your session automatically
   begins in Explorer Mode with the `.gemini_readonly` marker enabled
   (Safe-Default).
2. **/writable:** This command removes the `.gemini_readonly` marker,
   immediately permitting the use of write tools without entering a
   formal mode.
