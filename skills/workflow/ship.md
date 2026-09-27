# Ship remaining workflow and closeout

Load when running `/ship` — remaining-tail detection or closed-loop closeout.

## Remaining workflow

`/ship` runs the **suffix** of the bound chain in
[pipelines.md](pipelines.md), then closeout. It does not invent a second order.
It is not limited to “clean review → merge”.

Detect the current position, then run every later step in that chain (mode
**immediate** through closeout). Honor `test.mode` / `harden.mode` /
`review.lasers` by using the chain assembly rules. Treat a missing skip as
**dedicated**. Class **adopt** uses the adopt chain and
[../adopt/route.md](../adopt/route.md); do not drop characterize or test.

| Evidence | Position in the chain |
|----------|------------------------|
| No definition spec | Stop. The work is not ready. Ask the user to define it (or invoke the matching skill). |
| `ADOPT.md`; route not Done | **adopt** workflow — resume at the first open area |
| `sandbox=inject` and `SANDBOX.md` is not promotion-ready | **sandbox** |
| Definition spec exists; no `ARCHITECTURE.md` | **architect** |
| Shape recorded; implementation incomplete | **implement** |
| Implementation complete; testing phase not done (`test` is in the chain) | **test** |
| Testing done or test not in the chain; restructure not done (`restructure` is in the chain) | **restructure** |
| In Review; review not CLEAN | **review** |
| CLEAN | closeout |
| Review outcome FAILED | Stop. Do not merge. The delivery transition names **implement** |

Composed skills keep their full contracts, including defining a required input
that is missing. Done when the suffix has completed or a hard stop is reported.

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
