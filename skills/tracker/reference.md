# Issue tracker contract

Logical operations used by pipeline skills. **Not a user-invoked skill.**

Provider and paths come from the **effective workspace** — the repo's
`docs/agents/WORKSPACE.md` layered over the global `~/.agents/WORKSPACE.md`
([../setup/format.md](../setup/format.md) → **Resolution order**).
Backend files implement these operations.

## Logical issue types

| Logical type | Role in pipeline |
|--------------|------------------|
| **Story** | Explore map parent — holds the route |
| **Task** | Pipeline / route owner (define → ship for define-typed route Tasks) |
| **Sub-task** | Work package under a Task |

Map these names to provider-native types in the backend file.

## Logical statuses

```text
To Do → In Progress → In Review → Done
```

Backends map to native columns/states. If a name is missing, pick the closest and note it in the issue comment / markdown mirror.

## Operations

Every backend must support:

| Op | Purpose |
|----|---------|
| `fetch(key)` | Load summary, description, status, type, parent, children, links |
| `create(type, fields)` | Create Story / Task / Sub-task; return key + url |
| `update(key, fields)` | Update description / title / links to artifacts |
| `comment(key, markdown)` | Add a comment (or append a Comments section in markdown) |
| `transition(key, status)` | Move to a logical status |
| `link(parent, child, kind)` | Parent/child or relates |
| `attach_or_link(key, path)` | Attach file or record repo path + SHA in description |

## Keys on dev-surfaces

Handoffs and other **dev-surfaces** always use the provider's issue key:

```markdown
## Next
`/define <KEY>` — …
```

Examples: `MD-2`, `PROJ-124`, `#42`, `ENG-123`.

**Product surfaces** → [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) **Dev-surface keys**.

## Markdown continuity (all providers)

When `WORKSPACE.md` has **Mirror to markdown: true**:

1. Upsert a row in the mirror file (`docs/agents/ISSUES.md` by default):

```markdown
| Key | Type | Title | Status | Parent | Artifact | Next |
|-----|------|-------|--------|--------|----------|------|
| MD-2 | Task | Forecast chart | In Progress | MD-1 | PLAN.md | `/review MD-2` |
```

2. Append a short dated log line under `## Log` when status or Next changes.
3. Do this in addition to remote API updates — never instead of them (except provider `markdown`, where files are the system of record).

## Loading workspace

At the start of explore / bug / tweak / research / model / define / implement / review / review-fix / ship / summarise:

1. Resolve the **effective workspace** per [../setup/format.md](../setup/format.md):
   `$AGENT_WORKSPACE_FILE` → repo `docs/agents/WORKSPACE.md` → global
   `~/.agents/WORKSPACE.md` (or `$XDG_CONFIG_HOME/agents/`, `~/.copilot/`,
   `~/.claude/`, `~/.codex/`, `~/.cursor/`). Repo fields override global fields
   unless the repo sets `Extends global: false`. If neither resolves, ask once → `/setup`.
2. Read **Provider** and provider settings.
3. Load this contract + the provider backend.
4. Prefer artifact paths from the effective workspace over hardcoded roots, and
   honour **Artifact location** (`repo` vs `external`).

## Artifact linkage

`attach_or_link(key, path)` depends on **Artifact location**:

| Location | Record on the issue |
|----------|---------------------|
| `repo` | Repo-relative path + commit SHA (and PR link once open) |
| `external` | Absolute path **plus the artifact's full content** in the issue description or a comment — the issue is the durable, shareable copy; there is no SHA |

With `external`, never cite a repo-relative artifact path in a handoff, PR body,
or issue: it does not exist in the repo and will mislead reviewers.

## Close semantics

`transition(key, Done)` must fully close the issue in the provider:

| Provider | Done means |
|----------|------------|
| markdown | Status field = `Done` (+ INDEX) |
| jira | Workflow transition to Done |
| github | `gh issue close` (completed) + drop in-progress/in-review labels |
| linear | State = Done |

Ship is responsible for Done on Sub-tasks, Task, and Story-when-complete — see
[../workflow/ship.md](../workflow/ship.md#closeout).

## Credentials

Never commit secrets. Use env vars or host auth (e.g. `gh auth`, Linear MCP).
If required auth is missing, stop with setup instructions for that backend.
