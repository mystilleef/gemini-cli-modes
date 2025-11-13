# Conventional Commits Examples

Real-world examples demonstrating proper Conventional Commits format with line length adherence and visual presentation format.

## Visual Presentation Format

When presenting commit messages to users for approval, use this boxed format:

**Template:**
```
════════════════════════════════════════════════════════════

<subject line>

[optional body paragraph]

[optional bullet points]

[optional footers]

════════════════════════════════════════════════════════════
```

**Format Rules:**
- Top/bottom separators: Exactly 60 `═` characters
- Empty line after top separator
- Empty line before bottom separator
- Use plain text for clarity and compatibility
- Actual git commit uses plain text (no separators)

---

## Example 1: Simple Feature (No Body)

**Commit Message Content:**
```
feat(auth): add OAuth2 login support
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

feat(auth): add OAuth2 login support

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `feat` (new feature)
- Scope: `auth` (authentication module)
- Description: 47 characters, imperative mood
- No body needed for straightforward addition
- Visual format: Simplest case with just subject line between separators

---

## Example 2: Bug Fix with Body (Paragraph + Bullets)

**Commit Message Content:**
```
fix(parser): resolve JSON parsing for nested arrays

Previously failed when arrays contained more than 3 levels of
nesting due to recursion limit.

- Increase recursion depth limit from 3 to 10
- Add validation for maximum nesting depth
- Update error messages for clarity
- Add regression tests for nested structures
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

fix(parser): resolve JSON parsing for nested arrays

Previously failed when arrays contained more than 3 levels of
nesting due to recursion limit.

- Increase recursion depth limit from 3 to 10
- Add validation for maximum nesting depth
- Update error messages for clarity
- Add regression tests for nested structures

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `fix` (bug fix)
- Scope: `parser`
- Description: 48 characters
- Body includes:
  - Paragraph explaining context/rationale
  - Bullet points detailing the changes
- All lines ≤72 characters
- Visual format: Full structure with paragraph and bullets

---

## Example 3: Bug Fix with Body (Bullets Only)

**Commit Message Content:**
```
fix(api): handle null responses from external service

- Add null checks before processing response data
- Return appropriate error message when null received
- Log warning for debugging purposes
- Update API client tests
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

fix(api): handle null responses from external service

- Add null checks before processing response data
- Return appropriate error message when null received
- Log warning for debugging purposes
- Update API client tests

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `fix`
- Scope: `api`
- Description: 50 characters
- Body uses bullets only (no paragraph needed)
- Clear, concise change summary
- Visual format: Subject and bullets with no paragraph

---

## Example 4: Breaking Change with `!` Syntax

**Commit Message Content:**
```
feat(config)!: change config file format to YAML

- Migrate from JSON to YAML for better readability
- Add migration script in scripts/migrate-config.sh
- Update documentation with new format examples
- Deprecate support for .json config files

BREAKING CHANGE: Configuration files must now use YAML format.
JSON config files are no longer supported. Run the migration
script to convert existing configs.
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

feat(config)!: change config file format to YAML

- Migrate from JSON to YAML for better readability
- Add migration script in scripts/migrate-config.sh
- Update documentation with new format examples
- Deprecate support for .json config files

BREAKING CHANGE: Configuration files must now use YAML format.
JSON config files are no longer supported. Run the migration
script to convert existing configs.

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `feat` with `!` indicating breaking change
- Scope: `config`
- Breaking change explained in footer
- Footer wrapped at 72 characters
- Visual format: Complete structure with BREAKING CHANGE footer

---

## Example 5: Breaking Change with Footer Only

**Commit Message Content:**
```
refactor(database): restructure user schema

The user table schema has been redesigned to support new
authentication methods and improve query performance.

- Rename `username` column to `email`
- Add `auth_provider` and `external_id` columns
- Remove deprecated `legacy_id` column
- Create migration script for existing databases

BREAKING CHANGE: The `username` field has been renamed to
`email`. Applications must update all references to use the new
field name. Migration: UPDATE users SET email = username;
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

refactor(database): restructure user schema

The user table schema has been redesigned to support new
authentication methods and improve query performance.

- Rename `username` column to `email`
- Add `auth_provider` and `external_id` columns
- Remove deprecated `legacy_id` column
- Create migration script for existing databases

BREAKING CHANGE: The `username` field has been renamed to
`email`. Applications must update all references to use the new
field name. Migration: UPDATE users SET email = username;

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `refactor`
- Scope: `database`
- Body includes rationale paragraph + bullets
- Breaking change in footer with migration guidance
- Visual format: Complete structure with BREAKING CHANGE footer

---

## Example 6: Documentation Update

**Commit Message Content:**
```
docs(api): update authentication examples

- Add OAuth2 flow examples
- Update token refresh documentation
- Fix typos in endpoint descriptions
- Add troubleshooting section
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

docs(api): update authentication examples

- Add OAuth2 flow examples
- Update token refresh documentation
- Fix typos in endpoint descriptions
- Add troubleshooting section

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `docs` (documentation only)
- Scope: `api`
- No SemVer impact (unless breaking)
- Bullets-only body for multiple doc changes
- Visual format: Clean bullets-only presentation

---

## Example 7: Refactor with Rationale

**Commit Message Content:**
```
refactor(core): extract validation logic to separate module

Consolidating scattered validation code into a dedicated module
improves maintainability and enables easier testing.

- Create new validation/ directory
- Move email validation from utils
- Move phone number validation from helpers
- Add comprehensive validation test suite
- Update imports across affected files
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

refactor(core): extract validation logic to separate module

Consolidating scattered validation code into a dedicated module
improves maintainability and enables easier testing.

- Create new validation/ directory
- Move email validation from utils
- Move phone number validation from helpers
- Add comprehensive validation test suite
- Update imports across affected files

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `refactor`
- Scope: `core`
- Paragraph explains WHY refactoring is valuable
- Bullets detail WHAT changed
- 72-character line wrapping maintained
- Visual format: Paragraph + bullets pattern

---

## Example 8: Complex Feature (Bullets Only)

**Commit Message Content:**
```
feat(dashboard): add real-time analytics widgets

- Implement WebSocket connection for live data
- Create LineChart component for time-series data
- Create PieChart component for category breakdown
- Add widget configuration panel
- Enable drag-and-drop widget reordering
- Persist widget layout to user preferences
- Add loading states and error handling
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

feat(dashboard): add real-time analytics widgets

- Implement WebSocket connection for live data
- Create LineChart component for time-series data
- Create PieChart component for category breakdown
- Add widget configuration panel
- Enable drag-and-drop widget reordering
- Persist widget layout to user preferences
- Add loading states and error handling

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `feat`
- Scope: `dashboard`
- Description: 47 characters
- Comprehensive bullet list (no paragraph needed)
- Each bullet is clear and specific
- Visual format: Long bullet list presentation

---

## Example 9: With Multiple Footers

**Commit Message Content:**
```
fix(security): patch XSS vulnerability in comment rendering

User-submitted content was not properly sanitized before being
rendered, allowing script injection attacks.

- Add DOMPurify sanitization to comment renderer
- Escape HTML entities in preview mode
- Add CSP headers to prevent inline script execution
- Update security tests

Refs: #456
Reviewed-by: Security Team <security@example.com>
Co-authored-by: Jane Smith <jane@example.com>
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

fix(security): patch XSS vulnerability in comment rendering

User-submitted content was not properly sanitized before being
rendered, allowing script injection attacks.

- Add DOMPurify sanitization to comment renderer
- Escape HTML entities in preview mode
- Add CSP headers to prevent inline script execution
- Update security tests

Refs: #456
Reviewed-by: Security Team <security@example.com>
Co-authored-by: Jane Smith <jane@example.com>

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `fix`
- Scope: `security`
- Multiple footers for references and attribution
- Footer tokens use hyphens (Co-authored-by, Reviewed-by)
- Visual format: Shows multiple footer types

---

## Example 10: Performance Improvement

**Commit Message Content:**
```
perf(query): optimize database queries for user search

- Add index on users.email column
- Implement query result caching (5-minute TTL)
- Reduce SELECT fields to only required columns
- Use connection pooling for concurrent requests

Results: Search latency reduced from 2.3s to 180ms average.
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

perf(query): optimize database queries for user search

- Add index on users.email column
- Implement query result caching (5-minute TTL)
- Reduce SELECT fields to only required columns
- Use connection pooling for concurrent requests

Results: Search latency reduced from 2.3s to 180ms average.

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `perf` (performance improvement)
- Scope: `query`
- Bullets detail optimizations made
- Results summary shows impact
- 65-character lines maintained
- Visual format: Includes results footer

---

## Example 11: CI/CD Configuration

**Commit Message Content:**
```
ci: add automated dependency security scanning

- Integrate Snyk security checks in pipeline
- Run scans on pull requests and main branch
- Configure vulnerability severity thresholds
- Add Slack notifications for critical issues
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

ci: add automated dependency security scanning

- Integrate Snyk security checks in pipeline
- Run scans on pull requests and main branch
- Configure vulnerability severity thresholds
- Add Slack notifications for critical issues

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `ci` (CI/CD changes)
- No scope needed (CI is specific enough)
- Clear bullet points for each change
- Visual format: No-scope example

---

## Example 12: Chore/Maintenance

**Commit Message Content:**
```
chore(deps): update dependencies to latest versions

- Update React from 18.2.0 to 18.3.1
- Update TypeScript from 5.0.4 to 5.3.3
- Update Jest from 29.5.0 to 29.7.0
- Resolve peer dependency warnings
```

**Visual Presentation:**
```
════════════════════════════════════════════════════════════

chore(deps): update dependencies to latest versions

- Update React from 18.2.0 to 18.3.1
- Update TypeScript from 5.0.4 to 5.3.3
- Update Jest from 29.5.0 to 29.7.0
- Resolve peer dependency warnings

════════════════════════════════════════════════════════════
```

**Analysis:**
- Type: `chore` (maintenance task)
- Scope: `deps` (dependencies)
- Specific version changes listed
- No SemVer impact
- Visual format: Maintenance task presentation
