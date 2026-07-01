---
name: manage-skills
description: >-
  Maintains the global cursor-skills repository and sync workflow. Use when
  creating a new skill, updating skills for cloud/repo availability, syncing
  skills locally, installing skills into a project, or asking how to make
  skills available globally across local IDE, cloud agents, and Cursor App.
disable-model-invocation: true
---

# Manage Global Skills

This repository is the **single source of truth** for personal Cursor skills. Skills live in `.cursor/skills/` so the repo is valid for GitHub remote install, cloud agents, and local sync.

## Where skills are discovered

| Environment | Path | How to enable |
|-------------|------|---------------|
| Local IDE (all projects) | `~/.cursor/skills/` | Run `scripts/sync-local.ps1` |
| Cloud agents | Repo `.cursor/skills/` | Commit skills or use submodule |
| Cursor App / other machines | GitHub remote install | Customize → Rules → Remote Rule (Github) |
| Single project only | `<project>/.cursor/skills/` | `scripts/install-to-project.ps1` |

**Cloud agents cannot read `~/.cursor/skills/`.** Repo-committed skills are required for cloud.

## Creating a new skill

1. Create `.cursor/skills/<skill-name>/SKILL.md` with valid frontmatter (`name` must match folder name).
2. Run `.\scripts\validate-skills.ps1`.
3. Run `.\scripts\sync-local.ps1 -Prune` to update local IDE.
4. Commit and push to GitHub.
5. If using GitHub remote install, skills update automatically on next Cursor sync.

Follow `/create-skill` conventions. Keep `SKILL.md` under 500 lines; use `references/` for detail.

## Syncing locally

```powershell
# Copy skills to ~/.cursor/skills/ (recommended on Windows)
.\scripts\sync-local.ps1 -Prune

# Live junction links (requires Developer Mode or admin)
.\scripts\sync-local.ps1 -Link -Prune
```

On macOS/Linux:

```bash
./scripts/sync-local.sh --prune
```

Run sync after every `git pull` that changes skills.

## Installing into a project (cloud + team)

**Option A — copy selected skills** (simplest):

```powershell
.\scripts\install-to-project.ps1 -ProjectPath C:\path\to\repo -All
.\scripts\install-to-project.ps1 -ProjectPath C:\path\to\repo -Skill grill-me,grill-me-and-develop
```

Then commit `.cursor/skills/` in that project.

**Option B — git submodule** (stays linked to this repo):

```powershell
.\scripts\install-to-project.ps1 -ProjectPath C:\path\to\repo -Submodule
```

Collaborators clone with `git clone --recurse-submodules`.

## GitHub remote install (Cursor App + all machines)

After pushing this repo to GitHub:

1. Open **Customize** in the Cursor sidebar.
2. Go to **Rules** → **Add Rule** → **Remote Rule (Github)**.
3. Enter the repository URL.

Skills from the linked repo are available without running sync scripts on that machine.

## Workflow checklist

When adding or editing a skill:

- [ ] Skill in `.cursor/skills/<name>/SKILL.md`
- [ ] `name` field matches folder name
- [ ] Description includes WHAT and WHEN (third person)
- [ ] `validate-skills.ps1` passes
- [ ] `sync-local.ps1 -Prune` run locally
- [ ] Committed and pushed to GitHub
- [ ] Cloud-using projects have `.cursor/skills/` committed or submodule

## Do not

- Write skills to `~/.cursor/skills-cursor/` (Cursor-managed built-ins only).
- Edit only `~/.cursor/skills/` without updating this repo (changes will be lost on next sync).
