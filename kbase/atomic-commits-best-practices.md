# Atomic Commits Best Practices

Quick reference for creating atomic commits that improve code quality, debugging, and collaboration.

---

## Definition

An **atomic commit** is a self-contained change that:

1. Represents a single logical modification
2. Can be described concisely in one simple sentence
3. Includes all files necessary for completeness
4. Leaves the project in a valid, working state
5. Can be reverted independently without breaking other functionality

**Key insight**: "Atomic" means indivisible in purpose, not necessarily small in size.

---

## Core Principles

| Principle | Description | Example |
|-----------|-------------|---------|
| **Single Responsibility** | Do ONE thing completely | "Add OAuth2 authentication" ✓<br>"Add OAuth2 and fix parser bug" ✗ |
| **Completeness** | Include all necessary files | Implementation + tests + dependencies |
| **Minimal Scope** | Include ONLY what's necessary | Feature files only, no unrelated cleanup |
| **Independence** | Independently reversible | Can `git revert` without breaking others |
| **Valid State** | Tests pass after commit | Project works after every commit |

---

## Benefits

| Benefit | Impact |
|---------|--------|
| **Debugging** | `git bisect` works effectively; easy to identify when/where bugs were introduced |
| **Code Review** | Reviewable chunks; targeted feedback; clear purpose per commit |
| **Reverting** | Surgical rollbacks; no untangling of intermingled changes |
| **Collaboration** | Clear communication; meaningful history; easier merge conflict resolution |

---

## Common Grouping Patterns

### 1. Feature Implementation
All files required for one feature to work.

**Example**: Add real-time chat → service + UI + styles + tests + dependencies

### 2. Bug Fix
The fix + test validating the fix.

**Example**: Fix date parsing → `date.js` (fix) + `date.test.js` (regression test)

### 3. Refactoring
All files affected by same structural change.

**Example**: Extract validation → new validators + updated imports across files + tests

### 4. Documentation
Related documentation changes (often separate from code).

**Example**: Update API docs → `authentication.md` + `users.md` + `README.md`

**Note**: Can be with code if documenting new feature in same commit.

### 5. Configuration
Related configuration changes.

**Example**: Update Node.js 18 → `package.json` + `.nvmrc` + CI config + Dockerfile

### 6. Test Coverage
Adding tests for existing functionality.

**Example**: Add edge case tests → new test files (no implementation changes)

---

## Anti-Patterns to Avoid

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| **"And" Commit** | Message needs "and" (multiple unrelated actions) | Split into separate commits per action |
| **WIP Commits** | Meaningless commits that break functionality | Squash into one meaningful atomic commit |
| **Friday Dump** | All week's work in one giant commit | Separate into logical atomic commits |
| **Mixed Concerns** | Combining unrelated changes | Separate by concern (feature, formatting, docs) |
| **Partial Implementation** | Incomplete work that breaks tests | Wait until complete with passing tests |

---

## Decision Guidelines

### Should These Changes Be in Same Commit?

Ask yourself:

1. **Single sentence test**: Can I describe all changes in one simple sentence?
   - Yes → Likely one commit | No → Likely separate

2. **Revert test**: Does it make sense to remove all these changes together?
   - Yes → Likely one commit | No → Likely separate

3. **Purpose test**: Do all changes serve the same purpose?
   - Yes → Likely one commit | No → Likely separate

4. **Dependency test**: Are the changes functionally dependent on each other?
   - Yes → Likely one commit | No → Likely separate

5. **Review test**: Would reviewer want to review these together or separately?
   - Together → Likely one commit | Separately → Likely separate

### Quick Examples

- Function + test → Same commit (dependent, same purpose)
- Bug fix + docs → Separate commits (different purposes)
- 10-file refactoring → Same commit (one structural change, same purpose)

---

## Summary

**Atomic commits should be:**
- Single-purpose (one logical change)
- Complete (all necessary files)
- Minimal (nothing unnecessary)
- Independent (reversible without breaking others)
- Valid (tests pass)

**Common mistake**: Confusing "atomic" with "small file count"
- Atomic = single purpose, not single file
- A 20-file refactoring can be one atomic commit
- A 2-file change can be two atomic commits if different purposes
