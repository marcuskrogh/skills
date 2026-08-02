---
name: review-fix
description: >-
  Derived review loop: run thorough multi-axis review, automatically fix-forward
  blockers, should-fix, and actionable notes via implement, and re-review until
  clean (or max iterations). Applies Composer-biased difficulty routing for review
  axes and fix-forward packages; orchestrator stays on Grok. Hands off to ship
  when clean. Use instead of manually alternating /review and /implement.
---

# Review-fix

Automates the **review ↔ implement (fix-forward)** loop on one pipeline Task and
**its single delivery PR** (same branch from define/bug through ship).

Composes [review](../review/SKILL.md) (five axes: Spec, Correctness, Integration,
Architecture, Standards — **fix-biased** severity) and [implement](../implement/SKILL.md)
fix-forward mode. Does **not** replace first-time **implement** (build) or **ship**
closeout. Does **not** open a new PR — fix-forward stays on the existing delivery
head. (`/ship` may compose this loop as part of finishing remaining work.)

## Model routing

Every review pass and fix-forward package inside the loop applies
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md):

- **Orchestrator** of this loop (iteration control, CLEAN/STOPPED/STALLED, tracker)
  stays on the parent / most competent model (**Cursor Grok 4.5**).
- Review axis workers and fix-forward workers **default to Composer 2.5**.
- Elevate to **Cursor Grok 4.5** only for Demanding signals (see review / implement
  tables) or after an insufficient Composer attempt on the same package/axis.
- Prefer Composer for most fix-forward threads — obvious patches should not burn Grok.

Do not “upgrade the whole loop to Grok” because an earlier iteration was hard.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md),
[../concepts/CONCEPT_DELEGATION.md](../concepts/CONCEPT_DELEGATION.md),
[../review/SKILL.md](../review/SKILL.md), [../concepts/CONCEPT_REVIEW.md](../concepts/CONCEPT_REVIEW.md),
[../implement/SKILL.md](../implement/SKILL.md),
and [../tracker/SKILL.md](../tracker/SKILL.md).

## When to use

- After `/implement <KEY>` when you want review + fixes without manual ping-pong
- Instead of `/review` → `/implement` → `/review` …

Use plain `/review` when you only want findings posted, with no auto-fix.

## Inputs

1. Issue key/URL (`/review-fix MD-5`) — same resolution as review
2. Optional: `max_iterations` (default **4**) — hard stops after this many review passes that still have must-fix findings
3. Optional: user override to stop early

Requires authenticated `gh` + tracker auth. Task should be **In Review** (or become so after the first review publish / existing PR).

## Loop

```text
iteration = 1
loop:
  1. Run full /review process for <KEY> (publish on PR + tracker comment)
     — including manager promotion of mislabeled actionable notes → should-fix
  2. If no must-fix findings → break CLEAN
  3. If iteration >= max_iterations → break STOPPED
  4. If must-fix count did not improve vs previous iteration → break STALLED
  5. Run /implement fix-forward for <KEY> (address must-fix review threads)
  6. Ensure Task → In Review; upsert ISSUES mirror
  7. iteration += 1
  8. continue
```

### Must-fix findings (aggressive scope)

Treat as **must-fix** for the loop (must address before CLEAN / ship):

1. Any finding with `severity: blocker` or `severity: should-fix`
2. Review event `REQUEST_CHANGES`
3. Any **`note` that is actionable** per CONCEPT_REVIEW:
   - Evidence in the change or immediate neighbors
   - Concrete fix named in the body
   - Fix fits this PR's blast radius (touched paths + necessary neighbors)
4. Inline (`kind: inline`) notes on changed files with a concrete fix hint — treat as actionable unless the body explicitly marks them out-of-scope / follow-up

**Do not** exit CLEAN while actionable notes remain. Soft, non-actionable notes only
(out-of-scope follow-up, pure preference, speculative cleanup outside blast radius)
may remain on CLEAN.

When counting improvement for STALLED: compare
`(blockers + should-fix + actionable notes)` across iterations — ignore pure
non-actionable `note` churn.

### Fix-forward constraints

When calling implement inside the loop:

- Same Task + same PR branch
- Packages = open PR review threads / requested changes **and** unresolved
  actionable notes (not only `blocker`/`should-fix` labels)
- Prefer fixing higher severity first, then actionable notes
- No new scope beyond review + existing `PLAN.md` / `BUG.md` (neighbor edits
  required by a finding are in scope)
- After fixes: push, Task → **In Review**, comment with iteration number
- If a note is genuinely out-of-scope, reply on the thread marking it deferred
  (with reason) so it no longer counts as must-fix — do not silently ignore it

## Exits

| Exit | Condition | Next |
|------|-----------|------|
| **CLEAN** | No must-fix findings (non-actionable notes optional) | `/ship <KEY>` |
| **STOPPED** | Hit `max_iterations` with must-fix left | Report remaining findings; Next `/implement <KEY>` or `/review <KEY>` (manual) or raise max |
| **STALLED** | Must-fix count not decreasing | Stop; ask user how to proceed — do not spin |

### Tracker / markdown each iteration

- After each review: Task comment + ISSUES (**In Review**, **Next** = continuing loop or ship)
- After each fix-forward: Task comment (threads addressed, including actionable notes) + ISSUES
- On CLEAN: **Next** `/ship <KEY>` on Task + mirror

## Tell the user

When finished, only:

- Issue key/URL, PR URL
- Iterations run
- Exit reason (CLEAN / STOPPED / STALLED)
- Finding counts per iteration (blockers / should-fix / actionable notes / deferred notes — one line each)
- **Next** handoff line

Do not paste full review bodies into chat (same as review).

## Examples

User: `/review-fix MD-5`

Agent: [review → 2 blockers + 3 should-fix + 2 actionable notes → fix-forward → review → clean]  
Next: `/ship MD-5`

User: `/review-fix MD-5` max 2

Agent: [two dirty passes → STOPPED]  
Next: `/implement MD-5` — remaining findings, or re-run with higher max
