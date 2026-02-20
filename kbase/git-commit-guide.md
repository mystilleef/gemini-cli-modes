# Git commit message guide

## Specification: Conventional commits v1.0.0

### Format structure

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Character limits

- **Subject line**: ≤ 50 characters (Hard limit: 72).
- **Body/footer lines**: Wrap at 72 characters.

### Required elements

- **Type**: Use one of the following:
  - `feat`: New feature (`MINOR` bump).
  - `fix`: Bug fix (`PATCH` bump).
  - `docs`: Documentation changes.
  - `style`: Formatting/white-space (no logic changes).
  - `refactor`: Code restructuring (no logic changes).
  - `perf`: Performance improvements.
  - `test`: Adding/updating tests.
  - `build`: Build system/dependencies.
  - `ci`: CI configuration.
  - `chore`: Maintenance tasks.
- **Breaking change**: Append `!` to type (for example, `feat!:`) or
  include `BREAKING CHANGE:` in footer (`MAJOR` bump).
- **Description**: Use imperative mood ("add," not "added"). Omit
  trailing periods.

### Optional elements

- **Scope**: Context in parentheses (for example, `feat(parser):`).
- **Body**: Detailed explanation. Use bullet points for each change.
- **Footers**: Metadata (for example, `Refs: #123`).

### Agent directives (efficiency & safety)

- **Plain text only**: Avoid markdown backticks (`) to prevent shell
  execution errors.
- **No code blocks**: Describe changes without embedding code snippets.
- **Brevity**: Prefer precision over verbosity.
- **Visual verification**: Use the ruler below to ensure length
  compliance.

### Visual presentation template

```
════════════════════════════════════════════════════════════
123456789012345678901234567890123456789012345678901234567890123456789012
<subject line>

[body paragraph - wrap at 72]

- [bullet point]

[footer]
════════════════════════════════════════════════════════════
```
