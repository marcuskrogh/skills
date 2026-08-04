---
name: review-fix
description: >-
  Derived single-pass review: run thorough multi-axis review, automatically
  fix-forward blockers, should-fix, and actionable notes via implement, then
  report CLEAN (no re-review). Applies low/mid/high difficulty routing for
  review axes and fix-forward packages; orchestrator stays high-capability.
  Hands off to ship when clean. Use instead of manually alternating /review and
  /implement.
---

# Review-fix

Runs **one review**, then **one fix-forward** when needed, on one pipeline Task and
**its single delivery PR** (same branch from define/bug through ship). Does **not**
re-review after fixes — exits **CLEAN** once findings are addressed (or none
existed).

Composes [review](../review/SKILL.md) (five axes: Spec, Correctness, Integration,
Architecture, Standards — **fix-biased** severity) and [implement](../implement/SKILL.md)
fix-forward mode. Does **not** replace first-time **implement** (build) or **ship**
closeout. Does **not** open a new PR — fix-forward stays on the existing delivery
head. (`/ship` may compose this skill as part of finishing remaining work.)

## Model routing

Review axes and fix-forward packages apply
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md):

- **Orchestrator** of this skill (pass control, CLEAN/FAILED, tracker) stays on
  the parent / high-capability model.
- Review axis workers and fix-forward workers use Routine → **low**, Moderate →
  **mid**, Demanding → **high** (platform catalog).
- Escalate **one tier at a time** after an insufficient attempt on the same
  package/axis.
- Prefer low/mid for most fix-forward threads — obvious patches should not burn
  a high-capability model.

Do not “upgrade the whole skill to high-capability” because an earlier package
was hard.

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
2. Optional: user override to stop after review without fixing

Requires authenticated `gh` + tracker auth. Task should be **In Review** (or become so after the first review publish / existing PR).

## Process

```text
1. Run full /review process for <KEY> (publish on PR + tracker comment)
   — including manager promotion of mislabeled actionable notes → should-fix
2. If no must-fix findings → exit CLEAN
3. Run /implement fix-forward for <KEY> (address must-fix review threads)
4. Ensure Task → In Review; upsert ISSUES mirror
5. Exit CLEAN — do not re-review
```

Single pass only. Do **not** run a second review after fix-forward. Trust the
fixes and hand off to ship.

### Must-fix findings (aggressive scope)

Treat as **must-fix** for the skill (must address before CLEAN / ship):

1. Any finding with `severity: blocker` or `severity: should-fix`
2. Review event `REQUEST_CHANGES`
3. Any **`note` that is actionable** per CONCEPT_REVIEW:
   - Evidence in the change or immediate neighbors
   - Concrete fix named in the body
   - Fix fits this PR's blast radius (touched paths + necessary neighbors)
4. Inline (`kind: inline`) notes on changed files with a concrete fix hint — treat as actionable unless the body explicitly marks them out-of-scope / follow-up

Soft, non-actionable notes only (out-of-scope follow-up, pure preference,
speculative cleanup outside blast radius) may remain on CLEAN.

### Fix-forward constraints

When calling implement:

- Same Task + same PR branch
- Packages = open PR review threads / requested changes **and** unresolved
  actionable notes (not only `blocker`/`should-fix` labels)
- Prefer fixing higher severity first, then actionable notes
- No new scope beyond review + existing `PLAN.md` / `BUG.md` (neighbor edits
  required by a finding are in scope)
- After fixes: push, Task → **In Review**, comment that findings were addressed
- If a note is genuinely out-of-scope, reply on the thread marking it deferred
  (with reason) so it no longer counts as must-fix — do not silently ignore it

## Exits

| Exit | Condition | Next |
|------|-----------|------|
| **CLEAN** | No must-fix findings after review, **or** fix-forward addressed all must-fix findings (no re-review) | `/ship <KEY>` |
| **FAILED** | Fix-forward could not address must-fix findings | Report remaining findings; Next `/implement <KEY>` or `/review <KEY>` (manual) |

### Tracker / markdown

- After review: Task comment + ISSUES (**In Review**, **Next** = fix-forward continuing or ship)
- After fix-forward: Task comment (threads addressed, including actionable notes) + ISSUES
- On CLEAN: **Next** `/ship <KEY>` on Task + mirror

## Tell the user

When finished, only:

- Issue key/URL, PR URL
- Whether fix-forward ran (yes/no)
- Exit reason (CLEAN / FAILED)
- Finding counts from the review (blockers / should-fix / actionable notes / deferred notes — one line)
- **Next** handoff line

Do not paste full review bodies into chat (same as review).

## Examples

User: `/review-fix MD-5`

Agent: [review → 2 blockers + 3 should-fix + 2 actionable notes → fix-forward → CLEAN]  
Next: `/ship MD-5`

User: `/review-fix MD-5`

Agent: [review → no must-fix findings → CLEAN]  
Next: `/ship MD-5`
