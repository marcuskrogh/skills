---
name: setup
description: >-
  Workspace alignment at repository or global (user-level) scope: choose issue
  tracker (markdown, Jira, GitHub, or Linear), artifact location, and delivery
  conventions. Writes docs/agents/WORKSPACE.md, or ~/.agents/WORKSPACE.md for
  machine-wide defaults that apply to every repo without adding files to it.
  Use when onboarding a repo, setting global defaults, changing tracker, or
  before first explore/define.
disable-model-invocation: true
---

# Setup

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) to **workspace
configuration**. Produces a `WORKSPACE.md` all pipeline skills read first:

| Scope | Path | Use when |
|-------|------|----------|
| **repository** | `docs/agents/WORKSPACE.md` | Settings belong to this repo and collaborators |
| **global** | `~/.agents/WORKSPACE.md` | One setup for every repo; nothing added to repos |

Repository fields override global field-by-field — [format.md](format.md) → **Resolution order**.

**On invoke:** read CONCEPT_ALIGNMENT, [format.md](format.md), and
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

## After approval

1. Write workspace file per [format.md](format.md) (repo: only fields that differ from global when a global layer exists).
2. Repo scope: ensure agents dir; markdown provider → issues dir + INDEX stub; mirror → ISSUES stub; external artifacts → create root (never in repo / `.gitignore`).
3. Commit only on ask — **never** commit a global workspace file; report its path.
4. Verify provider credentials ([../tracker/reference.md](../tracker/reference.md)); report gaps.
5. Report path, scope, tracker + **Next** (`/explore`, `/bug`, or none).

## Re-run

Updates the scope being edited; ask which when both exist. Do not delete issues;
note migrations if provider changes. Changing global does not rewrite repo overrides.
