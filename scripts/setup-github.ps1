# First-time GitHub push helper for skills.
# Usage: .\scripts\setup-github.ps1

$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $RepoRoot

$remoteUrl = "https://github.com/marcuskrogh/skills.git"

if (-not (git rev-parse --is-inside-work-tree 2>$null)) {
    Write-Error "Not a git repository: $RepoRoot"
}

if ((git branch --show-current) -ne "main") {
    git branch -M main
}

if (-not (git remote get-url origin 2>$null)) {
    git remote add origin $remoteUrl
}

if (-not (git rev-parse HEAD 2>$null)) {
    git add .
    git commit -m "Initialize global skills repository"
}

git fetch origin
$remoteBranch = if (git rev-parse --verify origin/main 2>$null) { "main" }
                elseif (git rev-parse --verify origin/master 2>$null) { git branch -M master; "master" }
                else { "main" }

$remoteHead = git rev-parse "origin/$remoteBranch" 2>$null
if ($remoteHead -and (git rev-parse HEAD) -ne $remoteHead) {
    if (-not (git merge-base HEAD "origin/$remoteBranch" 2>$null)) {
        git pull origin $remoteBranch --allow-unrelated-histories --no-edit
    } else {
        git pull --rebase origin $remoteBranch
    }
}

git push -u origin $remoteBranch
Write-Host "Done. Remote: $remoteUrl"
