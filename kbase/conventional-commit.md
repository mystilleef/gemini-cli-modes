# Conventional Commits Specification

Comprehensive guide to the Conventional Commits v1.0.0 specification, including formatting rules, character limits, and visual presentation standards.

## 1. Format Structure

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## 2. Character Limit Standards

Strict adherence to character limits ensures readability in git logs and terminals.

- **Subject Line:** ≤50 characters recommended (Hard limit: 72)
- **Body Lines:** Wrap at 72 characters
- **Footer:** Wrap at 72 characters

## 3. Required Elements

### Type (REQUIRED)
Must be present with colon and space.

**Core types (SemVer impact):**
- `feat`: New feature → MINOR version bump
- `fix`: Bug fix → PATCH version bump
- `!`: Breaking change → MAJOR version bump (e.g., `feat!:`)

**Auxiliary types (No SemVer impact):**
- `docs`: Documentation only
- `style`: Formatting changes (no logic change)
- `refactor`: Code restructuring
- `perf`: Performance improvements
- `test`: Adding/updating tests
- `build`: Build system/dependencies
- `ci`: CI configuration
- `chore`: Maintenance tasks

### Description (REQUIRED)
- Imperative mood ("add" not "added")
- No period at the end
- Max 72 characters (aim for 50)

## 4. Optional Elements

- **Scope:** Context in parentheses, e.g., `feat(parser):`
- **Body:** Detailed explanation, wrapped at 72 chars. Use paragraphs or bullets.
- **Footers:** Metadata like `Refs: #123` or `BREAKING CHANGE: <description>`.

## 5. Visual Presentation Format

When presenting commit messages for approval, use this boxed format with the ruler to verify length.

**Template:**
```
════════════════════════════════════════════════════════════
123456789012345678901234567890123456789012345678901234567890123456789012
<subject line> (Max 50 recommended)

[optional body paragraph - wrap at 72 characters]

[optional bullet points]

[optional footers]

════════════════════════════════════════════════════════════
```

## 6. Curated Examples

### Simple Feature
```
feat(auth): add OAuth2 login support
```

### Bug Fix with Body
```
fix(parser): resolve JSON parsing for nested arrays

Previously failed when arrays contained more than 3 levels of
nesting due to recursion limit.

- Increase recursion depth limit from 3 to 10
- Add validation for maximum nesting depth
- Add regression tests
```

### Breaking Change
```
feat(config)!: change config file format to YAML

BREAKING CHANGE: Configuration files must now use YAML format.
JSON config files are no longer supported.
```

### Multiple Footers
```
fix(security): patch XSS vulnerability

Refs: #456
Reviewed-by: Security Team <security@example.com>
```

### Anti-Pattern (Length Violation)
**Bad:**
```
feat(auth): add new login system that supports google and facebook and handles errors
```
*❌ Subject Length: 85 chars (Exceeds 72 char limit)*

**Corrected:**
```
feat(auth): add social login support

Implements OAuth2 providers for Google and Facebook. Includes
error handling for network failures.
```
*✅ Subject Length: 32 chars*