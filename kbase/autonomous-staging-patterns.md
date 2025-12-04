# Autonomous Staging Patterns

Patterns and heuristics for autonomously identifying and staging cohesive groups of changes.

---

## File Path Pattern Analysis

| Pattern | Indicator | Decision Rule |
|---------|-----------|---------------|
| **Same Directory/Module** | Files in same directory | Same feature directory + related changes → Group<br>Different top-level directories → Separate |
| **Implementation + Test** | Test files match implementation names<br>(`utils.js` + `utils.test.js`) | Implementation + its test → Always group<br>Multiple tests → Group with respective implementations |
| **Component + Assets** | Component with styles/types/stories<br>(`Button.tsx` + `Button.css` + `Button.types.ts`) | Component + styles + tests + types → Group<br>Separate component → Separate commit |
| **Configuration Files** | Config files for same purpose<br>(`package.json` + `package-lock.json`) | Config for same change → Group<br>Unrelated config updates → Separate |
| **Related Documentation** | Docs describing related functionality | Docs for feature being implemented → Can group<br>Unrelated doc updates → Separate from code |

---

## Change Content Analysis

### Common Indicators

| Pattern | What to Look For | Grouping Decision |
|---------|------------------|-------------------|
| **Function/Class Additions** | - Function names relate<br>- Files reference each other via imports<br>- Same feature purpose | Files import from each other → Group<br>Same feature implementation → Group |
| **Import Changes** | - Files share imports<br>- New imports connect files | Service uses validators → Group all together |
| **Refactoring** | - Same code pattern across files<br>- Consistent transformation | Same refactoring pattern → Group all files |
| **Bug Fix** | - Null checks, validation added<br>- Error handling | Fix + regression test → Group together |
| **Feature Addition** | - New functionality<br>- Dependencies added | Implementation + formatter + dependency → Group |

---

## Decision Tree for Autonomous Grouping

```
START: Analyze all unstaged changes

Step 1: Check for already-staged changes
├─ Staged changes exist?
│  ├─ Yes → Do unstaged changes belong with staged?
│  │  ├─ Yes → Add to staging area
│  │  └─ No → Stage as separate group
│  └─ No → Continue to Step 2

Step 2: Count unique logical purposes
├─ How many distinct purposes?
│  ├─ One purpose → Likely one commit (Step 3)
│  └─ Multiple purposes → Identify smallest complete group (Step 3)

Step 3: Analyze file relationships
├─ Files in same module/directory?
│  ├─ Yes → Strong indicator to group (Step 4)
│  └─ No → Check other indicators (Step 4)

Step 4: Check implementation + test pattern
├─ Implementation + test files?
│  ├─ Yes → Group together (Step 5)
│  └─ No → Continue to Step 5

Step 5: Analyze change content
├─ Changes reference each other? (imports, function calls)
│  ├─ Yes → Group together (Step 6)
│  └─ No → Check change type (Step 6)

Step 6: Verify completeness
├─ Does group form complete, functional change?
│  ├─ Yes → Stage this group
│  └─ No → Include more files or split differently

END: Stage identified group
```

---

## Priority Rules

When multiple valid groupings exist:

### 1. Smallest Complete Atomic Unit
Choose the smallest group that forms a complete change.

**Example**: OAuth files (login + session + tests) before password reset files

### 2. Highest Cohesion
Choose the group with strongest relationships.

**Example**: `date.js` + `date.test.js` (bug fix) before separate `string.js` (new feature)

### 3. Feature Work Over Cleanup
Prioritize feature/fix commits over formatting/docs.

**Example**: New endpoint + tests before formatting changes and typo fixes

### 4. Implementation Before Documentation
Code changes before documentation updates.

**Example**: Implementation + tests first, docs can be separate commit

---

## Edge Case Handling

| Edge Case | Analysis | Decision |
|-----------|----------|----------|
| **Same File, Mixed Changes** | Feature work + formatting in one file | Cannot separate (file-level staging only)<br>Stage the file; note as code smell |
| **Circular Dependencies** | Files reference each other, both modified | Must stage together (cannot separate)<br>Tight coupling indicates same change |
| **Renamed Files** | File renamed and modified | Rename + files using new name → Group<br>Forms complete change |
| **Large Refactoring** | 30+ files for same refactoring | Stage all together (atomic = single purpose, not small size)<br>Splitting creates incomplete commits |
| **Dependency Update Cascade** | Updated dependency requires code changes | All changes for dependency update → Group<br>Cannot update without code changes |

---

## Autonomous Decision-Making Example

### Scenario: Authentication Feature

**Changes:**
```
M  src/auth/login.js
M  src/auth/session.js
M  src/auth/middleware.js
A  tests/auth/login.test.js
A  tests/auth/session.test.js
M  package.json
M  README.md
```

**Analysis:**
1. File paths: `auth/*` files related, README separate
2. Change content: login/session/middleware implement OAuth
3. Tests: validate OAuth implementation
4. `package.json`: Add oauth2 dependency (needed for feature)
5. README: Typo fix (unrelated)

**Decision:**
```bash
# Stage OAuth feature (smallest complete group)
git add src/auth/login.js src/auth/session.js src/auth/middleware.js \
        tests/auth/login.test.js tests/auth/session.test.js \
        package.json
```

**Reasoning:**
- All auth files + tests + dependency form complete feature
- README typo is separate concern
- Smallest complete atomic unit

**Remaining:** `README.md` (for separate commit)

---

## Summary

**Autonomous staging uses:**
1. File path patterns (directories, naming)
2. Change content analysis (imports, functions, patterns)
3. Decision trees (systematic evaluation)
4. Priority rules (smallest, cohesion, feature first)
5. Edge case handling (mixed files, renames, refactoring)

**Goal**: Stage the smallest complete atomic unit that forms a logical, functional change.

**Key principle**: Trust the analysis - file paths and change content reveal relationships without user input.
