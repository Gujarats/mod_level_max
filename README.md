# Level Max

Level Max extends player-brother progression past level 11 while keeping the vanilla veteran-level XP schedule. It can provide normal perk points and normal attribute selections at each level after 11.

## Required dependencies

- Modern Hooks
- Modding Standards & Utilities (MSU) 1.9.0 or newer

## Installation

1. Install Modern Hooks and MSU in the Battle Brothers `data` folder.
2. Copy `mod_level_max.zip` from this project's `release` folder into the same `data` folder.
3. Start Battle Brothers and configure the mod in the MSU mod settings menu.

## Configuration

- **Maximum Level**: The highest level for player brothers. The default is 51; the allowed range is 11–100.
- **Grant Perk Points After Level 11**: Enabled by default. Gives one perk point at every level from 12 through the configured cap.
- **Grant Attribute Levels After Level 11**: Enabled by default. Gives the normal attribute selection at every level from 12 through the configured cap. Talent stars affect these rolls just as they do before level 11.

The vanilla veteran XP progression is unchanged. Restart the game after changing settings. A setting change does not retroactively add or remove perk points or attribute rolls that are already stored in a save.

## Compatibility

This first release supports vanilla Battle Brothers with Modern Hooks and MSU. It only changes player brothers; enemies and save serialization are untouched.

Legends is intentionally unsupported. If Legends is detected, Level Max logs that its progression hooks are disabled and makes no progression changes. Test with only Modern Hooks, MSU, and Level Max first, then add other mods one at a time.

## Testing

Use `tools/test_level_max_layout.ps1` for static project checks and `tools/build_release.ps1` to create the archive. Follow `test-results/level-max-manual-matrix.md` for in-game checks, including save/load and the Legends guard.

