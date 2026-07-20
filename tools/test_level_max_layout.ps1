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

Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'mod_level_max'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'MaximumLevel'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'GrantPerkPointsAfterLevel11'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'GrantAttributeLevelsAfterLevel11'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' 'mod_legends'
Require-Token 'scripts/!mods_preload/mod_level_max.nut' '[LevelMax] Legends detected; Level Max progression hooks are disabled.'
Require-Token 'scripts/mods/level_max_service.nut' 'rebuildLevelXP'
Require-Token 'scripts/mods/level_max_service.nut' 'OriginalLevelXP'
Require-Token 'scripts/mods/level_max_service.nut' '4000 + 1000'
Require-Token 'scripts/mods/level_max_service.nut' 'scripts/entity/tactical/player'
Require-Token 'scripts/mods/level_max_service.nut' 'q.updateLevel = @(__original) function()'
Require-Token 'scripts/mods/level_max_service.nut' 'GrantPerkPointsAfterLevel11'
Require-Token 'scripts/mods/level_max_service.nut' 'GrantAttributeLevelsAfterLevel11'

Write-Host 'Level Max layout validation passed.'
