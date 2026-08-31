---
name: test
description: >-
  Testing phase after implement: analysis of touched code (coverage, CRAP,
  representability), adversarial coverage, and testability. Adds or
  tightens tests and seams only — no new product behaviour. Hands off to
  restructure. Use when the bound chain's testing phase is next.
disable-model-invocation: true
---

# Test

Applies [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md)
**Tested delivery** as a dedicated shipping-phase pass on the **same** delivery
pull request. Complements in-package tests from implement — this pass **analyses**
touched code and hunts gaps those packages missed.

**On invoke:** read CONCEPT_IMPLEMENTATION above,
[../implement/testing.md](../implement/testing.md),
[tools.md](tools.md),
[../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).
When `implement.verify` is `comparative` (or the spec is `REWORK.md`), also read
[../implement/rework.md](../implement/rework.md).
When spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.

## Extensions

| Slot | This skill |
|------|------------|
| **Spec source** | Task + PLAN / BUG / TWEAK / REFINE / REWORK / ITERATE / ADOPT + implement packages already on the PR |
| **Workflow binding** | Honor `test.mode` and `implement.verify`; `test.mode=skip` (docs-only or explicit user ask) → persist Next `/restructure` without a testing pass. Class **adopt** / `ADOPT.md`: skip is not legal — run the pass (`non-regression`). |
| **Branch naming** | Reuse Task delivery branch |
| **Delivery** | Push test/seam changes to the same PR; leave merge to ship |
| **Verification** | [testing.md](../implement/testing.md) as an adversarial checklist (including **Working surfaces**); [tools.md](tools.md) CRAP on **touched** paths; comparative adds [rework.md](../implement/rework.md); run touched-area suite + lint |
| **Testing checklist** | [testing.md](../implement/testing.md) |
| **Work package types** | Testing (and tiny seam edits required to make a test honest) |
| **Handoff** | `/restructure` — default; Task **In Review** and `/review` only when the user explicitly skipped harden |

## Steps

1. **Resolve delivery** — Resolve the Task, spec, Workflow binding, and delivery PR. If `test.mode=skip` (docs-only or explicit user ask) **and** class is not adopt, persist Next `/restructure` and stop. Adopt / `ADOPT.md` → run the pass. Done when the PR is checked out or skip is recorded.
2. **Analyse touched code** — Run [tools.md](tools.md) on opened paths only (CRAP). Walk [testing.md](../implement/testing.md): missing behaviour tests, missing failure paths, missing regression tests, untestable new design, weakened or skipped tests, coverage regression, representability (tests that assert the executed paths), missing **working surface** proof. Always **evaluate** CRAP; no hard cap. Do not list mutants without running tests. When spec is `ADOPT.md`, also walk the Behaviour map. Done when every gap is a package or a discarded (not leftover) exception.
3. **Close gaps** — Add or tighten tests; add a **seam** only when a unit cannot be tested honestly without one. Maintain tests this change invalidated. No new product behaviour. Do not rewrite adopt lock-test expectations to make a restructure green. Re-run recorded commands (on adopt: the lock suite **and** working-surface commands). Done when the checklist holds and the suite is green.
4. **Track and hand off** — Stay **In Progress**. Comment the testing outcome (coverage/CRAP considered), persist **Next** `/restructure`. Done when Task, PR, mirror, and user report agree.

## Scope

In: tests, fixtures, fakes, the smallest seam that makes a test honest, and skill-bundled analysis tools on touched paths.
Out: product behaviour, feature work, structure-only refactors (`/restructure`), whole-tree CRAP, listing mutants without running tests, and rewriting adopt lock-test expected results.

## Handoff

```markdown
## Next
`/restructure <TASK-KEY>` — Structure pass (same catalog as implement; small diffs included)
```

When the user explicitly skipped harden / restructure:

```markdown
## Next
`/review <TASK-KEY>` — Lasers then fix then code review
```
