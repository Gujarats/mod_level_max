# Veteran Level Start Readability Design

## Goal

Replace the unexplained `11` in the Level Max veteran XP extension calculation with a named local constant.

## Design

`rebuildLevelXP` will declare `local VeteranLevelStart = 11;` before deriving `veteranIndex`. The XP formula will subtract that name rather than the literal value. The resulting thresholds, configured cap, perk behavior, and attribute behavior remain unchanged.

## Verification

The static layout validator will require the new identifier and reject the old subtraction expression. The release archive will be rebuilt after the change.
