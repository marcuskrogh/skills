# Sync skills from this repo to ~/.cursor/skills/ for local IDE use.
# Usage: .\scripts\sync-local.ps1 [-Prune] [-Link]

param(
    [switch]$Prune,
    [switch]$Link
)

$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$SourceDir = Join-Path $RepoRoot ".cursor\skills"
$TargetDir = Join-Path $env:USERPROFILE ".cursor\skills"

if (-not (Test-Path $SourceDir)) {
    Write-Error "Source directory not found: $SourceDir"
}

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

$skillDirs = Get-ChildItem -Path $SourceDir -Directory
$synced = @()

foreach ($skill in $skillDirs) {
  $dest = Join-Path $TargetDir $skill.Name

  if ($Link) {
    if (Test-Path $dest) {
      $item = Get-Item $dest -Force
      if ($item.LinkType) {
        if ($item.Target -eq $skill.FullName) {
          Write-Host "Linked: $($skill.Name)"
          $synced += $skill.Name
          continue
        }
        Remove-Item $dest -Force
      } else {
        Remove-Item $dest -Recurse -Force
      }
    }
    New-Item -ItemType Junction -Path $dest -Target $skill.FullName | Out-Null
    Write-Host "Linked: $($skill.Name)"
  } else {
    if (Test-Path $dest) {
      Remove-Item $dest -Recurse -Force
    }
    Copy-Item -Path $skill.FullName -Destination $dest -Recurse -Force
    Write-Host "Copied: $($skill.Name)"
  }

  $synced += $skill.Name
}

if ($Prune) {
  $existing = Get-ChildItem -Path $TargetDir -Directory
  foreach ($dir in $existing) {
    if ($dir.Name -notin $synced) {
      Write-Host "Pruning: $($dir.Name)"
      Remove-Item $dir.FullName -Recurse -Force
    }
  }
}

Write-Host ""
Write-Host "Synced $($synced.Count) skill(s) to $TargetDir"
if (-not $Link) {
  Write-Host "Tip: use -Link for live edits without re-syncing (requires Windows Developer Mode or admin)."
}
