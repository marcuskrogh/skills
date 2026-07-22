# Backend: linear

Linear issues via **Linear MCP** when authenticated, otherwise Linear GraphQL API
with `LINEAR_API_KEY`.

## Prerequisites

From `WORKSPACE.md` + auth:

| Source | Fields |
|--------|--------|
| WORKSPACE | Team key, optional project |
| Auth | Linear MCP session, or env `LINEAR_API_KEY` |

If MCP is unavailable and no API key, stop with setup instructions.

## Type mapping

| Logical | Linear |
|---------|--------|
| Story | Issue with title prefix `[Story]` or label `story` (prefer label if team uses labels) |
| Task | Standard issue |
| Sub-task | Sub-issue under the Task when API supports parentId; else checklist in parent + linked issues |

Prefer native parent/sub-issue relations when the team uses them.

## Status mapping

Map logical statuses to team workflow states by name:

| Logical | Prefer state named |
|---------|-------------------|
| To Do | Todo / Backlog |
| In Progress | In Progress |
| In Review | In Review |
| Done | Done / Canceled only if user says cancel — else Done |

List team states first if names differ.

## Operations

| Op | How |
|----|-----|
| `fetch` | MCP get-issue / GraphQL `issue(id:)` |
| `create` | MCP create-issue / `issueCreate` with teamId |
| `update` | Update description, title, links |
| `comment` | MCP create-comment / `commentCreate` |
| `transition` | Set stateId to mapped workflow state |
| `link` | parentId / related links |
| `attach_or_link` | Description section with repo path + SHA; upload attachment if API allows |

Exact MCP tool names vary by host — discover tools before calling. Prefer MCP
when connected; fall back to:

```bash
curl -s https://api.linear.app/graphql \
  -H "Authorization: $LINEAR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query":"{ viewer { id } }"}'
```

## Keys

Use Linear identifiers in handoffs (`ENG-123`). Include the Linear URL in
comments and the markdown mirror.

## Mirror

When enabled, upsert `docs/agents/ISSUES.md` on every create/transition/handoff.
