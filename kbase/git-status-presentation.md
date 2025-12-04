# Git Status Presentation: Quick Reference

A streamlined guide for presenting `git status` output.

---

## 1. Core Principles

- **Show File Lists:** Always list individual files, not just counts.
- **Horizontal Separators:** Use `═` (x60) for top/bottom borders only.
- **Consistent Colors:** Use colors for status, branch names, and counts.
- **Tree Structure:** Use `├─`, `└─`, and `│` for clear hierarchy.
- **Smart Truncation:** For lists >10 files, show the first 8 and a "…and N more" summary.
- **Omit Empty Sections:** Only display sections with content (e.g., "Staged Changes").
- **Use Emojis:** Provide quick visual cues for repository and file status.
- **Clear Descriptions:** Accompany emojis with descriptive text (e.g., `↑ 3 ahead`).

---

## 2. Visual & Emoji Reference

| Emoji | Color | Meaning | Section / State |
| :---: | :---- | :---------------- | :-------------------- |
| `📍` | - | Branch Info | Header |
| `✨` | - | Clean Tree | Body |
| `📝` | Bold | Changes Header | Body |
| `✓` | Green | In Sync / Staged | Branch / Changes |
| `↑` | Yellow | Ahead | Branch Status |
| `•` | Yellow | No Upstream / Untracked | Branch / Changes |
| `⚡` | Yellow | Unstaged Changes | Changes |
| `↓` | Red | Behind | Branch Status |
| `⚠` | Red | Diverged / Important | Branch / Notes |

---

## 3. Core Templates

### Template 1: Clean State

Use when the working tree has no changes.

```
════════════════════════════════════════════════════════════
📍 Branch: <branch-name>
   └─ Upstream: <remote>/<branch> <status-emoji> <status-text>

✨ Working tree clean
════════════════════════════════════════════════════════════
```

### Template 2: State with Changes (Comprehensive)

A generic template covering all possible change types. Omit any section that is empty.

```
════════════════════════════════════════════════════════════
📍 Branch: <branch-name>
   ├─ Upstream: <remote>/<branch> <status-emoji> <status-text>
   └─ Status: <description>

📝 Working Tree Changes

[✓ Staged Changes (<count>)]
  ├─ Modified (<count>): <file-list>
  ├─ Added (<count>): <file-list>
  ├─ Deleted (<count>): <file-list>
  └─ Renamed (<count>): <old → new list>

[⚡ Unstaged Changes (<count>)]
  ├─ Modified (<count>): <file-list>
  └─ Deleted (<count>): <file-list>

[• Untracked Files (<count>)]
  └─ <file-list>

[⚠ Important]
  └─ Branch has diverged from upstream - merge or rebase needed

════════════════════════════════════════════════════════════
```

---

## 4. Formatting Notes

- **Section Headers:** `<emoji> <Title> (<N> files)` (e.g., `✓ Staged Changes (3 files)`)
- **File Counts:** Use magenta for counts in parentheses.
- **File Paths:** Sort alphabetically within each group.
- **Renamed Files:** Display as `old/path.js → new/path.js`.