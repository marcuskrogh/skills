---
name: test
description: >-
  Testing of touched code: coverage, CRAP, spec locks, representability,
  adversarial coverage, and testability. Adds or tightens tests and seams only
  — no new product behaviour. Use standalone, or when a workflow's test step
  is current.
disable-model-invocation: true
---

# Test

Applies [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md)
**Tested delivery** and [CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md) as a
dedicated pass on the delivery diff. Complements in-package tests from
implement — this pass **analyses** touched code and hunts gaps those packages missed.

**On invoke:** read CONCEPT_IMPLEMENTATION,
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md),
[../implement/testing.md](../implement/testing.md),
[tools.md](tools.md),
and [../workflow/SKILL.md](../workflow/SKILL.md).
When `implement.verify` is `comparative` (or the spec is `REWORK.md`), also read
[../implement/rework.md](../implement/rework.md).
When spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.

## Extensions

| Slot | This skill |
|------|------------|
| **Spec source** | Task + PLAN / BUG / TWEAK / REFINE / REWORK / ITERATE / ADOPT + implement packages already on the PR |
| **Workflow binding** | Honor `test.mode` and `implement.verify`. `test.mode=skip` (docs-only or explicit user ask) and class is not adopt → outcome `skipped`, no testing pass. Class **adopt** / `ADOPT.md`: skip is not legal — run the pass (`non-regression`). |
| **Branch naming** | Reuse Task delivery branch |
| **Delivery** | Push test/seam changes to the same PR; leave merge to ship |
| **Verification** | [testing.md](../implement/testing.md) as an adversarial checklist (including **Working surfaces**); [tools.md](tools.md) CRAP on **touched** paths; comparative adds [rework.md](../implement/rework.md); run touched-area suite + lint |
| **Testing checklist** | [testing.md](../implement/testing.md) |
| **Work package types** | Testing (and tiny seam edits required to make a test honest) |

## Steps

1. **Resolve inputs** — Resolve the Task, spec, Workflow binding, and delivery diff. If `test.mode=skip` (docs-only or explicit user ask) **and** class is not adopt, record outcome `skipped`, apply the workflow transition, and end this invocation. Adopt / `ADOPT.md` → run the pass. Done when the diff is checked out in this session's working tree, or the skip transition has ended the invocation.
2. **Analyse touched code** — Run [tools.md](tools.md) on opened paths only (CRAP). Walk [testing.md](../implement/testing.md): missing **spec locks** for pass-criteria rows, missing behaviour tests, missing failure paths, missing regression tests, untestable new design, weakened or skipped tests, coverage regression, representability (tests that assert the executed paths), missing **working surface** proof. Always **evaluate** CRAP; no hard cap. Do not list mutants without running tests. When spec is `ADOPT.md`, also walk the Behaviour map. Done when every gap is a package or a discarded (not leftover) exception.
3. **Close gaps** — Add or tighten tests; add a **seam** only when a unit cannot be tested honestly without one. Maintain tests this change invalidated. No new product behaviour. Do not rewrite adopt lock-test expectations to make a restructure green. Re-run recorded commands (on adopt: the lock suite **and** working-surface commands). Done when the checklist holds and the suite is green.
4. **Track** — Stay **In Progress**. Comment the testing outcome (coverage/CRAP/spec locks considered). Record outcome `ready`. Apply the workflow transition. Done when Task, PR, mirror, and user report agree.

## Scope

In: tests, fixtures, fakes, the smallest seam that makes a test honest, and skill-bundled analysis tools on touched paths.
Out: product behaviour, feature work, structure-only refactors (`/restructure`), whole-tree CRAP, listing mutants without running tests, and rewriting adopt lock-test expected results.

## Inputs

| Input | When present | When absent |
|-------|----------------|-------------|
| Pass criteria on the definition spec | Apply each row as a spec lock target | Define checkable pass criteria for the named scope in this invocation (CONCEPT_DEFINITION, proportional), write them onto the spec, then apply them |
| Delivery diff | Analyse touched code | Ask once what to test, then test that scope on the current tree |

## Output

tests on the delivery diff — gap analysis, added or tightened tests, seams only as required. Outcome: `ready`, or `skipped` when the binding skips this step.

This skill does not name a successor. Apply the workflow transition before the turn ends.
