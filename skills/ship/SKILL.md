---
name: ship
description: >-
  Close out a pipeline Task after a successful review: confirm the PR is ready,
  merge (or record merge), transition the issue to Done, and persist closeout in
  markdown. Use when a clean review should be finished.
---

# Ship

Final step after [review](../review/SKILL.md). Closes the **same pipeline Task**.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md) and [../tracker/SKILL.md](../tracker/SKILL.md).

## Prerequisites

Authenticated `gh` plus tracker auth for the WORKSPACE provider.

## Process

### 0. Resolve issue

User key/URL or ask once. Prefer status **In Review**. If already **Done**, report and stop.

### 1. Resolve PR

Same order as review. If latest review is unresolved `REQUEST_CHANGES` without user override:

```markdown
## Next
`/implement <KEY>` — Address review findings (fix-forward)
```

### 2. Merge (or confirm)

| PR state | Action |
|----------|--------|
| Open/draft | Ready if needed; merge per WORKSPACE strategy (`gh pr merge`). On failure, stop — do not mark Done. |
| Merged | Continue closeout. |

### 3. Closeout

1. `transition` Task → **Done**.
2. Comment with PR URL, merge ref, **Next: Done**.
3. Comment parent Story if linked.
4. Upsert markdown mirror; optionally tick the phase in `ROADMAP.md`.
5. Tell the user: issue key/URL, PR URL, shipped — **Done**.

No further skill handoff.
