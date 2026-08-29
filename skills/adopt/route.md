# Adopt route

Disclosed from [SKILL.md](SKILL.md). Load when walking the adoption route or
spawning inventory workers. Do not restate [CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md)
or [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) invariants.

## Preserve behaviour (required)

This workflow's verification slot is [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md)
**Proof is the gate**. Apply it as follows:

| Gate | Check | Fail → |
|------|--------|--------|
| **Baseline** | Before the first structural edit on the unit, record commands and result (green, or a known-fail list). | Hard stop if no runnable suite exists |
| **After every code-editing step** | Re-run the same commands after implement, test, harden, and review-fix. | Hard stop on new fails, skipped/weakened tests, or a missing run |
| **Dedicated test** | `test.mode=dedicated` and `implement.verify=non-regression` on every unit that touched executable code. | Do not honour `test.mode=skip` |
| **Advance** | Ship and the next area wait until the gate holds. | Do not mark the area done; do not start the next area |

A package that changes observable behaviour is out of scope (tweak / rework /
feature). Revert it or hard-stop; do not fold it into adopt.

Worker briefs include the baseline commands and this gate. Inventory scans do
not edit code; they still name how the area's suite is run.

## Unit chain (fixed)

Every area Task runs this chain, in order, with each skill's **full** contract
(including that skill's delegation). Read that skill when the step starts
(same progressive load as `/ship`):

`implement → test → harden → review-fix → ship`

Do not drop `/test` or `/harden` on adopt. Do not wait for user **Next** between
steps or between areas. Run the preserve-behaviour gate after each code-editing
step before starting the next step.

## Route loop

1. **Frontier** — first open row in Order (Blocked by all Done or empty).
2. **Baseline** — record suite/lint commands and result for that area.
3. **Unit** — start or reuse that Task's delivery head; run the unit chain with
   the preserve-behaviour gate after each code-editing step.
4. **Advance** — only when the gate holds: mark the area **done** on `ADOPT.md`;
   ship has closed the Task. Remaining open rows stay on the Story.
5. **Continue** — if an open area remains, fetch the updated base, make it the
   frontier, and loop. Independent inventory scans may run in parallel; **apply**
   stays one delivery unit at a time (foundation before contagion).
6. **Done** — no open areas → Story **Done**; Next none.

Resume (`ADOPT.md` already exists): start at the first open row. If that Task
already has a delivery PR, run **remaining** unit-chain steps for it (same
detection as [ship remaining](../workflow/ship.md#remaining-workflow) on that
Task), then loop. Re-scan only that area unless the tree changed underfoot.
Re-use the recorded baseline; re-baseline only when the commands changed.

## Hard stop

Stop the loop when a composed skill reports a hard stop (merge failure, CLEAN
FAILED, gate fail after escalate exhausted, missing workspace or auth) **or**
the preserve-behaviour gate fails. Persist **Next** as that skill + the current
Task key (or `/test` when the suite is the blocker). Do not skip to the next
area.

User **Next** / `/adopt` / `/ship` on that key resumes the same loop.

## Delegation

Manager keeps sequence, inventory merge, closeout gates, the preserve-behaviour
gate, tracker/PR, and the walk. Score and spawn per CONCEPT_DELEGATION; pass a
catalog `model` on every `Task` type.

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
and neighbour patterns in that area, how to run that area's suite, return shape
= catalog rows + concrete moves + documented exceptions + suite commands.
Manager merges; sequence stays [inventory.md](inventory.md).
