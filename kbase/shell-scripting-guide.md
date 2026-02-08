# Shell scripting guide

## Core Rules
- **Shebang**: Use `#!/bin/sh` exclusively.
- **Strict Mode**: Set `set -eu` (exit on error, unset variables). Use `set -euf` to also disable globbing for maximum safety.
- **Output**: Prefer `printf` over `echo` for portable formatting and to avoid escape sequence variations.
- **Quoting**: Always quote variables: `"${var}"`.
- **Cleanup**: Use `trap cleanup EXIT INT TERM` for idempotent resource removal.
- **Substitution**: Use `$(command)` instead of backticks.

## Prohibited (Bashisms)
- `#!/bin/bash` or `#!/usr/bin/env bash`
- `[[ ... ]]` (use `[ ... ]`)
- `==` in tests (use `=`)
- `source` (use `.`)
- `&>` or `|&` (use `> file 2>&1` or `| 2>&1`)
- `<<<` (use `printf '%s\n' "$var" | ...`)
- `function name` (use `name()`)
- `local` (use subshells or unique variable prefixes)
- Arrays (use positional parameters `"$@"` or newline-separated strings)
- Brace expansion `{a,b}` or process substitution `<(cmd)`

## POSIX Patterns

### Comparisons and Logic
```sh
[ "${var}" = "value" ]                 # String equality
[ "${count}" -eq 5 ]                   # Numeric equality
[ -f "${file}" ] && [ -r "${file}" ]   # Logical AND
```

### Arithmetic and Strings
```sh
val=$((a + b))                         # Math (no $ inside)
dir="${path%/*}"                       # Dirname equivalent
file="${path##*/}"                     # Basename equivalent
ext="${file##*.}"                      # Extension extraction
```

### Resource Management
```sh
# Atomic directory creation for temporary storage
tmp_dir="${TMPDIR:-/tmp}/${0##*/}.$$"
mkdir -m 700 "${tmp_dir}" || exit 1
trap 'rm -rf "${tmp_dir}"' EXIT INT TERM
```

### Dry-run Pattern
```sh
DRY_RUN="${DRY_RUN:-0}"
execute() {
  if [ "${DRY_RUN}" = "1" ]; then
    printf '[DRY-RUN]' >&2
    for arg in "$@"; do printf ' %s' "$arg" >&2; done
    printf '\n' >&2
  else
    "$@"
  fi
}
execute rm -f -- "${file}"
```

## Translation Table

| Bashism | POSIX Equivalent |
| :--- | :--- |
| `[[ $a == $b ]]` | `[ "$a" = "$b" ]` |
| `source file` | `. file` |
| `&> /dev/null` | `> /dev/null 2>&1` |
| `local var` | `_func_var` (prefixing) |
| `mktemp` | `mkdir` with `$$` |
| `seq 1 10` | `i=1; while [ "$i" -le 10 ]; do ... i=$((i+1)); done` |
| `readlink -f` | `cd "$(dirname "$f")" && pwd -P` |

## Style and Execution
- **Naming**: Use `snake_case` for variables/functions; `SCREAMING_SNAKE_CASE` for constants.
- **I/O**: Send logs to `stderr` (`>&2`) and data to `stdout`.
- **Parameters**: Use `"$@"` to preserve arguments.
- **Exit Codes**: `0` (success), `1` (error), `127` (command not found).
