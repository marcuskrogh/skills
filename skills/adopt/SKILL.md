---
name: adopt
description: >-
  Adopt the structure catalog across an existing codebase that was not built
  to it. Characterizes current behaviour into tests first — including startable
  frontend and backend — then restructures against that same suite. Delegates
  inventory and packages; walks characterize → architect → implement → test →
  restructure → review → ship until Done. Prefer /refine for a bounded area; prefer
  /restructure for closeout of the current delivery PR.
disable-model-invocation: true
---

# Adopt

Applies [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) to a **brownfield**
tree. Orchestrates inventory, then a **fixed** unit chain per area until the
route is Done — **Proof is the gate** on every unit. Distinct from `/refine`
(bounded **class**) and `/restructure` (closeout of the current Task; alias `/harden`).

**On invoke:** read CONCEPT_STRUCTURE above,
[../concepts/STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md),
[inventory.md](inventory.md),
[route.md](route.md),
[characterize.md](characterize.md),
[../implement/structure.md](../implement/structure.md),
[../implement/testing.md](../implement/testing.md),
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md),
and [../workflow/SKILL.md](../workflow/SKILL.md).
When walking the unit chain, read each composed skill as [route.md](route.md)
directs. When spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.

## Leading words

- **area** — module, package, or bounded directory the repo already treats as a unit
- **unit chain** — fixed per-area sequence: characterize → architect → implement → test → restructure → review → ship

## Extensions

| Slot | This skill |
|------|------------|
| **Catalog** | [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md) |
| **Scope** | Entire production tree (or the named subtree); one delivery unit at a time per [inventory.md](inventory.md) |
| **Verification** | [characterize.md](characterize.md) then [route.md](route.md#preserve-behaviour-required): lock suite **and** working-surface commands are the baseline; prove after every code-editing step; `implement.verify=non-regression`; `test.mode=dedicated` |
| **Alignment / definition artifact** | `ADOPT.md` (path from WORKSPACE) |
| **Readiness prompt** | None — walk the route; honour named subtree or exclusions from the invoke |
| **Opening** | Thin: whole repo. Named subtree or exclusions → honour them. Existing `ADOPT.md` → resume the [route loop](route.md#route-loop) |
| **Workflow binding** | Template **structure-safe**; force `implement.verify=non-regression` and `test.mode=dedicated`. `implement.mode` per [route.md](route.md#delegation). Unit chain `characterize → architect → implement → test → restructure → review → ship` per area until Done. Honor an existing PLAN Classification when class is adopt |
| **Default table** | [route.md](route.md#delegation) |
| **Branch naming** | WORKSPACE pattern — one delivery head **per area Task** |
| **Delivery** | First PR-opening writer for the current area Task; ship closes that head; the next area starts from the updated base |
| **Structure checklist** | [structure.md](../implement/structure.md) |
| **Work package types** | Harden-shaped (extract, rename, move, split, invert); no behaviour change |
| **Handoff** | none when the route is Done; the blocking skill on a hard stop |

## Steps

1. **Resolve tree** — Resolve workspace, tracker, and the tree to adopt (repo root or named subtree). Load PLAN Classification when class is adopt. Generated, vendor, lockfiles, and documented exclusions stay out of scope. Done when the tree and out-of-scope paths are named.
2. **Inventory** — Follow [inventory.md](inventory.md) with [route.md](route.md#delegation) workers. Manager merges and sequences. Done when every area is either at the bar, a documented exception, or a sequenced row with a concrete move.
3. **Persist** — Write `ADOPT.md`; apply the [adopt tracker row](../workflow/tracker-sync.md#matrix). One Task or a Story + area Tasks. Do not confirm Order. Tree already at the bar → persist Next none, stop. Done when artifact, tracker, and Order agree.
4. **Walk the route** — Follow [route.md](route.md). Characterize the frontier (map + lock tests + working-surface proof on current code), then compose architect → implement → test → restructure → review → ship with the preserve-behaviour gate after each code-editing step; then the next open area, until Done or a hard stop. Report each shipped unit in one short line. Done when the route is empty or a hard stop is persisted.

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

## Behaviour map
| Requirement | Current behaviour | Surface | Test path | Status |
|-------------|-------------------|---------|-----------|--------|
| … | … | backend / frontend / composed / none | … | locked / gap |

## Preserve behaviour
- Required — CONCEPT_STRUCTURE Lock before restructure + Proof is the gate
- Lock-suite commands: …   # from characterize; same commands after structure
- Working-surface commands: …   # backend start/smoke, frontend build/serve/flows, composed path; same after structure
- Characterize result: green | known-fail: …
- Verification: same tests, same requirements after every code-editing step; `test.mode=dedicated`

## Frontier
- Area: …
- Packages: …

## Workflow
- Template: structure-safe
- Unit chain: characterize → architect → implement → test → restructure → review → ship
- Route: inventory → characterize → unit chain remainder per area in Order until Done
- Verify: non-regression; test.mode=dedicated; lock suite + working surfaces from characterize

## Tracker
- Story: <KEY>   # omit when one Task
- Task: <KEY>    # current frontier
- Branch: <delivery-branch>
- PR: <url or draft url>

## Next
none — route Done
```

## Tracker (after persist)

Follow the [adopt tracker row](../workflow/tracker-sync.md#matrix) and
[delivery continuity](../workflow/delivery.md). One Task when the inventory is
one delivery unit; otherwise a **Story** plus one Task per area. Non-frontier
Tasks stay **To Do** until the walk reaches them. Ship closes each area Task.
Record `ADOPT.md`, current branch/PR, and **Next** on every configured durable
surface. Story **Done** when the route is empty.

## Handoff

When the route is Done (or the tree already met the bar):

```markdown
## Next
none — catalog met on this tree
```

On a hard stop:

```markdown
## Next
`/<blocking-skill> <TASK-KEY>` — resume the unit; `/adopt` continues the route after that Task ships
```
