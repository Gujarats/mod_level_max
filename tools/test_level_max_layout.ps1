$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot

function Require-Token([string] $File, [string] $Token) {
    $path = Join-Path $root $File
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Missing $File"
    }

    if (-not (Get-Content -Raw -LiteralPath $path).Contains($Token)) {
        throw "Missing '$Token' in $File"
    }
}

function Forbid-Token([string] $File, [string] $Token) {
    $path = Join-Path $root $File
    if ((Get-Content -Raw -LiteralPath $path).Contains($Token)) {
        throw "Unexpected '$Token' in $File"
    }
}

Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'mod_level_max'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'MaximumLevel'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'GrantPerkPointsAfterLevel11'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'EnableNormalStatRollsAfterLevel11'
Forbid-Token 'scripts/!mods_preload/mod_level_max.nut' 'GrantAttributeLevelsAfterLevel11'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'mod_legends'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' '[LevelMax] Legends detected; Level Max progression hooks are disabled.'
Require-Token 'scripts/mods/level_max_service.nut' 'rebuildLevelXP'
Require-Token 'scripts/mods/level_max_service.nut' 'OriginalLevelXP'
Require-Token 'scripts/mods/level_max_service.nut' '4000 + 1000'
Require-Token 'scripts/mods/level_max_service.nut' 'scripts/entity/tactical/player'
Require-Token 'scripts/mods/level_max_service.nut' 'q.updateLevel = @(__original) function()'
Require-Token 'scripts/mods/level_max_service.nut' 'GrantPerkPointsAfterLevel11'
Require-Token 'scripts/mods/level_max_service.nut' 'EnableNormalStatRollsAfterLevel11'
Require-Token 'scripts/mods/level_max_service.nut' 'isNormalStatRollRequired <- function'
Require-Token 'scripts/mods/level_max_service.nut' 'q.getAttributeLevelUpValues = @(__original) function()'
Require-Token 'scripts/mods/level_max_service.nut' 'fillAttributeLevelUpValues(1)'
Forbid-Token 'scripts/mods/level_max_service.nut' 'appendPostElevenAttributeRolls'
Forbid-Token 'scripts/mods/level_max_service.nut' 'q.setScenarioValues = @(__original)'
Forbid-Token 'scripts/mods/level_max_service.nut' 'q.setStartValuesEx = @(__original)'
Require-Token 'scripts/mods/level_max_service.nut' 'local VeteranLevelStart = 11;'
Forbid-Token 'scripts/mods/level_max_service.nut' '::Const.LevelXP.len() - 11'
Require-Token 'README.md' '## Required dependencies'
Require-Token 'README.md' '## Installation'
Require-Token 'README.md' '## Configuration'
Require-Token 'README.md' '## Compatibility'
Require-Token 'README.md' '## Testing'

Write-Host 'Level Max layout validation passed.'
