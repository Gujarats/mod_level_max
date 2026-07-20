# Dynamic Veteran Stat Rolls Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` (recommended) or `superpowers:executing-plans` to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a configurable dynamic normal-stat-roll option for player levels 12 through the Level Max cap.

**Architecture:** Replace character-creation pre-queuing with a narrow hook on `getAttributeLevelUpValues`. The hook regenerates one normal roll only when vanilla would present empty or all-`+1` pending values.

**Tech Stack:** Squirrel, MSU, PowerShell.

## Global Constraints

- Replace `GrantAttributeLevelsAfterLevel11` with `EnableNormalStatRollsAfterLevel11`, default true.
- Preserve existing normal rolls and generate no rolls outside levels 12 through `MaximumLevel`.
- Do not change XP, perks, serialization, enemies, or the Legends guard.

---

### Task 1: Add the option and dynamic roll hook

**Files:**
- Modify: `scripts/!mods_preload/mod_level_max.nut`
- Modify: `scripts/mods/level_max_service.nut`
- Modify: `tools/test_level_max_layout.ps1`
- Modify: `README.md`
- Modify: `test-results/level-max-manual-matrix.md`

**Interfaces:**
- Consumes: `player.getAttributeLevelUpValues()`, `player.fillAttributeLevelUpValues(1)`.
- Produces: normal, talent-aware veteran stat rolls only when the option is enabled.

- [ ] **Step 1: Write failing static assertions**

Require `EnableNormalStatRollsAfterLevel11`, `q.getAttributeLevelUpValues`, `fillAttributeLevelUpValues(1)`, and `isNormalStatRollRequired`. Forbid `GrantAttributeLevelsAfterLevel11`, `q.setScenarioValues`, and `q.setStartValuesEx`.

- [ ] **Step 2: Verify the assertions fail**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\test_level_max_layout.ps1
```

Expected: missing `EnableNormalStatRollsAfterLevel11`.

- [ ] **Step 3: Implement the replacement setting and helper**

Add the new enabled-by-default MSU Boolean. Add `isNormalStatRollRequired(_player)` to return true only for levels 12–`MaximumLevel` with empty or all-`+1` pending values.

- [ ] **Step 4: Replace initialization hooks with the dynamic hook**

Remove both initialization hooks and `appendPostElevenAttributeRolls`. Wrap `getAttributeLevelUpValues`; when the helper returns true, clear pending arrays and call `fillAttributeLevelUpValues(1)`, then call the original method.

- [ ] **Step 5: Update documentation and manual tests**

Rename the setting in README. Add an existing-brother level-12 check and toggle-disabled fallback-`+1` check to the manual matrix.

- [ ] **Step 6: Verify, package, and commit**

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\test_level_max_layout.ps1
powershell -ExecutionPolicy Bypass -File .\tools\build_release.ps1
git add README.md scripts test-results tools
git commit -m "feat: add dynamic veteran stat roll option"
```

Expected: validator passes and archive is recreated.

## Plan Review

- The setting, hook, data-preservation rule, docs, and validation are all covered.
- The new setting key is used consistently in source, tests, and documentation.

