---
name: review-fix
description: >-
  Review fix-forward through laser phases ending in code review: run sequential
  or bundled axis lasers, address must-fix findings after each laser, publish
  one code review, then report CLEAN. Use for an In Review delivery that should
  advance toward ship.
disable-model-invocation: true
---

# Review-fix

Applies [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md) **lasers** and
**code review** to one Task and its **single delivery PR**, plus
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) and
[CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) when findings require
fix-forward. CLEAN follows after the published code review is clean.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), CONCEPT_REVIEW above,
[../review/SKILL.md](../review/SKILL.md),
[../review/lasers.md](../review/lasers.md), and
[../tracker/SKILL.md](../tracker/SKILL.md). If a laser or code review produces
must-fix findings, then read CONCEPT_IMPLEMENTATION above,
CONCEPT_STRUCTURE above, and [../implement/SKILL.md](../implement/SKILL.md).
Before spawning workers, read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.

## Extensions

| Slot | This skill |
|------|------------|
| **Change source** | Task's existing delivery PR |
| **Spec source** | Task + PLAN / BUG / TWEAK / REFINE / REWORK / ITERATE / ADOPT + published review findings |
| **Publish target** | One GitHub **code review** + tracker summary (per-laser findings stay in worker reports until then) |
| **Checklist / depth** | [review](../review/SKILL.md) full or focused contract + [lasers.md](../review/lasers.md) |
| **Parallelism / model routing** | Laser workers and fix-forward packages use CONCEPT_DELEGATION |
| **Branch naming** | Existing Task delivery branch |
| **Delivery** | Push fixes to the same PR; leave merge to ship |
| **Verification** | Review finding checks + affected tests/lint/structure from implement |
| **Handoff** | CLEAN → `/ship <KEY>`; FAILED → named remaining work |

## Inputs

Issue key/URL (same resolution as review). Optional: stop after code review
without fixing. Requires `gh` + tracker auth. Task should be **In Review** (or
become so after harden).

## Steps

1. **Resolve delivery** — Resolve the issue and its existing PR through delivery continuity; require review readiness and configured auth. Done when one Task/PR pair is ready or a concrete stop is reported.
2. **Lasers** — Run [lasers.md](../review/lasers.md) at bound depth/mode. After each sequential laser (or after the bundle), promote actionable notes to must-fix and run [implement](../implement/SKILL.md) fix-forward on those threads. Re-run the touched-area suite. Done when included lasers are complete or a named hard stop remains.
3. **Code review** — Manager merge + publish per [review](../review/SKILL.md) **code review**. If the event is `REQUEST_CHANGES`, one more fix-forward. Done when the durable PR review exists and must-fix are addressed (**CLEAN**) or unresolved findings are named (**FAILED**).
4. **Track and hand off** — Apply the review-fix tracker row, keep the Task **In Review**, update ISSUES, and persist **Next**. Done when Task, PR, mirror, and user report agree on CLEAN/FAILED and its Handoff.

### Must-fix

- `blocker` or `should-fix`
- Review event `REQUEST_CHANGES`
- Actionable `note`s per CONCEPT_REVIEW (evidence + concrete fix + in blast radius)
- Inline notes on changed files with a concrete fix hint — actionable unless body marks deferred/out-of-scope
- Named structure-catalog smells and catalog breaches in **changed** code

Soft non-actionable notes may remain on CLEAN.

### Fix-forward constraints

Same Task + same PR; packages = current laser (or code-review) threads **and**
unresolved actionable notes; higher severity first; scope = review + PLAN/BUG/TWEAK/REFINE/ADOPT
plus neighbor edits required by a finding. Honor [structure.md](../implement/structure.md)
and [testing.md](../implement/testing.md) in briefs. After each fix push → stay
**In Review** + comment. Reply to deferred notes with their out-of-scope reason.

## Handoff

| Exit | Condition | Next |
|------|-----------|------|
| **CLEAN** | Code review has no must-fix, or the final fix-forward addressed all | `/ship <KEY>` |
| **FAILED** | Fix-forward could not address must-fix | Report remaining; `/implement <KEY>` or `/review <KEY>` |

Tell the user: key/URL, PR URL, depth, laser mode, lasers run, fix-forward yes/no,
CLEAN/FAILED, one-line counts (blockers / should-fix / actionable notes / deferred),
**Next**. No full review dump.
