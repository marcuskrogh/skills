---
name: review-fix
description: >-
  Review fix-forward in one pass: run adaptive-depth review, address blockers,
  should-fix findings, and actionable notes on the same PR, then report CLEAN
  without re-review. Use for an In Review delivery that should advance directly
  toward ship.
disable-model-invocation: true
---

# Review-fix

Applies [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md) to one Task and its
**single delivery PR**, plus
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) when findings
require fix-forward. CLEAN follows once must-fix findings are addressed.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), CONCEPT_REVIEW above,
[../review/SKILL.md](../review/SKILL.md), and
[../tracker/SKILL.md](../tracker/SKILL.md). If review produces must-fix
findings, then read CONCEPT_IMPLEMENTATION above and
[../implement/SKILL.md](../implement/SKILL.md). Before spawning workers, read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.

## Extensions

| Slot | This skill |
|------|------------|
| **Change source** | Task's existing delivery PR |
| **Spec source** | Task + PLAN / BUG / ITERATE + published review findings |
| **Publish target** | One GitHub PR review + tracker summary |
| **Checklist / depth** | [review](../review/SKILL.md) full or focused contract |
| **Parallelism / model routing** | Review workers and fix-forward packages use CONCEPT_DELEGATION |
| **Branch naming** | Existing Task delivery branch |
| **Delivery** | Push fixes to the same PR; leave merge to ship |
| **Verification** | Review finding checks + affected tests/lint from implement |
| **Handoff** | CLEAN → `/ship <KEY>`; FAILED → named remaining work |

## Inputs

Issue key/URL (same resolution as review). Optional: stop after review without
fixing. Requires `gh` + tracker auth. Task should be **In Review** (or become so
after review publish).

## Steps

1. **Resolve delivery** — Resolve the issue and its existing PR through delivery continuity; require review readiness and configured auth. Done when one Task/PR pair is ready or a concrete stop is reported.
2. **Review once** — Run the full [review](../review/SKILL.md) contract at adaptive depth and publish its findings. Done when the PR review and finding counts are durable.
3. **Fix forward when needed** — Promote actionable notes to must-fix, then run [implement](../implement/SKILL.md) fix-forward against those threads on the same PR. End after this fix pass. Done when all must-fix findings are addressed (**CLEAN**) or unresolved findings are named (**FAILED**).
4. **Track and hand off** — Apply the review-fix tracker row, return the Task to **In Review** after fixes, update ISSUES, and persist **Next**. Done when Task, PR, mirror, and user report agree on CLEAN/FAILED and its Handoff.

### Must-fix

- `blocker` or `should-fix`
- Review event `REQUEST_CHANGES`
- Actionable `note`s per CONCEPT_REVIEW (evidence + concrete fix + in blast radius)
- Inline notes on changed files with a concrete fix hint — actionable unless body marks deferred/out-of-scope

Soft non-actionable notes may remain on CLEAN.

### Fix-forward constraints

Same Task + same PR; packages = review threads **and** unresolved actionable notes;
higher severity first; scope = review + PLAN/BUG plus neighbor edits required by
a finding. After fixes push → **In Review** + comment. Reply to deferred notes
with their out-of-scope reason.

## Handoff

| Exit | Condition | Next |
|------|-----------|------|
| **CLEAN** | No must-fix after review, or fix-forward addressed all (no re-review) | `/ship <KEY>` |
| **FAILED** | Fix-forward could not address must-fix | Report remaining; `/implement <KEY>` or `/review <KEY>` |

Tell the user: key/URL, PR URL, depth, fix-forward yes/no, CLEAN/FAILED, one-line
counts (blockers / should-fix / actionable notes / deferred), **Next**. No full
review dump.
