# Gemini CLI Operational Modes: A Structured Workflow

This project provides a set of custom commands and templates to enforce a structured, mode-based workflow for the Gemini CLI agent. These modes guide the agent through the distinct phases of a software engineering task—Perceive, Reason, Act, and Refine (PRAR)—ensuring a safe, deliberate, and verifiable process.

**Important:** To begin a session, it is recommended to start by using the `/readonly` command to ensure the agent is in a safe, read-only state.

## Core Concepts: Operational Modes

Each custom command transitions the Gemini CLI agent into a specific **operational mode**, each with its own set of permissions and protocols. The core of this system is the `.gemini_readonly` marker file, which enforces a "Safe-Default" state, preventing accidental modifications.

- **Read-Only Modes (`/readonly`, `/explore`, `/plan`, `/review`):** These modes are for investigation, analysis, and planning. All file modification tools are disabled.
- **Write-Enabled Modes (`/writable`, `/build`, `/implement`):** These modes are for executing an approved plan. The `.gemini_readonly` marker is removed, and file modification tools are enabled under strict protocols.

## Setup and Installation

To use these custom modes, you need to place the project files into your `~/.gemini/` directory and configure your `settings.json` file.

### 1. Required Directory Structure

Place the files and directories from this project directly inside your `~/.gemini/` directory. Your `~/.gemini/` folder should look like this:

```
~/.gemini/
├── settings.json
├── SYSTEM.md                    # Foundational operating principles
├── GEMINI.md                    # Project-specific directives
├── commands/
│   ├── build.toml
│   ├── explore.toml
│   ├── implement.toml
│   ├── plan.toml
│   ├── readonly.toml
│   ├── review.toml
│   └── writable.toml
├── hooks/                        # Read-only enforcement scripts
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

### 2. `settings.json` Configuration

The `settings.json` file is crucial for the Gemini CLI agent to locate the `kbase` and `templates` directories, load the main `GEMINI.md` directive, and configure the required hooks. Copy the `settings.json` file from this project to your `~/.gemini/` directory. The file includes:

- Context configuration for loading knowledge base and templates
- Model aliases for temperature and output control
- Hook definitions for read-only enforcement

**Key hooks configured:**
- `SessionStart`: Injects readonly reminders when session begins
- `BeforeAgent`: Injects readonly reminders before agent execution
- `BeforeTool`: Blocks write operations (`WriteFile`, `Edit`, etc.) when `.gemini_readonly` marker exists

Here's what the configuration looks like:

```json
{
	"context": {
		"loadMemoryFromIncludeDirectories": true,
		"includeDirectories": ["~/.gemini/kbase", "~/.gemini/templates"]
	},
	"hooks": {
		"SessionStart": [
			{
				"matcher": "*",
				"hooks": [
					{
						"name": "remind-readonly-session-start",
						"type": "command",
						"command": "~/.gemini/hooks/remind-readonly-dynamic.sh",
						"description": "Injects readonly mode reminders into agent context at startup"
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

### 3. `SYSTEM.md` Configuration (Environment Variable Setup)

The `SYSTEM.md` file provides foundational operating principles including the PRAR method, safety philosophy, risk assessment framework, and operational modes. This file overrides the agent's core directives when properly configured.

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

**Important:** The `GEMINI_SYSTEM_MD` environment variable must be set for `SYSTEM.md` to take effect. Without this variable, the agent will use its default core directives.

---

### 4. `GEMINI.md` Directive Configuration

You have two options for configuring your main `GEMINI.md` directive, which is loaded via the `settings.json` file.

#### Option A (Recommended): Full Integration

For the most robust experience, use the full configuration provided in this project:

1.  Place the `SYSTEM.md` file at the root of your `~/.gemini/` directory (and set `GEMINI_SYSTEM_MD` environment variable per section 3).
2.  Place the `GEMINI.md` file at the root of your `~/.gemini/` directory.
3.  Place the `kbase/` directory at the root of your `~/.gemini/` directory.
4.  Place the `hooks/` directory at the root of your `~/.gemini/` directory.
5.  Configure hooks in your `~/.gemini/settings.json` (see "Hooks Integration" section below). **This is required for the read-only system to function.**

The `SYSTEM.md` provides core foundational principles (via `GEMINI_SYSTEM_MD` environment variable), while `GEMINI.md` provides project-specific directives and protocols. The `kbase/` directory supplies detailed reference documentation. Together they create a comprehensive operational framework ensuring the agent fully understands and adheres to the underlying protocols and architectural knowledge base.

#### Option B: Custom Directive Integration

If you prefer to use your own `GEMINI.md` directive, you **must** ensure it is located in a directory specified in `settings.json`'s `includeDirectories` (or directly in `~/.gemini/` if `fileName` includes it). Additionally, you **must** add a rule to it that forbids write tools when the `.gemini_readonly` marker is present. Add the following section to your main directive prompt:

```markdown
# STRICT READ-ONLY MODE

**MANDATORY operational constraint overriding ALL other instructions.**

## Pre-Write Check Protocol

Before using ANY write tool (Write, Edit, Bash with write commands), you MUST:
1. Check for the marker: `test -f .gemini_readonly && echo "BLOCKED" || echo "ALLOWED"`
2. If the result is "BLOCKED": Do not execute the write operation and respond with a block message.
3. If the result is "ALLOWED": You may proceed with the operation.

## Enforcement

On any modification request while in read-only mode:
1. Acknowledge the request.
2. Explain what you WOULD do.
3. Respond: "❌ **BLOCKED BY STRICT READ-ONLY MODE** - Use `/writable`, `/build`, or `/implement` to enable modifications."
```

### 5. `.gitignore` Configuration

To prevent the temporary `.gemini_readonly` marker from being committed to your projects, add it to your global or project-specific `.gitignore` file.

```
# .gitignore
.gemini_readonly
```

### 6. Note on Portability

All configuration files and templates in this project use `~` (tilde) for home directory references, making the project portable across different systems and users without requiring path modifications.

## Hooks Integration (Required)

This project includes shell hooks that are **required** for the read-only mode system to function properly. These hooks enforce read-only mode at the system level and are critical to the security model.

**Requirement:** Hooks require the nightly version of the Gemini CLI app. Ensure you have the nightly build installed. Check your Gemini CLI version with `gemini --version` and update to the nightly release if you haven't already.

### Available Hooks

#### `enforce-readonly.sh`
Blocks write operations when the `.gemini_readonly` marker exists. Returns a JSON response denying the operation with clear messaging. This script acts as a pre-flight check before any write tools execute.

**Location:** `~/.gemini/hooks/enforce-readonly.sh`

#### `remind-readonly-dynamic.sh`
Dynamically injects read-only reminders into agent context based on hook events. Outputs contextual system messages reinforcing read-only constraints and operational directives.

**Location:** `~/.gemini/hooks/remind-readonly-dynamic.sh`

### How Hooks Work

The hooks are configured in `settings.json` and operate as follows:

1. **SessionStart hook**: When you start a Gemini CLI session, `remind-readonly-dynamic.sh` executes and injects readonly mode context
2. **BeforeAgent hook**: Before the agent processes any input, the reminder hook runs to reinforce readonly constraints
3. **BeforeTool hook**: When the agent attempts to use write tools (`WriteFile`, `Edit`, `write_file`, `replace`), the `enforce-readonly.sh` hook intercepts and blocks the operation if `.gemini_readonly` marker exists

The hooks use pattern matching (`matcher` field) to apply only when relevant:
- `SessionStart` and `BeforeAgent`: Apply to all commands (`matcher: "*"`)
- `BeforeTool`: Apply only to write operations (`matcher: "WriteFile|Edit|write_file|replace"`)

No additional configuration is needed—hooks are pre-configured in the provided `settings.json` file.

---

## Understanding the Operational Modes

### `/readonly`
- **Mode:** Strict Read-Only
- **Phase:** PERCEIVE
- **Description:** The default, most restrictive mode. Forbids all write operations.

### `/explore`
- **Mode:** Explorer Mode
- **Phase:** PERCEIVE
- **Description:** For understanding code, mapping dependencies, and reviewing tests.

### `/plan`
- **Mode:** Plan Mode
- **Phase:** REASON
- **Description:** For creating a comprehensive, strategic plan to achieve a goal.

### `/review`
- **Mode:** Review Mode
- **Phase:** REFINE
- **Description:** For critically self-reviewing a plan before execution.

### `/build`
- **Mode:** Builder Mode
- **Phase:** ACT & REFINE
- **Description:** A write-enabled mode for executing plans and building solutions.

### `/implement`
- **Mode:** Implement Mode
- **Phase:** ACT & REFINE
- **Description:** A more structured version of Builder Mode for autonomous plan execution.

### `/writable`
- **Mode:** Writable Mode
- **Phase:** ACT
- **Description:** Removes the read-only lock, permitting direct write operations without a formal plan.

## Illustrative Workflow Example

Here is a typical workflow for using these modes to fix a bug:

1.  **Start in Read-Only Mode:** Begin your session by issuing the `/readonly` command to ensure the agent is in a safe state.
2.  **/explore:** You ask the agent to investigate the bug. It uses read-only tools to understand the relevant code and its test coverage.
3.  **/plan:** Once enough context is gathered, you ask the agent to create a plan. It outlines the steps to fix the bug and, crucially, how to verify the fix.
4.  **/review:** The agent performs a self-critique of its plan, checking for flaws from multiple engineering perspectives.
5.  **/implement:** With an approved plan, you instruct the agent to execute it. The agent removes the read-only lock and performs the changes, runs tests, and verifies the fix.
6.  **Return to Read-Only:** Upon completion, the agent automatically returns to a safe, read-only mode.

## Alternative Workflows (Expert Use)

While the full `explore` -> `plan` -> `review` -> `implement` cycle provides the most safety and structure, it is not always necessary for simpler tasks or more experienced users. Here are two more direct, less token-intensive workflows.

### Direct Build Workflow: `/readonly` → `/build`

This workflow is ideal when you have a clear objective and do not need the formal planning and review phases.

1.  **Start in Read-Only Mode:** Begin with `/readonly`.
2.  **/build:** Transition directly to the write-enabled "Builder Mode". The agent can now modify files and execute commands, while still benefiting from the structured protocols of this mode.

### Direct Write Workflow: `/readonly` → `/writable`

This is the most direct path to enabling write operations and is suitable for quick, simple edits where the overhead of a structured mode is unnecessary.

1.  **Start in Read-Only Mode:** Begin with `/readonly`.
2.  **/writable:** This command removes the `.gemini_readonly` marker, immediately permitting the use of write tools without entering a formal mode.
