---
name: setup
description: >-
  Workspace alignment at repository or global (user-level) scope: choose issue
  tracker (markdown, Jira, GitHub, or Linear), artifact location, and delivery
  conventions. Writes docs/agents/WORKSPACE.md, or ~/.agents/WORKSPACE.md for
  machine-wide defaults that apply to every repo without adding files to it.
  Use when onboarding a repo, setting global defaults, changing tracker, or
  before first explore/define/bug/tweak/refine/rework.
disable-model-invocation: true
---

# Setup

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md) to **workspace configuration**.
Produces a `WORKSPACE.md` all pipeline skills read first:

| Scope | Path | Use when |
|-------|------|----------|
| **repository** | `docs/agents/WORKSPACE.md` | Settings belong to this repo and collaborators |
| **global** | `~/.agents/WORKSPACE.md` | One setup for every repo; nothing added to repos |

Repository fields override global field-by-field — [format.md](format.md) → **Resolution order**.

**On invoke:** read CONCEPT_ALIGNMENT,
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md),
[format.md](format.md), and
[../tracker/reference.md](../tracker/reference.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | How the agent pipeline runs — this repo, or every repo (global) |
| **Probes** | Scope; tracker provider + provider settings; markdown mirror; artifact location (repo vs external); artifact roots; base branch / naming / PR default / merge; confirm one delivery PR per Task; invent-defaults policy (recommend: no — run setup) |
| **Stop condition** | Scope, tracker, artifact location/paths, and delivery defaults are unambiguous |
| **Alignment artifact** | `docs/agents/WORKSPACE.md` or `~/.agents/WORKSPACE.md` ([format.md](format.md)) |
| **Readiness prompt** | "Does this workspace setup look right to commit?" (repo) / "…to save as your global default?" (global) |
| **Opening** | Thin: scope then tracker. Rich / existing file: load effective workspace; ask highest-impact divergence. Global exists, repo does not: show inherited; ask only what this repo must differ |
| **Scope guard** | No feature/model/implement; no pipeline Story/Task during setup; global scope creates no repo dirs/commits |

## Steps

1. **Align** — Follow CONCEPT_ALIGNMENT with the extensions above. Done when stop condition + readiness approval hold.
2. **Write workspace** — Persist per [format.md](format.md) (repo: only fields that differ from global when a global layer exists). Done when the file exists at the agreed path.
3. **Provision paths** — Repo scope: ensure agents dir; markdown provider → issues dir + INDEX stub; mirror → ISSUES stub; external artifacts → create root outside the repo. Done when required dirs exist.
4. **Verify** — Check provider credentials ([../tracker/reference.md](../tracker/reference.md)); report path, scope, tracker, and gaps. Record outcome `ready`. No workflow is bound by setup, so **Next** is none. Commit only on ask — never commit a global workspace file. Done when the user has that report.

## Inputs

| Input | When present | When absent |
|-------|----------------|-------------|
| Existing `WORKSPACE.md` for the scope being edited | Apply it and ask only about real divergences | Align from the opening probes |
| Global workspace, when editing a repo | Show inherited fields | Align repo fields in full |

## Output

`WORKSPACE.md` — tracker, paths, and delivery defaults for the chosen scope. Outcome: `ready`.

This skill does not name a successor.

## Re-run

Updates the scope being edited; ask which when both exist. Do not delete issues;
note migrations if provider changes. Changing global does not rewrite repo overrides.
