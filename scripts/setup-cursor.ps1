# One-time Cursor setup for this machine.
# Usage: .\scripts\setup-cursor.ps1 [-Link]

param([switch]$Link)

$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $RepoRoot

Write-Host "=== Cursor skills setup ===" -ForegroundColor Cyan
Write-Host ""

# 1. Validate
Write-Host "[1/3] Validating skills..."
& (Join-Path $PSScriptRoot "validate-skills.ps1")
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

# 2. Sync to ~/.cursor/skills/
Write-Host ""
Write-Host "[2/3] Syncing to ~/.cursor/skills/..."
$syncArgs = @("-Prune")
if ($Link) { $syncArgs += "-Link" }
& (Join-Path $PSScriptRoot "sync-local.ps1") @syncArgs

# 3. Install git hook so pull auto-syncs local skills
Write-Host ""
Write-Host "[3/3] Installing git hooks..."
$hooksDir = Join-Path $RepoRoot ".githooks"
git config core.hooksPath .githooks
Write-Host "  core.hooksPath = .githooks"

Write-Host ""
Write-Host "=== Local setup complete ===" -ForegroundColor Green
Write-Host ""
Write-Host "Skills on this machine:" -ForegroundColor Cyan
Get-ChildItem (Join-Path $env:USERPROFILE ".cursor\skills") -Directory | ForEach-Object {
    Write-Host "  - $($_.Name)"
}
Write-Host ""
Write-Host "Verify in Cursor:" -ForegroundColor Yellow
Write-Host "  Customize -> Skills (should list grill-me, manage-skills, etc.)"
Write-Host ""
Write-Host "For Cursor App and other machines, add the GitHub remote rule:" -ForegroundColor Yellow
Write-Host "  Customize -> Rules -> Add Rule -> Remote Rule (Github)"
Write-Host "  URL: https://github.com/marcuskrogh/cursor-skills"
Write-Host ""
Write-Host "Workflow: edit skills in this repo, then:" -ForegroundColor Cyan
Write-Host "  .\scripts\validate-skills.ps1"
Write-Host "  git add . && git commit -m '...' && git push"
Write-Host "  (local ~/.cursor/skills/ updates automatically on git pull)"
