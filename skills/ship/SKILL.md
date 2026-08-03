---
name: ship
description: >-
  Finalize remaining pipeline work for a Task from any stage after define (or
  after bug / iterate ready-to-build): run implement and/or review-fix as
  needed, then closed-loop merge of the delivery PR and Done closeout. Use when
  the user says ship, ship it, finish, finish remaining, or close it out — the
  workflow recognises "ship" like it recognises "next" — or invokes /ship; not
  only after a clean review.
---

# Ship

Orchestrates **remaining** delivery steps through Done for one pipeline Task.

**Keyword:** the workflow treats **ship** (and close variants: "ship it", "finish",
"finish remaining", "close it out") like it treats **next** — a continuation cue,
not only a slash command. See
[Continuation keywords](../workflow/reference.md#continuation-keywords).
Saying **next** runs the single persisted Next step; saying **ship** runs this
skill and finishes whatever remains through Done.

May be invoked at **any point after** a ready-to-build definition exists — not
only after [review-fix](../review-fix/SKILL.md). Typical remaining tails:

| Invoked after | Ship runs |
|---------------|-----------|
| **define** (or **bug**) | [implement](../implement/SKILL.md) → [review-fix](../review-fix/SKILL.md) → **closeout** |
| **implement** (PR In Review) | [review-fix](../review-fix/SKILL.md) → **closeout** |
| **review** / **review-fix** (CLEAN) | **closeout** only |
| **iterate** (new Task In Review) | [review-fix](../review-fix/SKILL.md) → **closeout** |

Ship detects the current stage and runs **only what is still left**, always ending
with closed-loop merge + tracker Done when the review path exits CLEAN.

**Closed-loop closeout:** ship does **not** open a new branch or PR for merge.
Continuity (`PLAN.md` / `BUG.md` / `ITERATE.md` / `ROADMAP.md` / ISSUES / …) lands
on the **same** delivery branch as implement, then that PR is merged — leaving no
unmerged follow-up PR.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md),
[../tracker/SKILL.md](../tracker/SKILL.md), and the skills you may compose:
[../implement/SKILL.md](../implement/SKILL.md),
[../review-fix/SKILL.md](../review-fix/SKILL.md).
When those skills spawn workers, they apply
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) — ship does **not** override
toward high-capability; the ship orchestrator itself stays on the parent /
high-capability model.

## Prerequisites

Authenticated `gh` plus tracker auth for the WORKSPACE provider.

## Process

### 0. Resolve issue

1. User key/URL (`/ship MD-5`, `ship SWD-84`, …).
2. Else the single **active** row in `docs/agents/ISSUES.md` (In Progress / In Review,
   or To Do with PLAN/BUG/ITERATE when that is the clear pipeline Task).
3. Else ask once: "Which issue should I ship?"
4. `fetch` Task + children (Sub-tasks) + parent Story if linked.
5. Load continuity: `PLAN.md` / `BUG.md` / `ITERATE.md`, ISSUES mirror, linked PR.
6. If already **Done** and PR merged — report and stop (still verify Sub-tasks/Story
   if the user asks to repair closeout).

### 1. Detect stage → remaining work

Infer the furthest stage from evidence (same idea as [summarise](../summarise/SKILL.md)):

| Stage evidence | Remaining sequence |
|----------------|--------------------|
| No ready-to-build artifact (`PLAN.md` / `BUG.md` / `ITERATE.md`) and Task not yet defined | **Stop** — tell the user to run `/define`, `/bug`, or `/iterate` first. Ship does not explore or define. |
| Defined / bug-aligned / iterate-aligned; Task **To Do** (or equivalent); no meaningful implementation on the delivery PR yet | `implement` → `review-fix` → **closeout** |
| Task **In Progress**; implementation incomplete | Finish `implement` (build) → `review-fix` → **closeout** |
| Task **In Review**; PR open; latest review unresolved / `REQUEST_CHANGES` / blockers / should-fix / actionable notes | `review-fix` → **closeout** |
| Task **In Review**; PR open; clean review (no must-fix findings) **or** no review yet but user wants full finish | `review-fix` (if no clean review yet) → **closeout**; if already CLEAN, **closeout** only |
| PR already merged; Task not Done | **closeout** (tracker + missing continuity on base only when unavoidable) |

Tell the user the detected stage and the remaining sequence **before** running it
(one short line is enough).

### 2. Run remaining composed skills

Execute the remaining sequence **in order**. Follow each skill’s full process
(status transitions, delivery-branch reuse, tests, PR comments, ISSUES mirror,
**Next** updates) — do not shortcut.

| Step | How |
|------|-----|
| **implement** | Build mode per [implement](../implement/SKILL.md): reuse delivery branch/PR, work packages + tests, Task → **In Review**, handoff continuity. |
| **review-fix** | Full loop per [review-fix](../review-fix/SKILL.md) (default `max_iterations` **4** unless the user set another). Prefer review-fix over one-shot `/review` so must-fix findings (including actionable notes) are fixed before closeout. |
| **closeout** | Only after review-fix exits **CLEAN** (or the Task was already ship-ready). See [§3](#3-closeout-mandatory). |

#### Stops (do not closeout)

If **review-fix** exits **STOPPED** or **STALLED**, or implement cannot finish:

- **Do not** merge or mark Done.
- Report what ran, what remains, and **Next** (`/implement`, `/review-fix`, or re-run
  `/ship` after fixes).
- Leave the delivery PR open.

If latest review is unresolved `REQUEST_CHANGES` and the user overrode to skip
review-fix — still prefer fixing first; only closeout on explicit user override
that accepts shipping with open blockers.

### 3. Closeout (mandatory)

Follow [Ship closeout](../workflow/reference.md#ship-closeout). Condensed:

#### 3a. Resolve PR

Prefer the Task’s recorded delivery PR ([delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop)).
Require a clean review outcome (or user override) before merge.

#### 3b. Pre-merge continuity (while PR is open)

Checkout the **delivery branch** and commit + push closeout markdown so it ships
**with** the code:

| Update | Action |
|--------|--------|
| `PLAN.md` / `BUG.md` / `ITERATE.md` | Mark shipped; PR URL; **Next: Done** |
| `ROADMAP.md` | Phase row Done + PR link (when linked) |
| ISSUES mirror | Task/Sub-tasks → Done (imminent); Story as applicable |
| Markdown provider issues | Sync status fields / INDEX if provider is markdown |

Do **not** open a second PR for these edits. If the harness forced a different
local branch, cherry-pick or push the continuity commits onto the delivery head
instead.

#### 3c. Merge (or confirm)

| PR state | Action |
|----------|--------|
| Open/draft | Ready if needed; merge **this** PR per WORKSPACE strategy (`gh pr merge`, prefer `--delete-branch`). On failure, **stop** — close nothing; leave continuity on the open PR. |
| Merged | Continue tracker closeout. If continuity was missing from the merge, apply it on the **base branch** only when unavoidable — still **no** leftover unmerged PR. |

#### 3d. Tracker closeout (mandatory order)

1. **Sub-tasks** — every child not yet **Done** → `transition` **Done**. Comment on the Task listing closed Sub-task keys.
2. **Task** → **Done**. Comment:

```markdown
## Shipped
PR: <url>
Merge: <sha or url>
Closed sub-tasks: <keys>
Remaining steps run: <implement? review-fix? closeout>
## Next
Done — phase closed.
```

3. **Story** (if linked):
   - Comment: phase Task `<KEY>` Done + PR URL.
   - `fetch` sibling Tasks; if **all** are **Done** → Story → **Done** + "Initiative complete".
   - Else leave Story open; comment suggested **Next** for the next open Task.
4. Confirm the delivery branch is deleted (or no longer needed) and **no open PR**
   remains for this Task.

### 4. Tell the user

- Task key/URL — **Done** (or stopped reason if not)
- Stage detected at start + steps actually run
- Sub-tasks closed (count/keys) when closeout ran
- Story status (still open vs **Done**) when applicable
- PR URL (merged or still open)
- Confirmation: closed-loop — no leftover open PR/branch for this Task (when merged)
- If Story still open: **Next** hint for the following phase Task
- If stopped before Done: **Next** `/ship <KEY>` (retry remaining) or the specific skill to unblock
- Optional: if the user reports the merge is still wrong → **Next** `/iterate <KEY> <description>`

No skill handoff when the Task is Done; optional Next only points at the next phase
or `/iterate` when post-ship follow-up is needed.

## Examples

User: `ship` (or `/ship MD-5`) right after define

Agent: Stage = defined → run implement → review-fix → closeout  
→ Task Done, PR merged

User: `ship it` after implement (In Review, no review yet)

Agent: Stage = in review → run review-fix → closeout  
→ Task Done, PR merged

User: `next` after implement

Agent: Runs persisted Next only → `/review-fix` (does **not** auto-closeout)

User: `/ship MD-5` after review-fix CLEAN

Agent: Stage = ship-ready → closeout only  
→ Task Done, PR merged

User: `ship` when review-fix STALLED

Agent: Ran review-fix → STALLED — did **not** merge  
Next: `/implement MD-5` or `ship` after addressing findings
