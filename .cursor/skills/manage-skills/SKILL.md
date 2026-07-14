---
name: manage-skills
description: >-
  Maintains the global cursor-skills repository and Cursor sync workflow. Use when
  creating a new skill, syncing skills locally, installing skills into a project
  for cloud agents, or asking how to make skills available globally in Cursor.
disable-model-invocation: true
---

# Manage Global Skills (Cursor)

This repository is the **single source of truth** for your Cursor skills.

## Three ways Cursor finds your skills

| Where you work | How skills load | Setup |
|----------------|-----------------|-------|
| **This machine, any project** | `~/.cursor/skills/` | `.\scripts\setup-cursor.ps1` |
| **Cursor App / other machines** | GitHub remote rule | Customize → Remote Rule (Github) |
| **Cloud agents on a repo** | `.cursor/skills/` at VM startup | `setup-cloud-agent.ps1` |

## First-time setup (this machine)

```powershell
cd D:\code\cursor-skills
.\scripts\setup-cursor.ps1
```

Then in Cursor: **Customize → Skills** — confirm `explore`, `design`, `model`, `implement`, `manage-skills`, etc. appear.

## First-time setup (Cursor App / other machines)

1. **Customize → Rules → Add Rule → Remote Rule (Github)**
2. URL: `https://github.com/marcuskrogh/cursor-skills`

No sync script needed on that device.

## Base vs derived skills

| Kind | Location | Purpose |
|------|----------|---------|
| **Base** | `.cursor/skills/base/<design>/` | Design specification; `disable-model-invocation: true`; not user-invoked |
| **Derived** | `.cursor/skills/<name>/` | Standalone user-invokable skill; composes one base design |

### Base designs

| Base | Composed by |
|------|-------------|
| `alignment` | `explore`, `design`, `model` |
| `implementation` | `implement` |

Derived skills are **standalone** — they do not chain or reference other skills. Combined workflows will be defined in a separate format later.

### Jira

Skills `explore`, `design`, `model`, `implement`, and `code-review` integrate with Jira via [jira/reference.md](../jira/reference.md). Set `JIRA_BASE_URL`, `JIRA_EMAIL`, `JIRA_API_TOKEN`, and `JIRA_PROJECT_KEY` in the environment.

## Creating a new skill

1. Add `.cursor/skills/<name>/SKILL.md` (`name` must match folder name). Base designs go under `.cursor/skills/base/<name>/`.
2. `.\scripts\validate-skills.ps1`
3. `git add . && git commit -m "Add <name> skill" && git push`
4. `.\scripts\sync-local.ps1 -Prune` (or rely on git hook after pull)

## Cloud agents on a specific project

Fetch skills at cloud VM startup (no skill files in project git):

```powershell
.\scripts\setup-cloud-agent.ps1 -ProjectPath C:\path\to\repo
```

Merge `bash .cursor/sync-cursor-skills.sh` into an existing `.cursor/environment.json` `install` if the project already has cloud setup.

## Rules

- **Edit skills in this repo only** — not directly in `~/.cursor/skills/`.
- **Never write to `~/.cursor/skills-cursor/`** — Cursor built-ins only.
