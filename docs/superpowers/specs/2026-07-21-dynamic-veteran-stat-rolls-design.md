# Dynamic Veteran Stat Rolls Design

## Goal

Let users enable or disable normal, talent-aware attribute rolls after level 11 for both new and existing player brothers.

## Setting

Replace `GrantAttributeLevelsAfterLevel11` with `EnableNormalStatRollsAfterLevel11`. It is enabled by default. The setting applies only to levels 12 through the configured `MaximumLevel`.

## Behavior

Hook `player.getAttributeLevelUpValues`. If the setting is enabled, the brother is in range, and every pending attribute value is either absent or the vanilla fallback `+1`, clear the queue and generate exactly one normal attribute roll with `fillAttributeLevelUpValues(1)`. Existing non-fallback pending rolls are preserved.

## Boundaries

Do not pre-generate rolls during `setScenarioValues` or `setStartValuesEx`. Do not change enemy entities, perk behavior, XP thresholds, save serialization, or the Legends guard.

## Verification

The static validator will require the replacement setting and dynamic hook, reject the removed setting and initialization hooks, and the release archive will be rebuilt.
