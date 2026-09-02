# Validate SKILL.md files and CONCEPT_*.md files in this repo.
# Usage: .\scripts\validate-skills.ps1

$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$SkillsDir = Join-Path $RepoRoot "skills"
$ConceptsDir = Join-Path $SkillsDir "concepts"
$errors = 0

if (-not (Test-Path $SkillsDir)) {
    Write-Error "Skills directory not found: $SkillsDir"
}

function Test-SkillFrontmatter {
    param([string]$Path)

    $content = Get-Content -Path $Path -Raw
    if ($content -notmatch '(?s)^---\s*\r?\n(.*?)\r?\n---') {
        Write-Host "FAIL: Missing YAML frontmatter - $Path"
        return $false
    }

    $yaml = $Matches[1]
    $ok = $true

    if ($yaml -notmatch '(?m)^name:\s*(.+)$') {
        Write-Host "FAIL: Missing name field - $Path"
        $ok = $false
    } else {
        $name = $Matches[1].Trim().Trim('"').Trim("'")
        if ($name -notmatch '^[a-z0-9-]+$') {
            Write-Host "FAIL: Invalid name '$name' - $Path"
            $ok = $false
        }
        $folder = Split-Path (Split-Path $Path -Parent) -Leaf
        if ($name -ne $folder) {
            Write-Host "FAIL: name '$name' does not match folder '$folder' - $Path"
            $ok = $false
        }
    }

    if ($yaml -notmatch '(?m)^description:\s*(.+)$') {
        Write-Host "FAIL: Missing description field - $Path"
        $ok = $false
    }

    $lines = (Get-Content -Path $Path).Count
    if ($lines -gt 500) {
        Write-Host "WARN: SKILL.md exceeds 500 lines ($lines) - $Path"
    }

    if ($ok) {
        Write-Host "OK: $Path"
    }
    return $ok
}

Get-ChildItem -Path $SkillsDir -Recurse -Filter "SKILL.md" | ForEach-Object {
    $parentName = Split-Path $_.DirectoryName -Leaf
    if ($parentName -eq "concepts") {
        Write-Host "FAIL: concepts/ must not contain SKILL.md - $($_.FullName)"
        $script:errors++
        return
    }
    if (-not (Test-SkillFrontmatter -Path $_.FullName)) {
        $script:errors++
    }
}

if (-not (Test-Path $ConceptsDir)) {
    Write-Host "FAIL: Missing concepts directory: $ConceptsDir"
    $script:errors++
} else {
    $conceptFiles = Get-ChildItem -Path $ConceptsDir -File -Filter "CONCEPT_*.md"
    if ($conceptFiles.Count -eq 0) {
        Write-Host "FAIL: No CONCEPT_*.md files in $ConceptsDir"
        $script:errors++
    }
    foreach ($cf in $conceptFiles) {
        if ($cf.Name -notmatch '^CONCEPT_[A-Z0-9_]+\.md$') {
            Write-Host "FAIL: Invalid concept filename '$($cf.Name)' (expected CONCEPT_<NAME>.md)"
            $script:errors++
        } else {
            Write-Host "OK: $($cf.FullName)"
        }
    }
    # Disclosed reference files (e.g. PLATFORM-CATALOGS.md) are allowed beside CONCEPT_*.md
    Get-ChildItem -Path $ConceptsDir -File | Where-Object {
        $_.Name -notlike "CONCEPT_*.md" -and $_.Name -ne "README.md" -and $_.Extension -ne ".md"
    } | ForEach-Object {
        Write-Host "WARN: unexpected file in concepts/: $($_.Name)"
    }
    Get-ChildItem -Path $ConceptsDir -File -Filter "*.md" | Where-Object {
        $_.Name -notlike "CONCEPT_*.md" -and $_.Name -ne "README.md"
    } | ForEach-Object {
        Write-Host "OK: disclosed concept reference $($_.FullName)"
    }

    # Cursor platform file must stay a closed Composer + Grok allowlist.
    $cursorPlatform = Join-Path (Join-Path $ConceptsDir "platforms") "cursor.md"
    if (-not (Test-Path $cursorPlatform)) {
        Write-Host "FAIL: Missing Cursor platform catalog: $cursorPlatform"
        $script:errors++
    } else {
        $cursorText = Get-Content -Path $cursorPlatform -Raw
        $slugMatches = [regex]::Matches($cursorText, '`([a-z0-9][a-z0-9._-]*)`')
        $allowed = @(
            'composer-2.5',
            'cursor-grok-4.6-high'
        )
        $illegal = @()
        foreach ($m in $slugMatches) {
            $slug = $m.Groups[1].Value
            # Skip non-model backticks (file paths, short tokens)
            if ($slug -notmatch '^(composer|cursor-grok|claude|gpt|kimi|fable|opus|sonnet|haiku|gemini|llama|qwen|minimax|deepseek|glm|grok)') {
                continue
            }
            if ($slug -match '-fast$' -or $slug -notin $allowed) {
                $illegal += $slug
            }
        }
        if ($illegal.Count -gt 0) {
            $uniq = $illegal | Select-Object -Unique
            Write-Host "FAIL: Cursor platform catalog has off-allowlist model slug(s): $($uniq -join ', ')"
            $script:errors++
        } else {
            Write-Host "OK: Cursor platform allowlist (Composer + Grok only)"
        }
        foreach ($need in $allowed) {
            $wrapped = '`' + $need + '`'
            if ($cursorText.IndexOf($wrapped) -lt 0) {
                Write-Host "FAIL: Cursor platform catalog missing required slug $wrapped"
                $script:errors++
            }
        }
        $missingTypes = @()
        foreach ($needType in @('computerUse', 'videoReview')) {
            if ($cursorText.IndexOf($needType) -lt 0) {
                $missingTypes += $needType
                Write-Host "FAIL: Cursor platform catalog must name Task type $needType (catalog-closed for specialized spawns)"
                $script:errors++
            }
        }
        if ($missingTypes.Count -eq 0) {
            Write-Host "OK: Cursor platform names computerUse and videoReview"
        }
        $cursorNeedles = @(
            @{ Needle = 'Mobile'; Label = 'Mobile in Cursor detection' },
            @{ Needle = 'inherit'; Label = 'inherit forbidden on Cursor' },
            @{ Needle = 'incomplete'; Label = 'incomplete enum stays Cursor' }
        )
        foreach ($need in $cursorNeedles) {
            if ($cursorText.IndexOf($need.Needle) -lt 0) {
                Write-Host "FAIL: Cursor platform catalog must contain '$($need.Needle)' ($($need.Label))"
                $script:errors++
            } else {
                Write-Host "OK: Cursor platform $($need.Label)"
            }
        }
    }

    $catalogIndex = Join-Path $ConceptsDir "PLATFORM-CATALOGS.md"
    if (-not (Test-Path $catalogIndex)) {
        Write-Host "FAIL: Missing platform catalog index: $catalogIndex"
        $script:errors++
    } else {
        $indexText = Get-Content -Path $catalogIndex -Raw
        if ($indexText -match 'use General when unknown or incomplete') {
            Write-Host "FAIL: PLATFORM-CATALOGS.md must not fall through to General when the Task enum is incomplete"
            $script:errors++
        } else {
            Write-Host "OK: PLATFORM-CATALOGS.md does not treat incomplete enum as General"
        }
        foreach ($need in @('Mobile', 'inherit')) {
            if ($indexText.IndexOf($need) -lt 0) {
                Write-Host "FAIL: PLATFORM-CATALOGS.md must contain '$need' (Cursor first-party spawn)"
                $script:errors++
            } else {
                Write-Host "OK: PLATFORM-CATALOGS.md names $need"
            }
        }
    }
}

function Get-PointerText {
    param([string]$Path)

    $item = Get-Item -Path $Path -Force
    if ($item.LinkType) {
        $target = $item.Target
        if ($target -is [array]) { $target = $target[0] }
        if (-not [IO.Path]::IsPathRooted($target)) {
            $target = Join-Path (Split-Path $Path -Parent) $target
        }
        return Get-Content -Path $target -Raw
    }

    $raw = Get-Content -Path $Path -Raw
    $trimmed = $raw.Trim()
    if ($trimmed -match '^(AGENTS\.md|CLAUDE\.md)$') {
        $target = Join-Path (Split-Path $Path -Parent) $trimmed
        if (Test-Path $target) {
            return Get-Content -Path $target -Raw
        }
    }
    return $raw
}

# Always-on Cursor pointers must name computerUse / videoReview so sandbox
# inspect spawns stay catalog-closed even before skills load, and must name
# Mobile / inherit / composer-2.5 so Cloud-from-Mobile cannot pick picker models.
$pointerFiles = @(
    (Join-Path $RepoRoot "AGENTS.md"),
    (Join-Path $RepoRoot "CLAUDE.md"),
    (Join-Path $RepoRoot (Join-Path ".cursor" (Join-Path "rules" "github-skills.mdc"))),
    (Join-Path $RepoRoot (Join-Path "templates" (Join-Path "agent-install" "AGENTS.md"))),
    (Join-Path $RepoRoot (Join-Path "templates" (Join-Path "agent-install" "AGENTS.block.md"))),
    (Join-Path $RepoRoot (Join-Path "templates" (Join-Path "agent-install" "github-skills.mdc")))
)
foreach ($pf in $pointerFiles) {
    if (-not (Test-Path $pf)) {
        Write-Host "FAIL: Missing always-on Cursor pointer file: $pf"
        $script:errors++
        continue
    }
    $pointerText = Get-PointerText -Path $pf
    $pointerOk = $true
    foreach ($needType in @('computerUse', 'videoReview')) {
        if ($pointerText.IndexOf($needType) -lt 0) {
            Write-Host "FAIL: $pf must name Task type $needType"
            $script:errors++
            $pointerOk = $false
        }
    }
    foreach ($need in @('Mobile', 'inherit', 'composer-2.5')) {
        if ($pointerText.IndexOf($need) -lt 0) {
            Write-Host "FAIL: $pf must contain '$need' (Cursor first-party spawn on Mobile / enum remap)"
            $script:errors++
            $pointerOk = $false
        }
    }
    if ($pointerOk) {
        Write-Host "OK: $pf names computerUse, videoReview, Mobile, inherit, and composer-2.5"
    }
    foreach ($langNeed in @('CONCEPT_LANGUAGE', 'LANGUAGE-PHRASES', 'GeneralProcessSimulator', 'harness')) {
        if ($pointerText.IndexOf($langNeed) -lt 0) {
            Write-Host "FAIL: $pf must contain '$langNeed' (always-on language extract)"
            $script:errors++
            $pointerOk = $false
        }
    }
    if ($pointerText.IndexOf('CONCEPT_LANGUAGE') -ge 0 -and $pointerText.IndexOf('LANGUAGE-PHRASES') -ge 0) {
        Write-Host "OK: $pf names CONCEPT_LANGUAGE and LANGUAGE-PHRASES"
    }
}

$phrasesRef = Join-Path $ConceptsDir "LANGUAGE-PHRASES.md"
if (-not (Test-Path $phrasesRef)) {
    Write-Host "FAIL: Missing language phrase catalog: $phrasesRef"
    $script:errors++
} else {
    Write-Host "OK: LANGUAGE-PHRASES.md"
}

$globalLangFiles = @(
    (Join-Path $RepoRoot (Join-Path "templates" (Join-Path "agent-install" "global-CLAUDE.block.md"))),
    (Join-Path $RepoRoot (Join-Path "templates" (Join-Path "agent-install" "global-cursor-language.mdc")))
)
foreach ($gf in $globalLangFiles) {
    if (-not (Test-Path $gf)) {
        Write-Host "FAIL: Missing global language pointer: $gf"
        $script:errors++
        continue
    }
    $gText = Get-Content -Path $gf -Raw
    $gOk = $true
    foreach ($langNeed in @('CONCEPT_LANGUAGE', 'LANGUAGE-PHRASES', 'GeneralProcessSimulator', 'harness')) {
        if ($gText.IndexOf($langNeed) -lt 0) {
            Write-Host "FAIL: $gf must contain '$langNeed'"
            $script:errors++
            $gOk = $false
        }
    }
    if ($gOk) {
        Write-Host "OK: $gf language extract"
    }
}

$pluginJson = Join-Path $RepoRoot ".claude-plugin\plugin.json"
if (Test-Path $pluginJson) {
    $plugin = Get-Content $pluginJson -Raw | ConvertFrom-Json
    $declared = @($plugin.skills)
    $onDisk = Get-ChildItem -Path $SkillsDir -Directory | Where-Object {
        $_.Name -ne "concepts" -and (Test-Path (Join-Path $_.FullName "SKILL.md"))
    } | ForEach-Object { "./skills/$($_.Name)" }

    foreach ($path in $declared) {
        $abs = Join-Path $RepoRoot ($path -replace '^\./', '' -replace '/', '\')
        if (-not (Test-Path (Join-Path $abs "SKILL.md"))) {
            Write-Host "FAIL: plugin.json declares missing skill: $path"
            $script:errors++
        }
        if ($path -match 'concepts') {
            Write-Host "FAIL: plugin.json must not declare concepts as a skill: $path"
            $script:errors++
        }
    }

    foreach ($path in $onDisk) {
        if ($path -notin $declared) {
            $msg = "skill on disk not declared in plugin.json: $path"
            if ($path -in @('./skills/test', './skills/harden', './skills/adopt')) {
                Write-Host "FAIL: $msg"
                $script:errors++
            } else {
                Write-Host "WARN: $msg"
            }
        }
    }
} else {
    Write-Host "WARN: .claude-plugin/plugin.json missing"
}

# Shipping-phase floor: every template defaults test + harden to dedicated.
$catalogPath = Join-Path $ConceptsDir "CLASSIFICATION-CATALOG.md"
if (-not (Test-Path $catalogPath)) {
    Write-Host "FAIL: Missing classification catalog: $catalogPath"
    $script:errors++
} else {
    $catalog = Get-Content -Path $catalogPath -Raw
    $closeoutAt = $catalog.IndexOf('**Closeout**')
    if ($closeoutAt -lt 0) {
        Write-Host "FAIL: CLASSIFICATION-CATALOG.md missing Closeout defaults table"
        $script:errors++
    } else {
        $closeout = $catalog.Substring($closeoutAt)
        $templates = @(
            'fix-fast',
            'delta-fast',
            'structure-safe',
            'parity-iterative',
            'feature-standard',
            'feature-heavy'
        )
        $floorOk = $true
        foreach ($t in $templates) {
            $row = [regex]::Match($closeout, "(?m)^\s*\|\s*$t\s*\|\s*(\S+)\s*\|\s*(\S+)\s*\|")
            if (-not $row.Success) {
                Write-Host "FAIL: Closeout defaults missing template $t"
                $script:errors++
                $floorOk = $false
            } elseif ($row.Groups[1].Value -ne 'dedicated' -or $row.Groups[2].Value -ne 'dedicated') {
                Write-Host "FAIL: Closeout floor for $t must be test.mode=dedicated and harden.mode=dedicated (got $($row.Groups[1].Value) / $($row.Groups[2].Value))"
                $script:errors++
                $floorOk = $false
            }
        }
        if ($floorOk) {
            Write-Host "OK: Closeout floor (test + harden dedicated) for all templates"
        }
    }
}

# Adopt / test working-surface proof: startable frontend and backend stay in the bar.
$workingSurfaceChecks = @(
    @{ Path = (Join-Path (Join-Path $SkillsDir "adopt") "characterize.md"); Need = @('working surface', 'backend', 'frontend', 'composed') },
    @{ Path = (Join-Path (Join-Path $SkillsDir "adopt") "route.md"); Need = @('Working surfaces', 'startable backend', 'startable frontend') },
    @{ Path = (Join-Path (Join-Path $SkillsDir "implement") "testing.md"); Need = @('## Working surfaces', 'working_surfaces:') },
    @{ Path = (Join-Path $ConceptsDir "CONCEPT_STRUCTURE.md"); Need = @('working surface', 'Lock before restructure') },
    @{ Path = (Join-Path $ConceptsDir "CONCEPT_IMPLEMENTATION.md"); Need = @('working surface') },
    @{ Path = (Join-Path (Join-Path $SkillsDir "test") "SKILL.md"); Need = @('working surface') }
)
$wsOk = $true
foreach ($check in $workingSurfaceChecks) {
    if (-not (Test-Path $check.Path)) {
        Write-Host "FAIL: Missing working-surface file: $($check.Path)"
        $script:errors++
        $wsOk = $false
        continue
    }
    $text = Get-Content -Path $check.Path -Raw
    foreach ($need in $check.Need) {
        if ($text.IndexOf($need) -lt 0) {
            Write-Host "FAIL: $($check.Path) must contain '$need' (working-surface proof)"
            $script:errors++
            $wsOk = $false
        }
    }
}
if ($wsOk) {
    Write-Host "OK: Adopt/test working-surface proof (frontend + backend) in characterize, route, testing, concepts, and test"
}

if ($errors -gt 0) {
    Write-Host ""
    Write-Host "Validation failed with $errors error(s)."
    exit 1
}

Write-Host ""
Write-Host "All skills and concepts validated."
