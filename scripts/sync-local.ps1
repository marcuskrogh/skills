# Sync skills from this repo to the applied harness only.
# Usage: .\scripts\sync-local.ps1 [-Prune] [-Link] [-Harness cursor]
#
# -Harness or SKILLS_HARNESS selects the harness. When both are absent, detect
# the harness that is running this script. Skill folders, instruction files, and
# rules are written only for that harness.
#
# For project installs, prefer agent-from-git:
#   bash scripts/install-from-git.sh
# Also supported: npx skills add marcuskrogh/skills

param(
    [switch]$Prune,
    [switch]$Link,
    [string]$Harness = "",
    [string[]]$Targets = @()
)

$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$SourceDir = Join-Path $RepoRoot "skills"
$ConceptsSource = Join-Path $SourceDir "concepts"

if (-not (Test-Path $SourceDir)) {
    Write-Error "Source directory not found: $SourceDir"
}

$skillDirs = Get-ChildItem -Path $SourceDir -Directory | Where-Object {
    $_.Name -ne "concepts" -and (Test-Path (Join-Path $_.FullName "SKILL.md"))
}

if ($skillDirs.Count -eq 0) {
    Write-Error "No skills with SKILL.md found under $SourceDir"
}

if (-not (Test-Path $ConceptsSource)) {
    Write-Error "Concepts directory not found: $ConceptsSource"
}

function Resolve-AppliedHarnesses {
    param([string]$Explicit)

    $raw = $Explicit
    if ([string]::IsNullOrWhiteSpace($raw)) { $raw = $env:SKILLS_HARNESS }
    $found = @()
    if (-not [string]::IsNullOrWhiteSpace($raw)) {
        foreach ($item in ($raw -split '[,\s]+')) {
            $name = $item.Trim().ToLowerInvariant()
            if ($name -eq "") { continue }
            if ($name -eq "all") {
                Write-Error "SKILLS_HARNESS=all is refused. Name only the harnesses that should receive files (cursor, claude, codex, copilot)."
            }
            if ($name -notin @("cursor", "claude", "codex", "copilot")) {
                Write-Error "Unknown harness '$name'. Use cursor, claude, codex, or copilot."
            }
            if ($name -notin $found) { $found += $name }
        }
    } else {
        if ($env:CURSOR_AGENT) { $found += "cursor" }
        if ($env:CLAUDE_CODE -or $env:CLAUDECODE -or $env:CLAUDE_CODE_ENTRYPOINT) { $found += "claude" }
        if ($env:CODEX_THREAD_ID -or $env:CODEX_SANDBOX -or $env:CODEX_CI) { $found += "codex" }
        if ($env:COPILOT_AGENT -or $env:GITHUB_COPILOT -or $env:COPILOT_CLI) { $found += "copilot" }
    }
    if ($found.Count -eq 0) {
        Write-Error "No applied harness. Set -Harness or SKILLS_HARNESS=cursor|claude|codex|copilot. Refusing to write skill folders, instruction files, or rules for harnesses that are not in use."
    }
    return $found
}

function Get-GlobalSkillsDir {
    param([string]$Id)
    switch ($Id) {
        "claude" { return (Join-Path $env:USERPROFILE ".claude\skills") }
        "cursor" { return (Join-Path $env:USERPROFILE ".cursor\skills") }
        "codex" { return (Join-Path $env:USERPROFILE ".codex\skills") }
        "copilot" { return (Join-Path $env:USERPROFILE ".copilot\skills") }
        default { Write-Error "Unknown harness '$Id'" }
    }
}

$applied = @(Resolve-AppliedHarnesses -Explicit $Harness)
if ($Targets.Count -eq 0) {
    $Targets = @($applied | ForEach-Object { Get-GlobalSkillsDir $_ })
}
Write-Host "Applied harness: $($applied -join ', ')"

function Sync-Item {
    param(
        [string]$SourcePath,
        [string]$DestPath,
        [string]$Label,
        [switch]$AsLink
    )

    if ($AsLink) {
        if (Test-Path $DestPath) {
            $item = Get-Item $DestPath -Force
            if ($item.LinkType) {
                if ($item.Target -eq $SourcePath) {
                    Write-Host "Linked ($Label)"
                    return
                }
                Remove-Item $DestPath -Force
            } else {
                Remove-Item $DestPath -Recurse -Force
            }
        }
        New-Item -ItemType Junction -Path $DestPath -Target $SourcePath | Out-Null
        Write-Host "Linked ($Label)"
    } else {
        if (Test-Path $DestPath) {
            Remove-Item $DestPath -Recurse -Force
        }
        Copy-Item -Path $SourcePath -Destination $DestPath -Recurse -Force
        Write-Host "Copied ($Label)"
    }
}

foreach ($TargetDir in $Targets) {
  New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
  $synced = @()

  foreach ($skill in $skillDirs) {
    $dest = Join-Path $TargetDir $skill.Name
    Sync-Item -SourcePath $skill.FullName -DestPath $dest -Label "$TargetDir`: $($skill.Name)" -AsLink:$Link
    $synced += $skill.Name
  }

  $conceptsDest = Join-Path $TargetDir "concepts"
  Sync-Item -SourcePath $ConceptsSource -DestPath $conceptsDest -Label "$TargetDir`: concepts" -AsLink:$Link
  $synced += "concepts"

  if ($Prune) {
    $existing = Get-ChildItem -Path $TargetDir -Directory -ErrorAction SilentlyContinue
    foreach ($dir in $existing) {
      if ($dir.Name -notin $synced) {
        Write-Host "Pruning ($TargetDir): $($dir.Name)"
        Remove-Item $dir.FullName -Recurse -Force
      }
    }
  }

  Write-Host "Synced $($synced.Count) item(s) to $TargetDir"
}

function Upsert-MarkedBlock {
  param(
    [string]$DestPath,
    [string]$BlockPath
  )

  $begin = '<!-- marcuskrogh/skills:begin -->'
  $end = '<!-- marcuskrogh/skills:end -->'
  $block = Get-Content -Path $BlockPath -Raw
  if ($block -notmatch "`n$") { $block += "`n" }

  $dir = Split-Path -Parent $DestPath
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
  }

  if (-not (Test-Path $DestPath)) {
    Set-Content -Path $DestPath -Value $block -NoNewline
    Write-Host "Wrote $DestPath"
    return
  }

  $existing = Get-Content -Path $DestPath -Raw
  if ($null -eq $existing) { $existing = '' }

  if ($existing.Contains($begin)) {
    $before = $existing.Substring(0, $existing.IndexOf($begin))
    $after = ''
    $endAt = $existing.IndexOf($end)
    if ($endAt -ge 0) {
      $afterStart = $endAt + $end.Length
      if ($afterStart -lt $existing.Length) {
        $after = $existing.Substring($afterStart)
        $after = $after -replace '^(\r\n|\n|\r)', ''
      }
    }
    $out = $before + $block
    if ($after.Trim().Length -gt 0) {
      if ($out -notmatch "(\r\n|\n)$") { $out += "`n" }
      $out += "`n" + $after
    }
    Set-Content -Path $DestPath -Value $out -NoNewline
    Write-Host "Updated $DestPath"
  } else {
    $out = $block + "`n" + $existing
    Set-Content -Path $DestPath -Value $out -NoNewline
    Write-Host "Prepended $DestPath"
  }
}

Write-Host ""
Write-Host "Wiring instruction files for: $($applied -join ', ')"
$tpl = Join-Path $RepoRoot (Join-Path "templates" "agent-install")
foreach ($id in $applied) {
  switch ($id) {
    "cursor" {
      $cursorRule = Join-Path $tpl "global-cursor-language.mdc"
      if (-not (Test-Path $cursorRule)) { Write-Error "Missing $cursorRule" }
      $cursorRulesDir = Join-Path $env:USERPROFILE ".cursor\rules"
      New-Item -ItemType Directory -Force -Path $cursorRulesDir | Out-Null
      $cursorDest = Join-Path $cursorRulesDir "marcuskrogh-skills.mdc"
      Copy-Item -Path $cursorRule -Destination $cursorDest -Force
      Write-Host "Wrote $cursorDest"
    }
    "claude" {
      $claudeBlock = Join-Path $tpl "global-CLAUDE.block.md"
      if (-not (Test-Path $claudeBlock)) { Write-Error "Missing $claudeBlock" }
      Upsert-MarkedBlock -DestPath (Join-Path $env:USERPROFILE ".claude\CLAUDE.md") -BlockPath $claudeBlock
    }
    "codex" {
      $src = Join-Path $tpl (Join-Path "harness" "codex.md")
      if (-not (Test-Path $src)) { Write-Error "Missing $src" }
      $rendered = Join-Path ([System.IO.Path]::GetTempPath()) ("codex-instructions-" + [guid]::NewGuid().ToString() + ".md")
      (Get-Content -Path $src -Raw).Replace("__SKILLS__", "~/.codex/skills") | Set-Content -Path $rendered -NoNewline
      Upsert-MarkedBlock -DestPath (Join-Path $env:USERPROFILE ".codex\AGENTS.md") -BlockPath $rendered
      Remove-Item $rendered -Force
    }
    "copilot" {
      $src = Join-Path $tpl (Join-Path "harness" "copilot.md")
      if (-not (Test-Path $src)) { Write-Error "Missing $src" }
      $rendered = Join-Path ([System.IO.Path]::GetTempPath()) ("copilot-instructions-" + [guid]::NewGuid().ToString() + ".md")
      (Get-Content -Path $src -Raw).Replace("__SKILLS__", "~/.copilot/skills") | Set-Content -Path $rendered -NoNewline
      Upsert-MarkedBlock -DestPath (Join-Path $env:USERPROFILE ".copilot\copilot-instructions.md") -BlockPath $rendered
      Remove-Item $rendered -Force
    }
  }
}

Write-Host ""
if (-not $Link) {
  Write-Host "Tip: use -Link for live edits without re-syncing (requires Windows Developer Mode or admin)."
}
Write-Host "Tip: for project installs, prefer agent-from-git:"
Write-Host "  bash scripts/install-from-git.sh"
Write-Host "Also supported: npx skills add marcuskrogh/skills"
