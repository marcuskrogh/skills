# Adopt route

Disclosed from [SKILL.md](SKILL.md). Load when walking the adoption route or
spawning inventory workers. Do not restate [CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md)
or [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) invariants.

## Preserve behaviour (required)

This workflow's verification slot is [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md)
**Lock before restructure** and **Proof is the gate**. Apply them as follows:

| Gate | Check | Fail → |
|------|--------|--------|
| **Characterize** | [characterize.md](characterize.md) map + lock suite **and** working-surface commands green on **current** code before any structure package. | Hard stop; do not start implement structure |
| **Baseline** | Lock-suite commands, working-surface commands, and result from characterize are the unit baseline. | Hard stop if characterize has not run |
| **Working surfaces** | Baseline includes every surface the area owns: startable backend, startable frontend, composed client-server path. Re-run after every code-editing step. | Hard stop if a surface does not start, a mapped UI/API flow fails, or working-surface commands are missing from the baseline |
| **After every code-editing step** | Re-run those same commands after implement, test, harden, and review-fix. Same requirements, same expected results. | Hard stop on new fails, rewritten expectations, skipped/weakened lock tests, or a missing run |
| **Dedicated test** | `test.mode=dedicated` and `implement.verify=non-regression`. `/test` after structure hunts gaps (including working surfaces); it does not replace characterize. | Do not honour `test.mode=skip` |
| **Advance** | Ship and the next area wait until the gate holds. | Do not mark the area done; do not start the next area |

A package that changes observable behaviour, or that edits lock-test
expectations to pass, is out of scope (tweak / rework / feature). Revert it or
hard-stop.

Worker briefs include the behaviour map, lock-suite commands, working-surface
commands, and this gate.

## Unit chain (fixed)

Every area Task runs this chain, in order, with each skill's **full** contract
(including that skill's delegation). Read that skill when the step starts
(same progressive load as `/ship`):

`characterize → implement → test → harden → review-fix → ship`

Characterize is [characterize.md](characterize.md) (this skill). The later
steps are the pipeline skills of those names. Do not drop characterize, `/test`,
or `/harden` on adopt. Do not wait for user **Next** between steps or between
areas. Run the preserve-behaviour gate after each code-editing step before
starting the next step.

## Route loop

1. **Frontier** — first open row in Order (Blocked by all Done or empty).
2. **Characterize** — map, lock, prove on current code ([characterize.md](characterize.md)).
3. **Unit** — start or reuse that Task's delivery head; run implement → test →
   harden → review-fix → ship with the preserve-behaviour gate after each
   code-editing step.
4. **Advance** — only when the gate holds: mark the area **done** on `ADOPT.md`;
   ship has closed the Task. Remaining open rows stay on the Story.
5. **Continue** — if an open area remains, fetch the updated base, make it the
   frontier, and loop. Independent inventory scans may run in parallel; **apply**
   stays one delivery unit at a time (foundation before contagion).
6. **Done** — no open areas → Story **Done**; Next none.

Resume (`ADOPT.md` already exists): start at the first open row. If characterize
is already locked and green, skip to remaining unit-chain steps (same detection
as [ship remaining](../workflow/ship.md#remaining-workflow) on that Task). Re-scan
only that area unless the tree changed underfoot. Re-use the recorded behaviour
map; re-characterize only when seams changed.

## Hard stop

Stop the loop when a composed skill reports a hard stop (merge failure, CLEAN
FAILED, gate fail after escalate exhausted, missing workspace or auth) **or**
the preserve-behaviour gate fails. Persist **Next** as that skill + the current
Task key (or `/adopt` when characterize is the blocker). Do not skip to the next
area.

User **Next** / `/adopt` / `/ship` on that key resumes the same loop.

## Delegation

Manager keeps sequence, inventory merge, behaviour-map merge, closeout gates,
the preserve-behaviour gate, tracker/PR, and the walk. Score and spawn per
CONCEPT_DELEGATION; pass a catalog `model` on every `Task` type.

| Type | Subagent | Default category | Elevate when |
|------|----------|------------------|--------------|
| Inventory scan | `explore` | Mid (small, well-seamed dir → Routine / low) | Unfamiliar large area, ambiguous seams, or cycles → high |
| Characterize map | `explore` | Mid | Ambiguous seams, undocumented public behaviour → high |
| Characterize lock tests | per [implement](../implement/SKILL.md#work-packages) Testing row | Mid | No harness, flaky area, concurrency, startable UI/service with no E2E → high |
| Implementation | per implement table | Mid | same table |
| Testing | per implement Testing row | Mid | same table |
| Harden | per implement Harden row | Mid | same table |

`implement.mode=multiagent` when the unit has more than one package, or any
package is Moderate or Demanding. One Routine package may stay on the manager.

Inventory and characterize-map workers may run **in parallel** across
independent areas. Each characterize brief: area path, seams to map, existing
tests, working surfaces to prove, [testing.md](../implement/testing.md). Return
shape = behaviour-map rows + lock tests + suite commands + working-surface
commands. Manager merges; sequence stays [inventory.md](inventory.md).
GUI working-surface proof stays on the manager when the harness manager path
covers it; spawn `computerUse` only when a worker must drive the UI.
