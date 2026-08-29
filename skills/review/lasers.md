# Review — lasers and code review

Disclosed reference for [review](SKILL.md) and [review-fix](../review-fix/SKILL.md).
Honor bound `review.lasers` and `review.depth`. Axis briefs stay in
[axis-briefs.md](axis-briefs.md) and [depth.md](depth.md). Severity stays
**fix-biased** per [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md). Structure bar:
[CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md).

## Choose laser mode

Pick the **first matching** row. Record `review.lasers: bundled | sequential`.

| Signal | Mode |
|--------|------|
| Bound `review.lasers=sequential` | **sequential** |
| Bound `review.lasers=bundled` | **bundled** |
| Bound `review.depth=full` or `review.mode=multiagent` (no lasers key) | **sequential** |
| Bound `review.depth=focused` (no lasers key) | **sequential** |
| User names sequential / laser / one-axis-at-a-time | **sequential** |
| User names bundled / one-pass | **bundled** |
| Ambiguous | **sequential** |

## Sequential order (ending in code review)

Run only axes that depth includes. Skip Spec when its pack is empty.

| Order | Laser | Depth |
|------:|-------|--------|
| 1 | Spec | full; focused Core when Spec pack non-empty |
| 2 | Correctness | always |
| 3 | Integration | full; focused when contracts are in blast radius ([depth.md](depth.md#when-to-add-the-integration-worker-focused)) |
| 4 | Architecture | **always** — small diffs included |
| 5 | Standards | **always** (light under focused: changed hunks only) |
| 6 | **Code review** | always — manager merge + publish |

Under `/review-fix`, after each of 1–5: if must-fix findings remain, fix-forward
on those threads, re-run the touched-area suite, then continue. Do not skip
ahead with open blockers.

Under `/review` (findings only): run 1–5 without fix-forward, then **code review**
publishes once.

## Bundled mode

Run the [depth.md](depth.md#worker-map) worker set in parallel (or one Core
worker), then the same **code review** publish. Under `/review-fix`, one
fix-forward pass after the bundle, then **code review** (a second look at the
diff after fixes — not skipped).

When bundled **focused**, still include Architecture and Standards (do not skip
them because the diff is small).

## Code review (always last)

Manager-only. Inputs: remaining findings after lasers/fix-forward, current
diff, spec, structure catalog, tooling evidence.

1. Dedupe (Architecture owns structural overlap; Integration owns runtime
   contract breaks).
2. Re-scan changed hunks for residue: catalog breaches, named smells, missing
   tests, spec gaps lasers should have closed.
3. Promote leftover actionable residue to `should-fix` (or `blocker`).
4. Publish **one** pull-request review: `REQUEST_CHANGES` for blocker/should-fix,
   `COMMENT` for non-actionable notes only, `APPROVE` for zero findings.
5. Under `/review-fix`, if the published event is `REQUEST_CHANGES`, one more
   fix-forward; then CLEAN (no third publish unless new must-fix remains).

Code review is the closeout gate. Lasers do not replace it.

## Closeout rigor

- Architecture / Standards lasers apply [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md)
  as `should-fix` on changed code — harden having run is not a reason to soften.
  Small diffs use the same catalog.
- Correctness laser still checks tests after `/test` — missing coverage is
  `should-fix`.
- Cap volume per axis as in axis-briefs; drop weakest evidence first; keep
  earned severity.
