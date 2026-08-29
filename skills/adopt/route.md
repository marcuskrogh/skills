# Adopt route

Disclosed from [SKILL.md](SKILL.md). Load when walking the adoption route or
spawning inventory workers. Do not restate [CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md)
or [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) invariants.

## Unit chain (fixed)

Every area Task runs this chain, in order, with each skill's **full** contract
(including that skill's delegation). Read that skill when the step starts
(same progressive load as `/ship`):

`implement → test → harden → review-fix → ship`

Do not drop a step except the catalog skip rows (`test.mode=skip` docs-only or
explicit user ask; `harden.mode=skip` only when the user explicitly asked).
Do not wait for user **Next** between steps or between areas.

## Route loop

1. **Frontier** — first open row in Order (Blocked by all Done or empty).
2. **Unit** — start or reuse that Task's delivery head; run the unit chain.
3. **Advance** — mark the area **done** on `ADOPT.md`; ship has closed the Task.
   Remaining open rows stay on the Story.
4. **Continue** — if an open area remains, fetch the updated base, make it the
   frontier, and loop. Independent inventory scans may run in parallel; **apply**
   stays one delivery unit at a time (foundation before contagion).
5. **Done** — no open areas → Story **Done**; Next none.

Resume (`ADOPT.md` already exists): start at the first open row. If that Task
already has a delivery PR, run **remaining** unit-chain steps for it (same
detection as [ship remaining](../workflow/ship.md#remaining-workflow) on that
Task), then loop. Re-scan only that area unless the tree changed underfoot.

## Hard stop

Stop the loop when a composed skill reports a hard stop (merge failure, CLEAN
FAILED, gate fail after escalate exhausted, missing workspace or auth). Persist
**Next** as that skill + the current Task key. Do not skip to the next area.

User **Next** / `/adopt` / `/ship` on that key resumes the same loop.

## Delegation

Manager keeps sequence, inventory merge, closeout gates, tracker/PR, and the
walk. Score and spawn per CONCEPT_DELEGATION; pass a catalog `model` on every
`Task` type.

| Type | Subagent | Default category | Elevate when |
|------|----------|------------------|--------------|
| Inventory scan | `explore` | Mid (small, well-seamed dir → Routine / low) | Unfamiliar large area, ambiguous seams, or cycles → high |
| Implementation | per [implement](../implement/SKILL.md#work-packages) | Mid | same table |
| Testing | per implement Testing row | Mid | same table |
| Harden | per implement Harden row | Mid | same table |

`implement.mode=multiagent` when the unit has more than one package, or any
package is Moderate or Demanding. One Routine package may stay on the manager.

Inventory workers run **in parallel** across independent areas. Each brief:
area path, [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md), repo docs
and neighbour patterns in that area, return shape = catalog rows + concrete
moves + documented exceptions. Manager merges; sequence stays [inventory.md](inventory.md).
