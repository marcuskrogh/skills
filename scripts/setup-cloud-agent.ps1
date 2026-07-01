# Add cloud agent skill sync to a project (Option 1).
# Commits small bootstrap files; skills are fetched from GitHub at cloud VM startup.
# Usage: .\scripts\setup-cloud-agent.ps1 -ProjectPath D:\code\MyRepo

param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [string]$SkillsRepo = "https://github.com/marcuskrogh/cursor-skills.git",

    [switch]$SkipGitignore
)

$ErrorActionPreference = "Stop"

$TemplateRoot = Resolve-Path (Join-Path $PSScriptRoot "..\templates\cloud-agent")
if (-not (Test-Path $TemplateRoot)) {
    Write-Error "Template directory not found: $TemplateRoot"
}

if (-not (Test-Path -LiteralPath $ProjectPath)) {
    Write-Error "Project path not found: $ProjectPath"
}
$ProjectPath = (Resolve-Path -LiteralPath $ProjectPath).Path

$cursorDir = Join-Path $ProjectPath ".cursor"
New-Item -ItemType Directory -Force -Path $cursorDir | Out-Null

$syncScript = Join-Path $cursorDir "sync-cursor-skills.sh"
Copy-Item (Join-Path $TemplateRoot "sync-cursor-skills.sh") $syncScript -Force

$envJson = Join-Path $cursorDir "environment.json"
if (Test-Path $envJson) {
    Write-Warning "environment.json already exists — merge install steps manually:"
    Write-Warning '  bash .cursor/sync-cursor-skills.sh && <your existing install>'
} else {
    $content = @"
{
  "install": "bash .cursor/sync-cursor-skills.sh"
}
"@
    Set-Content -Path $envJson -Value $content -NoNewline
    Add-Content -Path $envJson -Value ""
}

(Get-Content $syncScript -Raw) -replace 'https://github.com/marcuskrogh/cursor-skills.git', $SkillsRepo | Set-Content $syncScript -NoNewline

if (-not $SkipGitignore) {
    $gitignore = Join-Path $ProjectPath ".gitignore"
    $entry = "`n# Synced from cursor-skills at cloud agent startup — do not commit`n.cursor/skills/"
    if (Test-Path $gitignore) {
        $existing = Get-Content $gitignore -Raw
        if ($existing -notmatch '\.cursor/skills/') {
            Add-Content -Path $gitignore -Value $entry
        }
    } else {
        Set-Content -Path $gitignore -Value $entry.TrimStart()
    }
}

Write-Host "Cloud agent skill sync installed at $cursorDir"
Write-Host "Commit .cursor/sync-cursor-skills.sh, .cursor/environment.json, and .gitignore"
