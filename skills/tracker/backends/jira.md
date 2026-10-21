# Backend: jira

Jira Cloud/Server via REST. Detailed curl patterns live in
[../../jira/reference.md](../../jira/reference.md).

Status and type names in this file are the fallback. An active ticket framework
([../../workflow/inject.md](../../workflow/inject.md)) replaces them. With no
framework, `docs/agents/jira.md` still overrides this file for project-specific
issue types and transitions.

## Prerequisites

From `WORKSPACE.md` + env:

| Source | Fields |
|--------|--------|
| WORKSPACE | Site URL, project key |
| Env | `JIRA_EMAIL`, `JIRA_API_TOKEN` (and `JIRA_BASE_URL` / `JIRA_PROJECT_KEY` if not in WORKSPACE) |

Stop if auth is missing.

## Type mapping

| Logical | Jira (default) |
|---------|----------------|
| Story | Story |
| Task | Task |
| Sub-task | Sub-task |

## Status mapping

Fallback when no ticket framework is active.

| Logical | Jira (match by name) |
|---------|----------------------|
| To Do | To Do / Backlog |
| In Progress | In Progress |
| In Review | In Review |
| Done | Done |

Discover transition IDs per [../../jira/reference.md](../../jira/reference.md).

## Operations

Implement contract ops using the Jira reference (create, comment, transition,
fetch, issueLink, attachment).

Always:

1. Perform the Jira API call.
2. If mirror enabled, upsert `docs/agents/ISSUES.md`.
3. Put keys + URLs into `ROADMAP.md` / `PLAN.md` / `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ADOPT.md` / `ITERATE.md` as applicable.

## Keys

Native keys (`PROJ-123`). Handoffs use that key unchanged.
