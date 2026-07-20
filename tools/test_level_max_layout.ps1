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
Require-Token 'scripts/mods/level_max_service.nut' 'rebuildLevelXP'

Write-Host 'Level Max layout validation passed.'
