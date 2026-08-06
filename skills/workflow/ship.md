# Ship remaining workflow and closeout

Load when running `/ship` — remaining-tail detection or closed-loop closeout.

## Remaining workflow

`/ship` finalizes whatever is still left after define / bug / iterate-ready.
It is not limited to “clean review → merge”.

```text
detect stage
  → not ready-to-build → stop; tell user /define|/bug|/iterate
  → implementation outstanding → /implement on delivery branch/PR
  → review not CLEAN → /review-fix on same PR
  → CLEAN / ship-ready → closeout
  → review-fix FAILED → stop; do not merge; report Next
```

| Invoked when | Remaining |
|--------------|-----------|
| After define / bug (To Do, plan/bug ready) | implement → review-fix → closeout |
| After implement (In Review) | review-fix → closeout |
| After review-fix CLEAN / clean review | closeout |
| After iterate (new Task In Review) | review-fix → closeout |

Composed skills keep their full contracts. Ship only chooses **which** still need
to run. Done when remaining skills have completed or a hard stop is reported.

## Closeout

Closed-loop on the Task’s **single delivery PR**. Run only after CLEAN review
(or already ship-ready / explicit user override).

1. **Pre-merge continuity (PR still open)** — commit and push on the delivery branch:
   - PLAN / BUG / ITERATE — shipped / **Next: Done** + PR link
   - ROADMAP — phase Done + PR link when this Task owns a phase
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

If the PR was **already merged**, apply missing markdown continuity as a direct
commit on the base branch only when unavoidable — still leave no unmerged
closeout PR.

Closeout is done when Task is Done, Sub-tasks are Done, Story is updated, and no
open delivery PR remains (or a hard stop after merge failure was reported).
