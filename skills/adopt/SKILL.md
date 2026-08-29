---
name: adopt
description: >-
  Adopt the structure catalog across an existing codebase that was not built
  to it. Inventories against the catalog, sequences shippable areas, and applies
  the frontier (behaviour unchanged). Use when the whole repo or named tree
  predates the structure bar. Prefer /refine for a bounded area; prefer /harden
  for closeout of the current delivery PR.
disable-model-invocation: true
---

# Adopt

Applies [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) to a **brownfield**
tree: inventory, sequence, apply the frontier. Distinct from `/refine` (bounded
**class**) and `/harden` (closeout of the current Task).

**On invoke:** read CONCEPT_STRUCTURE above,
[../concepts/STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md),
[inventory.md](inventory.md),
[../implement/structure.md](../implement/structure.md),
[../implement/testing.md](../implement/testing.md),
[../implement/SKILL.md](../implement/SKILL.md),
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md),
[../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).
When spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.
User-facing replies: [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md).

## Leading words

- **frontier** — first open area on the adoption route
- **area** — module, package, or bounded directory the repo already treats as a unit

## Extensions

| Slot | This skill |
|------|------------|
| **Catalog** | [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md) |
| **Scope** | Entire production tree (or the named subtree); one delivery unit at a time per [inventory.md](inventory.md) |
| **Verification** | `implement.verify=non-regression`; suite + lint prove behaviour unchanged |
| **Alignment / definition artifact** | `ADOPT.md` (path from WORKSPACE) |
| **Readiness prompt** | "Apply the catalog starting with [area]?" |
| **Opening** | Thin: whole repo. Named subtree or exclusions → honour them. Existing `ADOPT.md` → [Continue adoption](#continue-adoption) |
| **Workflow binding** | Template **structure-safe**; Chain `adopt → test → harden → review-fix → ship`. Honor an existing PLAN Classification when class is adopt |
| **Branch naming** | WORKSPACE pattern — start the **frontier** Task's delivery branch |
| **Delivery** | First PR-opening writer for the frontier Task; later closeout reuses that head |
| **Structure checklist** | [structure.md](../implement/structure.md) |
| **Work package types** | Harden-shaped (extract, rename, move, split, invert); no behaviour change |
| **Handoff** | `/test` after the frontier apply; next area after that Task ships |

## Steps

1. **Resolve tree** — Resolve workspace, tracker, and the tree to adopt (repo root or named subtree). Load PLAN Classification when class is adopt. Generated, vendor, lockfiles, and documented exclusions stay out of scope. Done when the tree and out-of-scope paths are named.
2. **Inventory** — Follow [inventory.md](inventory.md). Done when every area is either at the bar, a documented exception, or a sequenced row with a concrete move.
3. **Sequence and persist** — Rank areas; choose one Task or a Story + route Tasks. Confirm Order with the user when more than one delivery unit. Write `ADOPT.md`, apply the [adopt tracker row](../workflow/tracker-sync.md#matrix), start the frontier delivery branch/PR. Done when artifact, tracker, and **frontier** agree. Tree already at the bar → report that, persist Next none, stop.
4. **Apply frontier** — Run [implement](../implement/SKILL.md)'s full contract on the frontier packages (`non-regression`, structure briefs, closeout gate). Done when the gate holds on that PR.
5. **Track and hand off** — Stay **In Progress**, comment the inventory + frontier outcome, persist **Next** `/test`. Remaining areas stay on the Story. Done when Task, PR, mirror, and user report agree.

## Continue adoption

Existing `ADOPT.md` with open areas: skip a fresh whole-tree scan unless the tree
changed underfoot. Apply the next open row as the frontier (new Task + branch/PR
after the prior unit shipped). Re-scan only that area.

## Artifact

```markdown
# Adopt: [title]

## Destination
Meet the structure catalog across the existing tree; executable behaviour unchanged.

## Tree
- Root: …   # repo root or named subtree
- Out of scope: …   # generated, vendor, lockfiles, documented exclusions

## Inventory
| Area | Catalog rows | Concrete moves | Status |
|------|--------------|----------------|--------|
| … | … | … | open / frontier / done / exception |

## Route
| Order | Area | Task | Blocked by | Status | Issue |
|-------|------|------|------------|--------|-------|
| 1 | … | … | — | To Do | <KEY> |

## Preserve behaviour
- Yes — executable behaviour unchanged
- Verification: suite + lint on the frontier (non-regression)

## Frontier
- Area: …
- Packages: …

## Workflow
- Template: structure-safe
- Chain: adopt → test → harden → review-fix → ship

## Tracker
- Story: <KEY>   # omit when one Task
- Task: <KEY>    # frontier
- Branch: <delivery-branch>
- PR: <url or draft url>

## Next
`/test <KEY>` — Dedicated testing phase, then harden, then laser code review
```

## Tracker (after persist)

Follow the [adopt tracker row](../workflow/tracker-sync.md#matrix) and
[delivery continuity](../workflow/delivery.md). One Task when the inventory is
one delivery unit; otherwise a **Story** plus one Task per area. Keep
non-frontier Tasks **To Do**. Record `ADOPT.md`, branch/PR, and **Next** on
every configured durable surface.

## Handoff

```markdown
## Next
`/test <TASK-KEY>` — Dedicated testing phase, then harden, then laser code review
```

When the tree already meets the bar:

```markdown
## Next
none — catalog already met on this tree
```

After the frontier **ships**, Story **Next** is `/adopt` on the next open area
Task (or none when the route is Done).
