# Backend: github

GitHub Issues via authenticated `gh` CLI.

## Prerequisites

- `gh auth status` succeeds
- Repo from `WORKSPACE.md` or current `gh repo view`

## Type mapping

GitHub has a single issue type. Encode logical type with **labels**:

| Logical | Label (create if missing) |
|---------|---------------------------|
| Story | `story` |
| Task | `task` |
| Bug | `bug` |

Parent/child: put `Parent: #n` in the body; optionally use sub-issues if the
repo supports them (`gh` sub-issue commands when available).

## Status mapping

| Logical | GitHub |
|---------|--------|
| To Do | open + label `status:todo` (or no status label) |
| In Progress | open + `status:in-progress` |
| In Review | open + `status:in-review` |
| Done | **closed** (completed) |

Create the `status:*` labels on first use if absent.

## Operations

| Op | How |
|----|-----|
| `fetch` | `gh issue view <n> --json number,title,body,state,labels,comments,url` |
| `create` | `gh issue create --title "…" --body "…" --label task` |
| `update` | `gh issue edit <n> --body "…"` |
| `comment` | `gh issue comment <n> --body "…"` |
| `transition` | Add/remove status labels; `gh issue close <n>` for Done |
| `link` | Body references + comment on parent listing children |
| `attach_or_link` | Body section `## Artifact` with path + SHA |

## Keys

Use `#<number>` or `<number>` in handoffs (`/implement #42`). Store the URL in
the markdown mirror.

## Mirror

When enabled, map `#42` → row in `docs/agents/ISSUES.md` with title, status, Next.
