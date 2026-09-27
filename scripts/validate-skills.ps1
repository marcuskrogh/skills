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
            'grok-4.7-high',
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
    foreach ($langNeed in @('CONCEPT_LANGUAGE', 'LANGUAGE-PHRASES', 'LANGUAGE-HUMANIZER', 'GeneralProcessSimulator', 'harness')) {
        if ($pointerText.IndexOf($langNeed) -lt 0) {
            Write-Host "FAIL: $pf must contain '$langNeed' (always-on language extract)"
            $script:errors++
            $pointerOk = $false
        }
    }
    if ($pointerText.IndexOf('CONCEPT_LANGUAGE') -ge 0 -and $pointerText.IndexOf('LANGUAGE-PHRASES') -ge 0 -and $pointerText.IndexOf('LANGUAGE-HUMANIZER') -ge 0) {
        Write-Host "OK: $pf names CONCEPT_LANGUAGE, LANGUAGE-PHRASES, and LANGUAGE-HUMANIZER"
    }
    foreach ($closeNeed in @('## Next', 'does not approve the plan')) {
        if ($pointerText.IndexOf($closeNeed) -lt 0) {
            Write-Host "FAIL: $pf must contain '$closeNeed' (alignment interview + Next close)"
            $script:errors++
        }
    }
    if ($pointerText.IndexOf('## Next') -ge 0 -and $pointerText.IndexOf('does not approve the plan') -ge 0) {
        Write-Host "OK: $pf keeps the alignment interview and ## Next close"
    }
}

$alignmentConcept = Join-Path $ConceptsDir "CONCEPT_ALIGNMENT.md"
if (-not (Test-Path $alignmentConcept)) {
    Write-Host "FAIL: Missing CONCEPT_ALIGNMENT.md"
    $script:errors++
} else {
    $alignmentText = Get-Content -Path $alignmentConcept -Raw
    foreach ($need in @('Shallow stays open', 'Opening names the subject', 'First turn waits', 'Close with the user')) {
        if ($alignmentText.IndexOf($need) -lt 0) {
            Write-Host "FAIL: CONCEPT_ALIGNMENT.md must contain '$need'"
            $script:errors++
        }
    }
    if ($alignmentText.IndexOf('on invoke') -ge 0 -and $alignmentText -match 'Rich \(user already answered') {
        Write-Host "FAIL: CONCEPT_ALIGNMENT.md still treats the invoke as a rich answer"
        $script:errors++
    } else {
        Write-Host "OK: CONCEPT_ALIGNMENT.md keeps shallow openings open"
    }
}

$definitionConcept = Join-Path $ConceptsDir "CONCEPT_DEFINITION.md"
if (Test-Path $definitionConcept) {
    $definitionText = Get-Content -Path $definitionConcept -Raw
    if ($definitionText.IndexOf('confirm gaps only when already implementation-ready') -ge 0) {
        Write-Host "FAIL: CONCEPT_DEFINITION.md still treats a description as implementation-ready"
        $script:errors++
    } elseif ($definitionText.IndexOf('A short opening is not implementation-ready') -lt 0) {
        Write-Host "FAIL: CONCEPT_DEFINITION.md must say a short opening is not implementation-ready"
        $script:errors++
    } else {
        Write-Host "OK: CONCEPT_DEFINITION.md refuses a short opening as implementation-ready"
    }
}

$handoffRef = Join-Path $RepoRoot (Join-Path "skills" (Join-Path "workflow" "handoff.md"))
if (-not (Test-Path $handoffRef)) {
    Write-Host "FAIL: Missing workflow/handoff.md"
    $script:errors++
} else {
    $handoffText = Get-Content -Path $handoffRef -Raw
    foreach ($need in @('## Reply close', 'open alignment', '## Next')) {
        if ($handoffText.IndexOf($need) -lt 0) {
            Write-Host "FAIL: workflow/handoff.md must contain '$need'"
            $script:errors++
        }
    }
    if ($handoffText.IndexOf('## Reply close') -ge 0) {
        Write-Host "OK: workflow/handoff.md requires the Next reply close"
    }
}

$workflowsSkill = Join-Path $RepoRoot (Join-Path "skills" (Join-Path "workflows" "SKILL.md"))
if (Test-Path $workflowsSkill) {
    $workflowsText = Get-Content -Path $workflowsSkill -Raw
    foreach ($need in @('does not approve the plan', '## Next', 'Interview before build')) {
        if ($workflowsText.IndexOf($need) -lt 0) {
            Write-Host "FAIL: workflows/SKILL.md must contain '$need'"
            $script:errors++
        }
    }
    if ($workflowsText.IndexOf('no remaining definition forks') -ge 0) {
        Write-Host "FAIL: workflows/SKILL.md still allows skipping alignment when no forks are declared"
        $script:errors++
    }
}

$defineSkill = Join-Path $RepoRoot (Join-Path "skills" (Join-Path "define" "SKILL.md"))
if (Test-Path $defineSkill) {
    $defineText = Get-Content -Path $defineSkill -Raw
    if ($defineText.IndexOf('no remaining definition forks') -ge 0) {
        Write-Host "FAIL: define/SKILL.md still skips alignment when no forks are declared"
        $script:errors++
    } elseif ($defineText.IndexOf('does not approve the plan') -lt 0) {
        Write-Host "FAIL: define/SKILL.md description must say a short description does not approve the plan"
        $script:errors++
    } else {
        Write-Host "OK: define/SKILL.md interviews before the plan is approved"
    }
}

$installScript = Join-Path $RepoRoot (Join-Path "scripts" "install-from-git.sh")
if (Test-Path $installScript) {
    $installText = Get-Content -Path $installScript -Raw
    foreach ($need in @('## Next', 'does not approve the plan')) {
        if ($installText.IndexOf($need) -lt 0) {
            Write-Host "FAIL: scripts/install-from-git.sh fallback must contain '$need'"
            $script:errors++
        }
    }
}

$phrasesRef = Join-Path $ConceptsDir "LANGUAGE-PHRASES.md"
if (-not (Test-Path $phrasesRef)) {
    Write-Host "FAIL: Missing language phrase catalog: $phrasesRef"
    $script:errors++
} else {
    Write-Host "OK: LANGUAGE-PHRASES.md"
}

$humanizerRef = Join-Path $ConceptsDir "LANGUAGE-HUMANIZER.md"
if (-not (Test-Path $humanizerRef)) {
    Write-Host "FAIL: Missing language humanizer catalog: $humanizerRef"
    $script:errors++
} else {
    Write-Host "OK: LANGUAGE-HUMANIZER.md"
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
    foreach ($langNeed in @('CONCEPT_LANGUAGE', 'LANGUAGE-PHRASES', 'LANGUAGE-HUMANIZER', 'GeneralProcessSimulator', 'harness')) {
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

function Test-FileContains {
    param([string]$Path, [string]$Needle, [string]$Label)
    if (-not (Test-Path $Path)) {
        Write-Host "FAIL: Missing $Path"
        $script:errors++
        return
    }
    $text = Get-Content -Path $Path -Raw
    if ($text.IndexOf($Needle) -lt 0) {
        Write-Host "FAIL: $Label"
        $script:errors++
    } else {
        Write-Host "OK: $Label"
    }
}

function Get-HeadingSlice {
    param(
        [string]$Text,
        [string]$StartHeading,
        [string]$EndHeading,
        [string]$Fallback,
        [ValidateSet('Fallback', 'FromStart')]
        [string]$OnMissingEnd = 'Fallback'
    )
    $start = $Text.IndexOf($StartHeading)
    if ($start -lt 0) { return $Fallback }
    if ([string]::IsNullOrEmpty($EndHeading)) {
        return $Text.Substring($start)
    }
    $end = $Text.IndexOf($EndHeading)
    if ($end -gt $start) {
        return $Text.Substring($start, $end - $start)
    }
    if ($OnMissingEnd -eq 'FromStart') {
        return $Text.Substring($start)
    }
    return $Fallback
}

function Test-SectionLists {
    param(
        [string]$Section,
        [string]$FailPrefix,
        [string]$OkPrefix,
        [string[]]$Needles
    )
    foreach ($need in $Needles) {
        if ($Section.IndexOf($need) -lt 0) {
            Write-Host "FAIL: $FailPrefix$need"
            $script:errors++
        } else {
            Write-Host "OK: $OkPrefix$need"
        }
    }
}

function Get-LockedGeneralRows {
    return @(
        @{ Prefer = 'glm-5.3'; StaleSlug = 'glm-5.2'; StaleDisplay = '| GLM-5.2 |' },
        @{ Prefer = 'gemini-3.8-flash'; StaleSlug = 'gemini-3.6-flash'; StaleDisplay = '| Gemini 3.6 Flash |' },
        @{ Prefer = 'qwen3.8-max'; StaleSlug = 'qwen3-coder'; StaleDisplay = '| Qwen3-Coder |' },
        @{ Prefer = 'muse-spark-1.3'; StaleSlug = 'llama-4-maverick'; StaleDisplay = '| Llama 4 Maverick |' }
    )
}

function Test-GeneralLockedRows {
    param([string]$PlatformsDir)

    $generalPlatform = Join-Path $PlatformsDir "general.md"
    $rows = Get-LockedGeneralRows
    foreach ($row in $rows) {
        $wrapped = '`' + $row.Prefer + '`'
        Test-FileContains -Path $generalPlatform -Needle $wrapped -Label "general.md prefer slug $($row.Prefer)"
    }
    if (Test-Path $generalPlatform) {
        $generalText = Get-Content -Path $generalPlatform -Raw
        foreach ($row in $rows) {
            if ($generalText.IndexOf($row.StaleDisplay) -ge 0) {
                Write-Host "FAIL: general.md still prefers stale row $($row.StaleDisplay)"
                $script:errors++
            } else {
                Write-Host "OK: general.md does not prefer stale row $($row.StaleDisplay)"
            }
        }
    }
}

function Test-ClaudeCodeCatalog {
    param([string]$ClaudePlatform)

    Test-FileContains -Path $ClaudePlatform -Needle '`claude-opus-5-5`' -Label "claude-code.md prefer claude-opus-5-5"
    Test-FileContains -Path $ClaudePlatform -Needle '`opus`' -Label "claude-code.md prefer alias opus"
    Test-FileContains -Path $ClaudePlatform -Needle '`claude-opus-5`' -Label "claude-code.md fallback claude-opus-5"
    Test-FileContains -Path $ClaudePlatform -Needle 'fable' -Label "claude-code.md forbids fable"
    Test-FileContains -Path $ClaudePlatform -Needle 'haiku' -Label "claude-code.md forbids haiku"
    if (Test-Path $ClaudePlatform) {
        $claudeText = Get-Content -Path $ClaudePlatform -Raw
        $claudeTables = Get-HeadingSlice -Text $claudeText -StartHeading '## High-capability' -EndHeading '' -Fallback ''
        foreach ($bannedName in @('fable', 'haiku')) {
            if ($claudeTables.IndexOf($bannedName) -ge 0) {
                Write-Host "FAIL: claude-code.md capability tables must not list $bannedName"
                $script:errors++
            } else {
                Write-Host "OK: claude-code.md capability tables omit $bannedName"
            }
        }
    }
}

function Test-CopilotCatalog {
    param([string]$CopilotPlatform)

    if (-not (Test-Path $CopilotPlatform)) { return }
    $copilotText = Get-Content -Path $CopilotPlatform -Raw
    $highPart = Get-HeadingSlice -Text $copilotText -StartHeading '## High-capability' -EndHeading '## Mid-capability' -Fallback '' -OnMissingEnd FromStart
    Test-SectionLists -Section $highPart -FailPrefix 'github-copilot.md high section must list ' -OkPrefix 'github-copilot.md high lists ' -Needles @('Grok 4.7', 'GPT-6 Sol', 'Claude Opus 5.5')
    $midPart = Get-HeadingSlice -Text $copilotText -StartHeading '## Mid-capability' -EndHeading '## Low-capability' -Fallback ''
    Test-SectionLists -Section $midPart -FailPrefix 'github-copilot.md mid section must list ' -OkPrefix 'github-copilot.md mid lists ' -Needles @('GPT-5.6 Terra', 'Claude Sonnet 5')
    $lowPart = Get-HeadingSlice -Text $copilotText -StartHeading '## Low-capability' -EndHeading '' -Fallback ''
    if ($lowPart.IndexOf('GPT-6 Luna') -lt 0) {
        Write-Host "FAIL: github-copilot.md low section must list GPT-6 Luna"
        $script:errors++
    } else {
        Write-Host "OK: github-copilot.md low lists GPT-6 Luna"
    }
}

function Test-CodexCatalog {
    param([string]$CodexPlatform)

    if (-not (Test-Path $CodexPlatform)) { return }
    $codexText = Get-Content -Path $CodexPlatform -Raw
    $midPart = Get-HeadingSlice -Text $codexText -StartHeading '## Mid-capability' -EndHeading '## Low-capability' -Fallback ''
    if ($midPart.IndexOf('gpt-5.6-terra') -lt 0) {
        Write-Host "FAIL: codex.md mid prefer must stay gpt-5.6-terra"
        $script:errors++
    } else {
        Write-Host "OK: codex.md mid prefer stays gpt-5.6-terra"
    }
}

function Test-BannedPlatformSlugs {
    param([string]$PlatformsDir)

    $bannedHits = 0
    foreach ($plat in (Get-ChildItem -Path $PlatformsDir -Filter "*.md")) {
        $platText = Get-Content -Path $plat.FullName -Raw
        foreach ($banned in @('gpt-6-terra', 'sonnet-5-5', 'haiku-5-5', 'claude-sonnet-5-5', 'claude-haiku-5')) {
            if ($platText.IndexOf($banned) -ge 0) {
                Write-Host "FAIL: $($plat.Name) invents banned slug $banned"
                $script:errors++
                $bannedHits++
            }
        }
    }
    if ($bannedHits -eq 0) {
        Write-Host "OK: platform files do not invent gpt-6-terra, Sonnet 5.5, or Haiku 5.5"
    }
}

function Test-StalePreferSlugs {
    param([string[]]$Roots)

    $stalePreferHits = 0
    foreach ($root in $Roots) {
        if (-not (Test-Path $root)) { continue }
        foreach ($conceptFile in (Get-ChildItem -Path $root -Recurse -File | Where-Object { $_.Extension -in '.md', '.ps1', '.sh' })) {
            $lineNo = 0
            foreach ($line in (Get-Content -Path $conceptFile.FullName)) {
                $lineNo++
                foreach ($row in (Get-LockedGeneralRows)) {
                    if ($line.IndexOf($row.StaleSlug) -ge 0 -and $line.IndexOf($row.Prefer) -lt 0) {
                        Write-Host "FAIL: $($conceptFile.FullName):$lineNo uses $($row.StaleSlug) outside a $($row.Prefer) fallback"
                        $script:errors++
                        $stalePreferHits++
                    }
                }
            }
        }
    }
    if ($stalePreferHits -eq 0) {
        Write-Host "OK: concept markdown keeps stale prefer slugs only beside their replacements"
    }
}

# Locked 2026-09-27 prefer slugs. Checks are written from the plan pass criteria.
$platformsDir = Join-Path $ConceptsDir "platforms"
Test-GeneralLockedRows -PlatformsDir $platformsDir
Test-ClaudeCodeCatalog -ClaudePlatform (Join-Path $platformsDir "claude-code.md")
Test-CopilotCatalog -CopilotPlatform (Join-Path $platformsDir "github-copilot.md")
Test-CodexCatalog -CodexPlatform (Join-Path $platformsDir "codex.md")
Test-BannedPlatformSlugs -PlatformsDir $platformsDir
Test-StalePreferSlugs -Roots @($ConceptsDir, (Join-Path $RepoRoot "scripts"))

$pipelineTest = Join-Path $RepoRoot (Join-Path "scripts" "test_pipelines.py")
if (-not (Test-Path $pipelineTest)) {
    Write-Host "FAIL: Missing pipeline independence test: $pipelineTest"
    $script:errors++
} else {
    $python = $null
    foreach ($candidate in @("python3", "python")) {
        if (Get-Command $candidate -ErrorAction SilentlyContinue) {
            $python = $candidate
            break
        }
    }
    if (-not $python) {
        Write-Host "FAIL: python3 is required to run scripts/test_pipelines.py"
        $script:errors++
    } else {
        & $python $pipelineTest
        if ($LASTEXITCODE -ne 0) {
            Write-Host "FAIL: pipeline independence checks failed"
            $script:errors++
        } else {
            Write-Host "OK: pipeline independence checks"
        }
    }
}

if ($errors -gt 0) {
    Write-Host ""
    Write-Host "Validation failed with $errors error(s)."
    exit 1
}

Write-Host ""
Write-Host "All skills and concepts validated."
