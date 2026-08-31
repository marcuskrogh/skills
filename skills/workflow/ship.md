# Ship remaining workflow and closeout

Load when running `/ship` — remaining-tail detection or closed-loop closeout.

## Remaining workflow

`/ship` finalizes whatever is still left after define / bug / tweak / refine /
rework / adopt / sandbox / iterate-ready.
It is not limited to “clean review → merge”.

```text
detect stage
  → not ready-to-build → stop; tell user /define|/bug|/tweak|/refine|/rework|/adopt|/iterate|/sandbox
  → sandbox outstanding (`sandbox=inject`, SANDBOX.md not promotion-ready) → /sandbox
  → adopt outstanding (`ADOPT.md` present, route not Done) → /adopt
  → architecture outstanding (no ARCHITECTURE.md after define) → /architect
  → implementation outstanding → /implement on delivery branch/PR
  → testing outstanding (`test.mode` not an explicit skip, no testing-phase comment) → /test
  → restructure outstanding (`harden.mode` not an explicit user skip, Task not yet In Review from restructure) → /restructure
  → review not CLEAN → /review on same PR (lasers + fix + code review)
  → CLEAN / ship-ready → closeout
  → review-fix FAILED → stop; do not merge; report Next
```

| Invoked when | Remaining |
|--------------|-----------|
| After define / bug / tweak / refine / rework (To Do, plan ready) | architect → implement → test → restructure → review → closeout (sandbox first when `sandbox=inject` and not promotion-ready) |
| After adopt (route not Done) | `/adopt` — resume the route (inventory if needed, characterize if the map is not locked, then remaining unit chains) |
| After sandbox (promotion-ready) | implement → test → restructure → review → closeout |
| After implement (In Progress, PR has impl) | test → restructure → review → closeout |
| After test | restructure → review → closeout |
| After restructure / harden (In Review) | review → closeout |
| After review CLEAN / clean code review | closeout |
| After iterate (new Task, impl done) | remaining closeout chain from Next |

Composed skills keep their full contracts. Ship only chooses **which** still need
to run. Done when remaining skills have completed or a hard stop is reported.

Honor bound `test.mode` / `harden.mode` / `review.lasers`. Treat missing skip as
**dedicated**. Drop a closeout step only when the user explicitly asked to skip
it (or docs-only for test). Class **adopt** / `ADOPT.md`: do not drop characterize or `/test`.

## Closeout

Closed-loop on the Task’s **single delivery PR**. Run only after CLEAN **code
review** (or already ship-ready / explicit user override).

1. **Pre-merge continuity (PR still open)** — commit and push on the delivery branch:
   - PLAN / BUG / TWEAK / REFINE / REWORK / ITERATE / ADOPT / SANDBOX — shipped / **Next: Done** + PR link
   - ROADMAP — phase Done + PR link when this Task owns a phase
   - **Changelog** — when [detected](changelog.md), append compact entry per repo format
   - ISSUES (and markdown issue files if provider is markdown)
   - Done when continuity is on the open PR head.
2. **Merge** — that PR per WORKSPACE strategy. Failure → **stop**; close nothing;
   open no replacement PR. Done when merge succeeds (or already merged).
3. **Sub-tasks** — every still-open child → **Done** (batch comment on parent OK).
4. **Task** → **Done**; comment PR URL, merge SHA, closed Sub-tasks, **Next: Done**.
5. **Story** (if linked) — comment phase Done + PR; if all child Tasks Done →
   Story **Done**; else leave open with Next hint to next open Task or `/summarise`.
6. **Remote branch** — delete delivery head when the host allows; confirm no open
   PR remains for this Task.

If the PR was **already merged**, apply missing markdown continuity (including
[changelog](changelog.md) when detected) as a direct commit on the base branch
only when unavoidable — still leave no unmerged closeout PR.

Closeout is done when Task is Done, Sub-tasks are Done, Story is updated, and no
open delivery PR remains (or a hard stop after merge failure was reported).
