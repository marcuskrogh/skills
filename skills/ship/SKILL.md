---
name: ship
description: >-
  Close out a pipeline Task after a successful review: push continuity updates
  onto the same delivery branch, merge that one PR (no leftover ship PR), close
  all open Sub-tasks, mark the Task Done, close the parent Story when every phase
  Task is Done. Use when a clean review should finish.
---

# Ship

Final step after [review](../review/SKILL.md). Closes tracker work for the
**pipeline Task** (and related issues) per
[../workflow/reference.md](../workflow/reference.md) **Ship closeout**.

**Closed-loop:** ship does **not** open a new branch or PR. Continuity
(`PLAN.md` / `ROADMAP.md` / ISSUES / …) lands on the **same** delivery branch as
implement, then that PR is merged — leaving no unmerged follow-up PR.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md) and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Prerequisites

Authenticated `gh` plus tracker auth for the WORKSPACE provider.

## Process

### 0. Resolve issue

1. User key/URL or ask once.
2. `fetch` Task + children (Sub-tasks) + parent Story if linked.
3. Prefer status **In Review**. If already **Done**, report and stop (still verify Sub-tasks/Story if user asks to repair closeout).

### 1. Resolve PR

Same order as review. Prefer the Task’s recorded delivery PR (one-issue /
[delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop)).
If latest review is unresolved `REQUEST_CHANGES` without user override:

```markdown
## Next
`/implement <KEY>` — Address review findings (fix-forward)
```

Do **not** close tracker issues in that case.

### 2. Pre-merge continuity (mandatory while PR is open)

Before merging, checkout the **delivery branch** and commit + push closeout
markdown so it ships **with** the code:

| Update | Action |
|--------|--------|
| `PLAN.md` / `BUG.md` / `ITERATE.md` | Mark shipped; PR URL; **Next: Done** |
| `ROADMAP.md` | Phase row Done + PR link (when linked) |
| ISSUES mirror | Task/Sub-tasks → Done (imminent); Story as applicable |
| Markdown provider issues | Sync status fields / INDEX if provider is markdown |

Do **not** open a second PR for these edits. If the harness forced a different
local branch, cherry-pick or push the continuity commits onto the delivery head
instead.

### 3. Merge (or confirm)

| PR state | Action |
|----------|--------|
| Open/draft | Ready if needed; merge **this** PR per WORKSPACE strategy (`gh pr merge`, prefer `--delete-branch`). On failure, **stop** — close nothing; leave continuity on the open PR. |
| Merged | Continue tracker closeout. If continuity was missing from the merge, apply it on the **base branch** only when unavoidable — still **no** leftover unmerged PR. |

### 4. Tracker closeout (mandatory order)

Follow [Ship closeout](../workflow/reference.md#ship-closeout). Condensed:

1. **Sub-tasks** — every child not yet **Done** → `transition` **Done**. Comment on the Task listing closed Sub-task keys.
2. **Task** → **Done**. Comment:

```markdown
## Shipped
PR: <url>
Merge: <sha or url>
Closed sub-tasks: <keys>
## Next
Done — phase closed.
```

3. **Story** (if linked):
   - Comment: phase Task `<KEY>` Done + PR URL.
   - `fetch` sibling Tasks; if **all** are **Done** → Story → **Done** + "Initiative complete".
   - Else leave Story open; comment suggested **Next** for the next open Task.
4. Confirm the delivery branch is deleted (or no longer needed) and **no open PR**
   remains for this Task.

### 5. Tell the user

- Task key/URL — **Done**
- Sub-tasks closed (count/keys)
- Story status (still open vs **Done**)
- PR URL (merged)
- Confirmation: closed-loop — no leftover open PR/branch for this Task
- If Story still open: **Next** hint for the following phase Task
- Optional: if the user reports the merge is still wrong → **Next** `/iterate <KEY> <description>`

No skill handoff when the Task is Done; optional Next only points at the next phase
or `/iterate` when post-ship follow-up is needed.
