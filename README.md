# Gemini CLI Modes — Obsolete

> [!WARNING]
>
> This project is obsolete and no longer recommended for new Gemini CLI
> workflows.
>
> It was created to compensate for limitations in earlier Gemini CLI versions,
> before native **Plan Mode** and **Agents** existed. Modern Gemini CLI now
> supports both.

## Use SPAE instead

For modern structured Gemini CLI workflows, use the SPAE framework:

<https://github.com/mystilleef/gemini-cli-spae>

SPAE provides a cleaner and more current approach to disciplined AI-assisted
development:

- **Spec** — define the requirements.
- **Plan** — break the work into actionable steps.
- **Act** — implement the plan.
- **Evaluate** — review, verify, and refine the result.

This approach works with the current Gemini CLI feature set instead of working
around missing capabilities from older releases.

## Historical purpose

`gemini-cli-modes` implemented a custom mode-based workflow for older Gemini CLI
versions that lacked first-class support for:

- planning before implementation,
- agent-assisted task decomposition,
- review gates,
- and safer separation between read-only exploration and writable execution.

It provided commands such as:

- `/readonly`
- `/prepare`
- `/review`
- `/build`
- `/implement`
- `/writable`

It also used hooks and marker files to reduce accidental writes while
investigating, planning, or reviewing.

These safeguards were useful at the time, but they are no longer the best way to
structure Gemini CLI work.

## Recommendation

Do not install or copy this project into new `~/.gemini/` configurations.

Use modern Gemini CLI with:

- native Plan Mode,
- native Agents,
- and SPAE:

<https://github.com/mystilleef/gemini-cli-spae>

This repository remains available only for historical reference or for
maintaining older Gemini CLI setups that still depend on its custom modes.
