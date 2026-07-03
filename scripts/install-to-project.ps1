# Install skills from this repo into a project's .cursor/skills/ directory.
# Usage:
#   .\scripts\install-to-project.ps1 -ProjectPath C:\path\to\repo
#   .\scripts\install-to-project.ps1 -ProjectPath C:\path\to\repo -Skill grill-me -Submodule

param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [string[]]$Skill = @(),

    [switch]$Submodule,

    [switch]$All
)

$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$SourceDir = Join-Path $RepoRoot ".cursor\skills"

if (-not (Test-Path -LiteralPath $ProjectPath)) {
    Write-Error "Project path not found: $ProjectPath"
}
$ProjectPath = (Resolve-Path -LiteralPath $ProjectPath).Path
$TargetDir = Join-Path $ProjectPath ".cursor\skills"

if (-not (Test-Path $SourceDir)) {
    Write-Error "Source directory not found: $SourceDir"
}

if ($Submodule) {
    Push-Location $ProjectPath
    try {
        $relativeRepo = (Resolve-Path $RepoRoot -Relative).Replace('\', '/')
        if (Test-Path ".cursor\skills") {
            Write-Warning ".cursor\skills already exists. Remove it before adding submodule."
            exit 1
        }
        New-Item -ItemType Directory -Force -Path ".cursor" | Out-Null
        git submodule add $relativeRepo ".cursor/skills"
        Write-Host "Added git submodule at .cursor/skills"
        Write-Host "Cloud agents and collaborators will receive skills when they clone with --recurse-submodules"
    } finally {
        Pop-Location
    }
    exit 0
}

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

$available = Get-ChildItem -Path $SourceDir -Directory
if ($All -or $Skill.Count -eq 0) {
    $toInstall = $available
} else {
    $toInstall = $available | Where-Object { $_.Name -in $Skill }
    $missing = $Skill | Where-Object { $_ -notin ($available.Name) }
    foreach ($name in $missing) {
        Write-Warning "Skill not found in repo: $name"
    }
}

foreach ($skill in $toInstall) {
    $dest = Join-Path $TargetDir $skill.Name
    if (Test-Path $dest) {
        Remove-Item $dest -Recurse -Force
    }
    Copy-Item -Path $skill.FullName -Destination $dest -Recurse -Force
    Write-Host "Installed to project: $($skill.Name)"
}

Write-Host ""
Write-Host "Installed $($toInstall.Count) skill(s) to $TargetDir"
Write-Host "Commit .cursor/skills/ to share with cloud agents and your team."
