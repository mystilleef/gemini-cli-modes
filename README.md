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

Place the `commands/` and `templates/` directories from this project directly inside your `~/.gemini/` directory. Your `~/.gemini/` folder should look like this:

```
~/.gemini/
├── settings.json
├── commands/
│   ├── build.toml
│   ├── explore.toml
│   ├── implement.toml
│   ├── plan.toml
│   ├── readonly.toml
│   ├── review.toml
│   └── writable.toml
└── templates/
    ├── explore.md
    ├── plan.md
    ├── review.md
    └── tasks.md
```

### 2. `settings.json` Configuration

The `settings.json` file is crucial for the Gemini CLI agent to locate the `kbase` and `templates` directories, and to load the main `GEMINI.md` directive. Ensure your `settings.json` file (located in your `~/.gemini/` directory) includes the following configuration:

```json
{
	"context": {
		"loadMemoryFromIncludeDirectories": true,
		"includeDirectories": ["~/.gemini/kbase", "~/.gemini/templates"],
		"fileName": ["GEMINI.md"]
	}
}
```

### 3. `GEMINI.md` Directive Configuration

You have two options for configuring your main `GEMINI.md` directive, which is loaded via the `settings.json` file.

#### Option A (Recommended): Full Integration

For the most robust experience, use the `GEMINI.md` and `kbase/` provided in this project.

1.  Place the `GEMINI.md` file at the root of your `~/.gemini/` directory.
2.  Place the `kbase/` directory at the root of your `~/.gemini/` directory.

This ensures the agent fully understands and adheres to the underlying protocols and architectural knowledge base.

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

### 4. `.gitignore` Configuration

To prevent the temporary `.gemini_readonly` marker from being committed to your projects, add it to your global or project-specific `.gitignore` file.

```
# .gitignore
.gemini_readonly
```

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
