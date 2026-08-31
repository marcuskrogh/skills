# Workspace

Agreed agent workspace setup.

## Scope

| Field | Value |
|-------|-------|
| Scope | repository |
| Extends global | true |

## Issue tracker

| Field | Value |
|-------|-------|
| Provider | markdown |
| Mirror to markdown | true |
| Mirror path | docs/agents/ISSUES.md |

### Provider settings

#### markdown

| Field | Value |
|-------|-------|
| Issues dir | docs/agents/issues |
| Key prefix | MD |
| Index | docs/agents/issues/INDEX.md |

## Artifacts

| Field | Value |
|-------|-------|
| Location | repo |
| Commit artifacts | true |

| Artifact | Path |
|----------|------|
| Agents dir | docs/agents |
| Workspace | docs/agents/WORKSPACE.md |
| Continuity mirror | docs/agents/ISSUES.md |
| Roadmap | docs/agents/ROADMAP.md |
| Plan | docs/agents/PLAN.md |
| Bug | docs/agents/BUG.md |
| Tweak | docs/agents/TWEAK.md |
| Refine | docs/agents/REFINE.md |
| Adopt | docs/agents/ADOPT.md |
| Rework | docs/agents/REWORK.md |
| Iterate | docs/agents/ITERATE.md |
| Model | docs/agents/MODEL.md |
| Research | docs/agents/RESEARCH.md |
| Sandbox | docs/agents/SANDBOX.md |
| Architecture | docs/agents/ARCHITECTURE.md |
| Sandbox root | sandbox/ |
| Changelog | CHANGELOG.md |

## Delivery

| Field | Value |
|-------|-------|
| Base branch | main |
| Branch pattern | `<key-lowercase>-<short-description>` |
| Open PR by default | true |
| Merge strategy | squash |
| Require `gh` for review/ship | true |
| One delivery PR per Task | true |

## Language

| Field | Value |
|-------|-------|
| Agent language | general |

## Pipeline

| Field | Value |
|-------|-------|
| Skills | Prefer [workflows](../../skills/workflows/SKILL.md) catalog; continuity in [workflow/reference.md](../../skills/workflow/reference.md) |
| One-issue continuity | true |
| One delivery branch/PR per Task | true |
| Tracker backend | markdown (`skills/tracker`) |

## Notes

- All pipeline artifacts live under `docs/agents/` so the repo root stays clean.
- At **ship**, delete this Task's roadmap, plan, and issue files (`ROADMAP.md`, `PLAN.md`, `docs/agents/issues/MD-*.md` for the closed Task/Story, and stale mirror rows). Keep `WORKSPACE.md` as standing setup.
- Do not leave delivery scaffolding on `main`.
