---
name: harden
description: >-
  Hardening phase after testing: behaviour-preserving structure pass on the
  delivery PR against the structure catalog (names, size, cohesion, seams,
  named smells). Hands off to review-fix. Use when the bound chain's harden
  phase is next, or to run that phase explicitly.
disable-model-invocation: true
---

# Harden

Applies [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) as a dedicated
shipping-phase pass on the **same** delivery pull request. Distinct from
`/refine` (a work **class**): harden is a closeout phase of the current Task.

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
| **Spec source** | Task + PLAN / BUG / TWEAK / REFINE / REWORK / ITERATE + current PR diff |
| **Catalog** | [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md) |
| **Scope** | Changed hunks always; surrounding module when a hunk made a neighbour worse |
| **Workflow binding** | Honor `harden.mode`; `harden.mode=skip` only when the user explicitly asked — then Task **In Review**, Next `/review-fix`, no structure pass. Default is **dedicated**, including small diffs. |
| **Branch naming** | Reuse Task delivery branch |
| **Delivery** | Push structural edits to the same PR; leave merge to ship |
| **Verification** | Suite + lint stay green; executable behaviour unchanged |
| **Structure checklist** | [structure.md](../implement/structure.md) |
| **Work package types** | Harden (extract, rename, move, split, invert); no behaviour change |
| **Handoff** | `/review-fix` — lasers then **code review** |

## Steps

1. **Resolve delivery** — Resolve the Task, spec, Workflow binding, and delivery PR. If `harden.mode=skip` **and** the user explicitly asked to skip, transition **In Review**, persist Next `/review-fix`, and stop. A missing skip on the binding → run the pass. Done when the PR is checked out or an explicit skip is recorded.
2. **Scan** — Apply the structure catalog to the diff (and neighbours the change worsened). Each breach is a concrete extract / rename / move / split / invert. Small diffs use the same catalog. Done when every catalog breach is a package or a documented exception.
3. **Apply** — Run Harden packages; include [structure.md](../implement/structure.md) in briefs. Behaviour stays the same. Re-run the touched-area suite + lint. Done when remaining breaches are documented exceptions and checks pass.
4. **Track and hand off** — Task → **In Review**, comment the harden outcome, persist **Next** `/review-fix`. Done when Task, PR, mirror, and user report agree.

## Scope

In: structure, naming, layering, comments, and seams that the catalog requires.
Out: new behaviour, test-only work (`/test`), and findings-only review (`/review`).

## Handoff

```markdown
## Next
`/review-fix <TASK-KEY>` — Laser reviews then code review
```
