$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$releaseDirectory = Join-Path $root 'release'
$archivePath = Join-Path $releaseDirectory 'mod_level_max.zip'

New-Item -ItemType Directory -Force -Path $releaseDirectory | Out-Null
if (Test-Path -LiteralPath $archivePath) {
    Remove-Item -LiteralPath $archivePath -Force
}

Push-Location $root
try {
    Compress-Archive -LiteralPath '.\scripts' -DestinationPath $archivePath -CompressionLevel Optimal
}
finally {
    Pop-Location
}

Write-Host "Created $archivePath"
