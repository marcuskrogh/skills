---
name: restructure
description: >-
  Restructure phase after testing: refactoring pass on the delivery PR against
  the structure catalog (campground, names, size, cohesion, seams, named smells,
  CRAP). Hands off to review. Use when the bound chain's restructure phase is
  next, or to run that phase explicitly. Alias: /harden.
disable-model-invocation: true
---

# Restructure

Applies [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) as a dedicated
shipping-phase **refactoring** pass on the **same** delivery pull request.
Distinct from `/refine` (a work **class**) and `/adopt` (brownfield whole-tree):
restructure is a closeout phase of the current Task. `/harden` is the invoke
alias; `harden.mode` is the binding key.

**On invoke:** read CONCEPT_STRUCTURE above,
[../concepts/STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md),
[../implement/structure.md](../implement/structure.md),
[../implement/testing.md](../implement/testing.md),
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md),
[../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).
When spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.

## Extensions

| Slot | This skill |
|------|------------|
| **Spec source** | Task + PLAN / BUG / TWEAK / REFINE / REWORK / ITERATE / ADOPT + current PR diff |
| **Catalog** | [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md) |
| **Scope** | Touched units always; surrounding module when a hunk made a neighbour worse; architecture neighbourhood only when a major benefit is already in ARCHITECTURE.md or the scan |
| **Workflow binding** | Honor `harden.mode`; `harden.mode=skip` only when the user explicitly asked — then Task **In Review**, Next `/review`, no structure pass. Default is **dedicated**, including small diffs. |
| **Branch naming** | Reuse Task delivery branch |
| **Delivery** | Push structural edits to the same PR; leave merge to ship |
| **Verification** | Suite + lint stay green; executable behaviour unchanged; on `ADOPT.md`, re-run lock-suite **and** working-surface commands |
| **Structure checklist** | [structure.md](../implement/structure.md) |
| **Work package types** | Refactoring (extract, rename, move, split, invert, asserting test); no behaviour change |
| **Handoff** | `/review` — lasers then fix then **code review** |

## Steps

1. **Resolve delivery** — Resolve the Task, spec, Workflow binding, and delivery PR. If `harden.mode=skip` **and** the user explicitly asked to skip, transition **In Review**, persist Next `/review`, and stop. A missing skip on the binding → run the pass. Done when the PR is checked out or an explicit skip is recorded.
2. **Scan** — Apply the structure catalog to **touched units** (and neighbours the change worsened). Hunt leftovers implement missed. Each breach is a concrete extract / rename / move / split / invert / asserting test. Small diffs use the same catalog. Done when every catalog breach is a package or a documented exception.
3. **Apply** — Run Restructure packages; include [structure.md](../implement/structure.md) in briefs. Behaviour stays the same. Re-run the touched-area suite + lint. When spec is `ADOPT.md`, also re-run the recorded lock suite and working-surface commands. Done when remaining breaches are documented exceptions and checks pass.
4. **Track and hand off** — Task → **In Review**, comment the restructure outcome, persist **Next** `/review`. Done when Task, PR, mirror, and user report agree.

## Scope

In: structure, naming, layering, comments, and seams that the catalog requires on opened units.
Out: new behaviour, test-only work (`/test`), and the larger analysis (`/review`).

## Handoff

```markdown
## Next
`/review <TASK-KEY>` — Lasers then fix then code review
```
