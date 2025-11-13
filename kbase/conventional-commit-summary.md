# Conventional Commits Specification Summary

Quick reference for the Conventional Commits v1.0.0 specification.

## Format Structure

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Required Elements

### Type (REQUIRED)
Must be present with colon and space. Common types:

**Core types with SemVer impact:**
- `feat`: New feature → MINOR version bump
- `fix`: Bug fix → PATCH version bump
- Breaking change → MAJOR version bump (via `!` or footer)

**Additional permitted types:**
- `docs`: Documentation only changes
- `style`: Code style changes (formatting, no logic change)
- `refactor`: Code restructuring without changing behavior
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `build`: Changes to build system or dependencies
- `ci`: CI configuration changes
- `chore`: Maintenance tasks

### Description (REQUIRED)
- Must immediately follow the type/scope prefix
- Use imperative mood ("add" not "added" or "adds")
- Keep ≤50 characters (recommended), 72 max
- No period at the end

## Optional Elements

### Scope
- Contextual information in parentheses
- Examples: `feat(parser):`, `fix(auth):`, `docs(readme):`
- Describes the affected area/component

### Body
- Must begin one blank line after description
- Provides additional context and details
- Wrap lines at 72 characters
- Can use paragraphs and bullet points

### Footers
- Must follow one blank line after body (or description if no body)
- Format: `token: value` or `token #value`
- Footer tokens must use hyphens instead of spaces
  - Example: `Reviewed-by:`, `Acked-by:`, `Refs:`
- Common footers:
  - `BREAKING CHANGE: description`
  - `Refs: #123`
  - `Co-authored-by: Name <email>`

## Breaking Changes

Two ways to indicate breaking changes:

**1. Using `!` before colon:**
```
feat!: send email when product ships
feat(api)!: remove deprecated endpoints
```

**2. Using footer:**
```
feat: allow configuration object

BREAKING CHANGE: `config` key in package.json now accepts object instead of string
```

**Rules:**
- `BREAKING CHANGE` must be uppercase in footer
- `BREAKING-CHANGE` is synonymous with `BREAKING CHANGE`
- Breaking changes trigger MAJOR version bump

## Key Specification Rules

1. Type MUST be present with terminal colon and space
2. Description MUST immediately follow type/scope
3. Scope MAY be provided after type (in parentheses)
4. `!` MAY be appended before `:` to indicate breaking change
5. Body MUST begin one blank line after description
6. Footers MUST follow one blank line after body
7. Breaking changes MUST be indicated via prefix `!` or footer
8. Types other than `feat` and `fix` MAY be used
9. Multiple paragraphs MAY be used in body
10. Footer tokens MUST use `-` instead of spaces

## SemVer Mapping

- **MAJOR** (1.0.0 → 2.0.0): Breaking changes (via `!` or `BREAKING CHANGE:`)
- **MINOR** (1.0.0 → 1.1.0): New features (`feat:`)
- **PATCH** (1.0.0 → 1.0.1): Bug fixes (`fix:`)

Other types (docs, style, refactor, etc.) don't trigger version bumps unless they include breaking changes.

## Examples

**Simple feature:**
```
feat(lang): add Polish language
```

**Bug fix:**
```
fix: prevent racing of requests
```

**Breaking change with `!`:**
```
feat!: send email when product ships
```

**With scope and breaking footer:**
```
feat(api)!: remove deprecated endpoints

BREAKING CHANGE: The following endpoints have been removed:
- GET /api/v1/users (use /api/v2/users instead)
- POST /api/v1/auth (use /api/v2/authenticate instead)
```

**With body:**
```
refactor(core): simplify configuration loading

- Remove redundant config parsers
- Consolidate validation logic
- Update documentation
```

**Multiple footers:**
```
fix(auth): resolve token expiration issue

Refs: #123
Reviewed-by: Jane Doe <jane@example.com>
```
