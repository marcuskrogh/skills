---
name: restructure
description: >-
  Restructure: refactoring pass against the structure catalog (campground,
  names, size, cohesion, seams, named smells, CRAP). No behaviour change.
  Use standalone on a named area, or when a workflow's restructure step is
  current. Alias: /harden.
disable-model-invocation: true
---

# Restructure

Applies [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) and
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md) as a dedicated **refactoring**
pass on the delivery diff.
Distinct from `/refine` (a work **class**) and `/adopt` (brownfield whole-tree):
restructure is a closeout phase of the current Task. `/harden` is the invoke
alias; `harden.mode` is the binding key.

**On invoke:** read CONCEPT_STRUCTURE,
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md),
[../concepts/STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md),
[../implement/structure.md](../implement/structure.md),
[../implement/testing.md](../implement/testing.md),
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md),
and [../workflow/SKILL.md](../workflow/SKILL.md).
When spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.

## Extensions

| Slot | This skill |
|------|------------|
| **Spec source** | Task + PLAN / BUG / TWEAK / REFINE / REWORK / ITERATE / ADOPT + current PR diff |
| **Catalog** | [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md) |
| **Scope** | Touched units always; surrounding module when a hunk made a neighbour worse; architecture neighbourhood only when a major benefit is already in ARCHITECTURE.md or the scan |
| **Workflow binding** | Honor `harden.mode`. `harden.mode=skip` only when the user explicitly asked — then Task **In Review**, outcome `skipped`, no structure pass. Default is **dedicated**, including small diffs. |
| **Branch naming** | Reuse Task delivery branch |
| **Delivery** | Push structural edits to the same PR; leave merge to ship |
| **Verification** | Suite + lint stay green; executable behaviour unchanged; on `ADOPT.md`, re-run lock-suite **and** working-surface commands |
| **Structure checklist** | [structure.md](../implement/structure.md) |
| **Work package types** | Refactoring (extract, rename, move, split, invert, asserting test); no behaviour change |

## Steps

1. **Resolve inputs** — Resolve the Task, spec, Workflow binding, and delivery diff (or the named area). If `harden.mode=skip` **and** the user explicitly asked to skip, transition **In Review**, record outcome `skipped`, apply the workflow transition, and end this invocation. A missing skip on the binding → run the pass. Done when the diff is checked out, or the skip transition has ended the invocation.
2. **Scan** — Apply the structure catalog to **touched units** (and neighbours the change worsened). Hunt leftovers implement missed. Each breach is a concrete extract / rename / move / split / invert / asserting test. Small diffs use the same catalog. Done when every catalog breach is a package or a documented exception.
3. **Apply** — Run Restructure packages; include [structure.md](../implement/structure.md) in briefs. Behaviour stays the same. Re-run the touched-area suite + lint. When spec is `ADOPT.md`, also re-run the recorded lock suite and working-surface commands. Done when remaining breaches are documented exceptions and checks pass.
4. **Track** — Task → **In Review**, comment the restructure outcome, record outcome `ready`. Apply the workflow transition. Done when Task, PR, mirror, and user report agree.

## Scope

In: structure, naming, layering, comments, and seams that the catalog requires on opened units.
Out: new behaviour, test-only work (`/test`), and the larger analysis (`/review`).

## Inputs

| Input | When present | When absent |
|-------|----------------|-------------|
| Delivery diff or named area | Apply the catalog to touched units | Ask once which area to restructure |
| Definition spec | Apply its preserve-behaviour bar or pass criteria | Keep executable behaviour unchanged (CONCEPT_STRUCTURE) and record that bar |
| `ARCHITECTURE.md` | Apply neighbourhood notes | Continue with the catalog alone |

## Output

structural edits on the delivery diff — catalog breaches fixed or documented. Outcome: `ready`, or `skipped` when the user explicitly skipped this step.

This skill does not name a successor. Apply the workflow transition before the turn ends.
