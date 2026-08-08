# WORKSPACE.md format

Canonical workspace setup artifact for pipeline skills. It exists in two scopes:

| Scope | Path | Applies to |
|-------|------|------------|
| **repository** | `docs/agents/WORKSPACE.md` (default) | That repo only; committed with it |
| **global** | `~/.agents/WORKSPACE.md` | Every repo on this machine; never committed |

If neither exists, pipeline skills **stop** and ask the user to run `/setup`
(unless the user explicitly says to proceed with defaults — then use the
**Defaults** section below and still write a workspace file before creating issues).

## Resolution order

Resolve the **effective** workspace before any tracker or artifact operation:

1. `$AGENT_WORKSPACE_FILE` — explicit path override; when set it is the whole
   effective workspace and no layering happens.
2. Otherwise merge two layers, **repository over global**:
   - **Repository layer:** `docs/agents/WORKSPACE.md` in the repo root.
   - **Global layer**, first match wins:
     - `~/.agents/WORKSPACE.md` (canonical, harness-agnostic)
     - `$XDG_CONFIG_HOME/agents/WORKSPACE.md`
     - harness homes: `~/.copilot/WORKSPACE.md`, `~/.claude/WORKSPACE.md`, `~/.codex/WORKSPACE.md`, `~/.cursor/WORKSPACE.md`
3. Neither layer found → ask the user to run `/setup`.

Either layer alone is sufficient: a global file with no repo file is a complete,
valid setup, and vice versa.

### Merge semantics

The global layer supplies **defaults**; the repository layer **overrides them
field by field** (not file-wholesale). A repo that sets only `Provider` still
inherits global artifact and delivery settings.

- A repo file with `Extends global: false` is used alone — no inheritance.
- Never write global values back into a repo file just to be explicit.
- When both layers are present, report which fields came from where if the user asks.
- The global file is **never** committed, staged, or added to a repo — including
  when a skill offers to commit workspace setup.

## Template

```markdown
# Workspace

Agreed agent workspace setup.

## Scope

| Field | Value |
|-------|-------|
| Scope | repository \| global |
| Extends global | true \| false (repository scope only; default true) |

## Issue tracker

| Field | Value |
|-------|-------|
| Provider | markdown \| jira \| github \| linear |
| Mirror to markdown | true \| false |
| Mirror path | docs/agents/ISSUES.md |

### Provider settings

<!-- Include only the block for the chosen provider -->

#### markdown
| Field | Value |
|-------|-------|
| Issues dir | docs/agents/issues |
| Key prefix | MD |
| Index | docs/agents/issues/INDEX.md |

#### jira
| Field | Value |
|-------|-------|
| Site | https://example.atlassian.net |
| Project key | PROJ |
| Auth | env (JIRA_EMAIL + JIRA_API_TOKEN) |
| Override file | docs/agents/jira.md (optional) |

#### github
| Field | Value |
|-------|-------|
| Repo | owner/name (default: current `gh` repo) |
| Labels | story, task, subtask (create if missing) |

#### linear
| Field | Value |
|-------|-------|
| Team key | ENG |
| API | Linear MCP or LINEAR_API_KEY |
| Project | optional project name/id |

## Artifacts

| Field | Value |
|-------|-------|
| Location | repo \| external |
| External artifact root | `~/.agents/artifacts/<repo>` (Location = external) |
| Commit artifacts | true \| false |

| Artifact | Path |
|----------|------|
| Agents dir | docs/agents |
| Workspace | docs/agents/WORKSPACE.md |
| Continuity mirror | docs/agents/ISSUES.md |
| Roadmap | ROADMAP.md |
| Plan | PLAN.md |
| Bug | BUG.md |
| Tweak | TWEAK.md |
| Refine | REFINE.md |
| Iterate | ITERATE.md |
| Model | MODEL.md |
| Research | RESEARCH.md |
| Changelog | CHANGELOG.md (optional; auto-detect when empty) |

Artifact paths are relative to the repo root when **Location** is `repo`, and to
the **External artifact root** when it is `external`.

Plans and models may use a subdirectory (e.g. `docs/plans/<slug>.md`) if agreed;
record the convention here.

### External artifacts

When **Location** is `external`, no pipeline artifact is written into the repo:

1. Resolve the root, expanding `<repo>` to the repository name (e.g.
   `~/.agents/artifacts/asgard/PLAN.md`). Create it if missing.
2. Write the artifact there and **push its full content into the tracker issue**
   (description for the owning artifact, comment for updates) so it is shareable
   and survives the local machine. The issue is the durable copy.
3. Reference artifacts in handoffs by absolute path **and** issue key — never by a
   repo-relative path that does not exist.
4. Skip commit/SHA recording; record `synced_at` + issue key instead. Never stage
   or `.gitignore` external artifacts — they are outside the repo.
5. `Commit artifacts` is ignored (forced `false`) when Location is `external`.

## Delivery

| Field | Value |
|-------|-------|
| Base branch | main |
| Branch pattern | `<key-lowercase>-<short-description>` |
| Open PR by default | true |
| Merge strategy | merge \| squash \| rebase |
| Require `gh` for review/ship | true |
| One delivery PR per Task | true (define→ship closed-loop; reuse branch/PR on Next) |

## Pipeline

| Field | Value |
|-------|-------|
| Skills | Prefer [workflows](../workflows/SKILL.md) catalog; continuity in [workflow/reference.md](../workflow/reference.md) |
| One-issue continuity | true |
| One delivery branch/PR per Task | true |
| Tracker backend | resolved via provider above (`skills/tracker` when installed) |

## Notes

- …
```

## Defaults (only if user opts out of full setup)

| Field | Default |
|-------|---------|
| Provider | `markdown` |
| Scope | `repository` |
| Extends global | `true` |
| Artifact location | `repo` |
| Issues dir | `docs/agents/issues` |
| Key prefix | `MD` |
| Mirror | `true` |
| Mirror path | `docs/agents/ISSUES.md` |
| Roadmap / Plan / Bug / Tweak / Refine / Iterate / Model | repo root `ROADMAP.md`, `PLAN.md`, `BUG.md`, `TWEAK.md`, `REFINE.md`, `ITERATE.md`, `MODEL.md` |
| Base branch | `main` |
| Open PR | `true` |
| One delivery PR per Task | `true` |
| Merge | `squash` if repo uses squash; else `merge` |

## Continuity rule

Regardless of remote tracker, when **Mirror to markdown** is true (recommended):

1. Create/update rows in the mirror file whenever issues are created, transitioned, or handed off.
2. Always write keys + **Next** into `ROADMAP.md` / `PLAN.md` / `BUG.md` / `TWEAK.md` / `REFINE.md` / `ITERATE.md` / issue bodies.
3. Remote tracker remains authoritative for status **except** for `markdown` provider, where issue files are authoritative.

When **Mirror to markdown** is false, the remote tracker is the *only* continuity
store: every key, status change, artifact, and **Next** must be written into the
issue itself (description or comment) before the skill ends. Do not rely on chat
or on a local file the user has not agreed to.

## Global-scope constraints

A workspace file with `Scope: global` describes machine-wide defaults, so:

- **Mirror path**, **Agents dir**, and issue dirs are only meaningful for repos
  that opt into them; keep them as defaults, do not create the directories eagerly.
- Provider `markdown` is a poor global default (issue files are repo-local) —
  prefer a remote provider globally, or set scope to repository.
- `Base branch` is a fallback only: always prefer the repo's actual default branch
  when it differs.
- Never offer to commit a global workspace file, and never copy it into a repo.
