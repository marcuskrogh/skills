---
name: review-fix
description: >-
  Derived single-pass review: run adaptive-depth review (full or focused via
  /review), automatically fix-forward blockers, should-fix, and actionable notes
  via implement, then report CLEAN (no re-review). Applies low/mid/high difficulty
  routing for review workers and fix-forward packages; orchestrator stays
  high-capability. Hands off to ship when clean. Use instead of manually
  alternating /review and /implement.
disable-model-invocation: true
---

# Review-fix

One **review**, then one **fix-forward** when needed, on one Task and its
**single delivery PR**. Does **not** re-review after fixes — exits **CLEAN** once
must-fix findings are addressed (or none existed).

Composes [review](../review/SKILL.md) and [implement](../implement/SKILL.md)
fix-forward. Inherits review **depth** (`full` / `focused`). Does not replace
first-time build or **ship** closeout. Does not open a new PR.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md),
[../concepts/CONCEPT_DELEGATION.md](../concepts/CONCEPT_DELEGATION.md),
[../concepts/CONCEPT_REVIEW.md](../concepts/CONCEPT_REVIEW.md),
[../review/SKILL.md](../review/SKILL.md), [../implement/SKILL.md](../implement/SKILL.md),
and [../tracker/SKILL.md](../tracker/SKILL.md).

Orchestrator stays high-capability; review and fix-forward workers use
CONCEPT_DELEGATION (prefer low/mid for most fix-forward). Do not upgrade the
whole skill because one package was hard.

## When

After `/implement` when you want review + fixes without ping-pong. Plain
`/review` when findings only, no auto-fix.

## Inputs

Issue key/URL (same resolution as review). Optional: stop after review without
fixing. Requires `gh` + tracker auth. Task should be **In Review** (or become so
after review publish).

## Steps

```text
1. /review for <KEY> (adaptive depth; promote actionable notes → should-fix)
2. No must-fix → CLEAN
3. /implement fix-forward for must-fix threads
4. Task → In Review; upsert ISSUES
5. CLEAN — do not re-review
```

### Must-fix

1. `blocker` or `should-fix`
2. Review event `REQUEST_CHANGES`
3. Actionable `note`s per CONCEPT_REVIEW (evidence + concrete fix + in blast radius)
4. Inline notes on changed files with a concrete fix hint — actionable unless body marks deferred/out-of-scope

Soft non-actionable notes may remain on CLEAN.

### Fix-forward constraints

Same Task + same PR; packages = review threads **and** unresolved actionable notes;
higher severity first; no new scope beyond review + PLAN/BUG (neighbor edits required
by a finding are in scope); after fixes push → **In Review** + comment; genuinely
out-of-scope notes → reply deferred with reason (do not silently ignore).

## Exits

| Exit | Condition | Next |
|------|-----------|------|
| **CLEAN** | No must-fix after review, or fix-forward addressed all (no re-review) | `/ship <KEY>` |
| **FAILED** | Fix-forward could not address must-fix | Report remaining; `/implement <KEY>` or `/review <KEY>` |

Tell the user: key/URL, PR URL, depth, fix-forward yes/no, CLEAN/FAILED, one-line
counts (blockers / should-fix / actionable notes / deferred), **Next**. No full
review dump.
