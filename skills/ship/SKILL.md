---
name: ship
description: >-
  Finalize remaining pipeline work for a Task from any stage after define (or
  after bug / iterate ready-to-build): run implement and/or review-fix as
  needed, then closed-loop merge of the delivery PR and Done closeout. Use when
  the user says ship, ship it, finish, finish remaining, or close it out — the
  workflow recognises "ship" like it recognises "next" — or invokes /ship; not
  only after a clean review.
disable-model-invocation: true
---

# Ship

Orchestrates **remaining** delivery through Done for one pipeline Task.
**ship** is a [continuation keyword](../workflow/reference.md#continuation-keywords)
like **next** — next runs one persisted step; ship finishes whatever remains.

Detects stage and runs **only what is left**, always ending in closed-loop merge +
Done when the review path exits CLEAN. Does **not** open a new branch/PR for merge
— continuity lands on the same delivery branch, then that PR merges.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md),
[../tracker/SKILL.md](../tracker/SKILL.md), and skills you may compose:
[../implement/SKILL.md](../implement/SKILL.md),
[../review-fix/SKILL.md](../review-fix/SKILL.md). Composed skills apply
CONCEPT_DELEGATION; ship does not override toward high-capability. Orchestrator
stays on the parent / high-capability model.

Requires authenticated `gh` + tracker auth.

## Typical remaining tails

| Invoked after | Ship runs |
|---------------|-----------|
| define / bug | implement → review-fix → closeout |
| implement (In Review) | review-fix → closeout |
| review / review-fix (CLEAN) | closeout only |
| iterate (In Review) | review-fix → closeout |

## Steps

1. **Resolve issue** — key/URL → single active ISSUES row → ask once. `fetch` Task + children + Story. Load PLAN/BUG/ITERATE, ISSUES, linked PR. Already Done + merged → report and stop (repair closeout only if asked).
2. **Detect stage → remaining** — tell the user one short line before running:

| Evidence | Remaining |
|----------|-----------|
| No ready-to-build artifact | **Stop** — `/define`, `/bug`, or `/iterate` first |
| Defined; To Do; no meaningful impl on delivery PR | implement → review-fix → closeout |
| In Progress; impl incomplete | finish implement → review-fix → closeout |
| In Review; unresolved REQUEST_CHANGES / must-fix | review-fix → closeout |
| In Review; clean review **or** no review yet but user wants full finish | review-fix if needed → closeout; else closeout only |
| PR merged; Task not Done | closeout |

3. **Run remaining** — each skill's full process in order. Prefer review-fix over one-shot `/review` before closeout.
4. **Stops** — review-fix FAILED or implement unfinished → do **not** merge/Done; report what remains; leave PR open. Skip-review override with open blockers only on explicit user accept.
5. **Closeout** — [Ship closeout](../workflow/reference.md#ship-closeout):

#### Resolve PR
Prefer Task's recorded delivery PR. Require clean review (or explicit override) before merge.

#### Pre-merge continuity (PR still open)
Checkout delivery branch; commit+push continuity **with** the code (no second PR):

| Update | Action |
|--------|--------|
| PLAN / BUG / ITERATE | Mark shipped; PR URL; **Next: Done** |
| ROADMAP | Phase row Done + PR link when linked |
| ISSUES / markdown provider | Task/Sub-tasks → Done (imminent); Story as applicable |

#### Merge
Open/draft → ready if needed; `gh pr merge` per WORKSPACE (prefer `--delete-branch`). Failure → stop; close nothing. Already merged → continue; missing continuity on base only when unavoidable — still no leftover unmerged PR.

#### Tracker (mandatory order)
1. Every Sub-task → **Done**; comment keys on Task.
2. Task → **Done** with Shipped comment (PR, merge sha, closed Sub-tasks, steps run, **Next: Done**).
3. Linked Story: comment phase Done + PR; if all sibling Tasks Done → Story **Done**; else leave open + suggested Next.
4. Confirm delivery branch gone and **no open PR** remains for this Task.

## Tell the user

Task Done (or stop reason); stage detected + steps run; Sub-tasks closed; Story status;
PR URL; closed-loop confirmation when merged; Next hint for next phase or `/iterate`
when post-ship follow-up needed. No skill handoff when Task is Done.
