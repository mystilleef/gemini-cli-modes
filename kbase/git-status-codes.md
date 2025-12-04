# Git Status Codes Quick Reference (Porcelain v2)

This document is a token-efficient summary of `git status --porcelain=v2 --branch` output.

## 1. Branch Header Lines (`#`)

- `# branch.oid <hash>`: Current commit SHA.
- `# branch.head <name>`: Current branch name or `(detached)`.
- `# branch.upstream <remote>/<branch>`: Upstream tracking branch.
- `# branch.ab +<ahead> -<behind>`: Commit count vs. upstream. `+0 -0` is in sync.

## 2. File Status Lines

Format: `<type> <XY> ... <path>` or `? <path>`

### XY Status Codes

`X` = Index (Staged), `Y` = Working Tree (Unstaged)

| Code | Staged | Unstaged | Description |
| :--- | :----: | :------: | :---------------------------------- |
| `M.` | ✓ | | Modified, staged |
| `.M` | | ✓ | Modified, not staged |
| `MM` | ✓ | ✓ | Staged, then modified again |
| `A.` | ✓ | | Added (new file), staged |
| `AM` | ✓ | ✓ | Added, then modified |
| `D.` | ✓ | | Deleted, staged |
| `.D` | | ✓ | Deleted, not staged |
| `R.` | ✓ | | Renamed, staged |
| `C.` | ✓ | | Copied, staged |
| `UU` | ✓ | ✓ | Unmerged (conflict) |
| `??` | | | Untracked file |
| `!!` | | | Ignored file |

### Other Line Types

- `2 <XY> ... <new-path> <old-path>`: Renamed or copied file.
- `? <path>`: Untracked file.
- `! <path>`: Ignored file.