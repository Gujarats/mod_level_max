# Veteran Level Start Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` (recommended) or `superpowers:executing-plans` to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the veteran-level starting literal with a local constant without changing XP thresholds.

**Architecture:** The existing `rebuildLevelXP` function remains responsible for appending XP thresholds. A local `VeteranLevelStart` documents the level at which the increasing veteran progression begins and is used only to derive `veteranIndex`.

**Tech Stack:** Squirrel, PowerShell static validator.

## Global Constraints

- Preserve the exact existing XP formula and all generated thresholds.
- Use `local VeteranLevelStart = 11;` within `rebuildLevelXP`.
- Do not change any settings, hooks, archive layout, or gameplay behavior.

---

### Task 1: Replace the magic number with a named constant

**Files:**
- Modify: `scripts/mods/level_max_service.nut`
- Modify: `tools/test_level_max_layout.ps1`

**Interfaces:**
- Consumes: `::Const.LevelXP.len()`.
- Produces: unchanged `veteranIndex` values and XP thresholds.

- [ ] **Step 1: Write the failing static assertion**

Add to `tools/test_level_max_layout.ps1`:

```powershell
Require-Token 'scripts/mods/level_max_service.nut' 'local VeteranLevelStart = 11;'
```

Add a negative assertion that fails when the service contains `::Const.LevelXP.len() - 11`.

- [ ] **Step 2: Run the validator to verify failure**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\test_level_max_layout.ps1
```

Expected: failure for missing `local VeteranLevelStart = 11;`.

- [ ] **Step 3: Implement the smallest source change**

Within `rebuildLevelXP`, add:

```squirrel
local VeteranLevelStart = 11;
```

Replace:

```squirrel
local veteranIndex = ::Const.LevelXP.len() - 11;
```

with:

```squirrel
local veteranIndex = ::Const.LevelXP.len() - VeteranLevelStart;
```

- [ ] **Step 4: Verify the static check and release build**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\test_level_max_layout.ps1
powershell -ExecutionPolicy Bypass -File .\tools\build_release.ps1
```

Expected: validator passes and `release/mod_level_max.zip` is recreated.

- [ ] **Step 5: Commit the refactor**

```powershell
git add scripts/mods/level_max_service.nut tools/test_level_max_layout.ps1
git commit -m "refactor: name veteran level start"
```

## Plan Review

- The only literal replaced is the one used to calculate `veteranIndex`.
- The named constant and validator token use the same spelling.
- No gameplay behavior changes are included.

