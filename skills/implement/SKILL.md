---
name: implement
description: >-
  Implementation through managed, value-routed work packages. Reuses the
  Task's delivery branch/PR when one exists, honors a Workflow binding when
  present, and enforces tests and structure as-you-go. Use standalone, for an
  approved definition spec, or for review fix-forward.
disable-model-invocation: true
---

# Implement

Applies [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) and
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md) to the **current repository**.
When a Workflow binding is present, honor its parameters — do not reclassify.

**On invoke:** read [../concepts/CONCEPT_IMPLEMENTATION.md](../concepts/CONCEPT_IMPLEMENTATION.md),
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md),
[../concepts/CONCEPT_STRUCTURE.md](../concepts/CONCEPT_STRUCTURE.md),
[../concepts/STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md),
[testing.md](testing.md), [structure.md](structure.md),
and [../workflow/SKILL.md](../workflow/SKILL.md).
When the definition spec is absent, also read
[CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md),
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md), and
[CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md).
When `ARCHITECTURE.md` is absent, also read
[CONCEPT_ARCHITECTURE](../concepts/CONCEPT_ARCHITECTURE.md).
When `implement.verify` is `comparative` (or the spec is `REWORK.md`), also read
[rework.md](rework.md).
When `sandbox=inject` or `SANDBOX.md` is present, follow its Promote map
(production targets + copy notes).
When `implement.mode` is `multiagent` (or spawning workers otherwise), also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.
When a package changes **product surface** UI (HTML, CSS, frontend components),
also read [../frontend-design/SKILL.md](../frontend-design/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Spec source** | Tracker Task + Sub-tasks + `PLAN.md` / `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` / `ADOPT.md` / linked specs; load `RESEARCH.md` / `MODEL.md` / `SANDBOX.md` from PLAN Inputs or delivery branch when present |
| **Workflow binding** | `PLAN.md` `## Workflow` when present; else legacy fallback in [CLASSIFICATION-CATALOG.md](../concepts/CLASSIFICATION-CATALOG.md#legacy-fallback) |
| **Branch naming** | WORKSPACE pattern — **reuse** Task delivery branch if it exists |
| **Delivery** | **Same** PR as define/bug/tweak/refine/rework/adopt when one exists (or branch-only per WORKSPACE); research/model/sandbox may have started the branch without a PR |
| **Verification** | Per binding `implement.verify`: `tests` → [testing.md](testing.md); `non-regression` → behaviour unchanged + testing.md; `comparative` → [rework.md](rework.md) + testing.md. Plus [structure.md](structure.md) **manager gate**, lint, plan checklist, sub-task completion |
| **Testing checklist** | [testing.md](testing.md); comparative adds [rework.md](rework.md) |
| **Structure checklist** | [structure.md](structure.md) + [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md) |
| **Closeout gate** | [structure.md](structure.md#manager-gate-before-leaving-implement) + [testing.md](testing.md) on the **whole** diff before this skill's outcome is `built` |
| **Model routing** | CONCEPT_DELEGATION when `implement.mode=multiagent` or workers are spawned; `single` → manager may implement localized packages without workers when Routine |
| **Work package types** | See table below; add **Promote** when `SANDBOX.md` is promotion-ready |
| **PR template** | Summary; Tracker; Spec refs; Workflow binding; Test plan; Structure notes; Completed sub-tasks / review threads |

## Modes

| Mode | When | Behavior |
|------|------|----------|
| **Build** (default) | Task To Do / In Progress | Full implementation loop with tests and structure in-package |
| **Fix-forward** | After a laser or code review with must-fix findings; same Task + open PR | Address review threads only; add/adjust tests and structure for the finding axes |

## Spec priority

1. Fix-forward: open PR review comments
2. `PLAN.md` **Workflow** / **Classification** binding (do not override without user ask)
3. Sub-task descriptions
4. Task description
5. `PLAN.md` / `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` / `ADOPT.md` / linked specs
6. `RESEARCH.md` / `MODEL.md` on the delivery branch (PLAN Inputs) — supportive finding docs; use when formulating product docs, rationale, or domain-facing copy
7. `SANDBOX.md` on the delivery branch — promotion input for the sandboxed element; production paths follow its Promote map
8. User paste

Resolve issue: user key/URL, or ask once "Which issue should this implementation track?"

## Tracker status

Follow the [implementation rows](../workflow/tracker-sync.md#matrix), including
Sub-task transitions and the enabled ISSUES mirror. The parent Task remains
open for ship closeout.

## Steps

Follow the CONCEPT_IMPLEMENTATION flow with these specialisations:

1. **Resolve inputs** — Apply each Inputs row. Then apply the implementation start transition. A contained element that needs inspect-each-turn is not promotion-ready until `SANDBOX.md` has a complete `## Representativeness` and the last verdict is accept. Apply CONCEPT_SANDBOX in this invocation. On a delta, ask the one question and end the turn with the output unfinished (the workflow keeps **Next** on this skill). On accept, promote and continue. If the user ends sandbox-only, stop with outcome `end`. When the spec is `ADOPT.md` and the behaviour map is missing, still has `gap` rows, or a startable area has no working-surface rows, apply [../adopt/characterize.md](../adopt/characterize.md) in this invocation until the map is locked. Done when the usable spec, `ARCHITECTURE.md`, binding params, and active packages are known and the Task is **In Progress**.
2. **Resolve delivery and commands** — Follow [delivery continuity](../workflow/delivery.md) and inspect repository-owned test/lint commands. Done when the Task's one delivery head is checked out in this session's working tree and verification commands are recorded.
3. **Execute packages** — If `implement.mode=multiagent`, use CONCEPT_DELEGATION for workers; if `single`, keep Routine packages on the manager when safe. Include [testing.md](testing.md), [structure.md](structure.md), and [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md) in briefs. Pass-criteria rows from the definition artifact go in the brief. Fail a package that omits **spec locks** for those rows (testing.md). When spec is `ADOPT.md`, also include the Behaviour map, lock-suite commands, and working-surface commands; fail a package that rewrites lock-test expectations or that skips working-surface proof when the area owns a startable surface. Fail a package that still breaches the structure catalog, that omits the structure/testing report, or that defers catalog work to harden or lasers. Change size does not relax the briefs. When packages write product docs or domain-facing copy, pass `RESEARCH.md` / `MODEL.md` paths as brief inputs. When promoting a sandbox, follow `SANDBOX.md` Promote map into production paths. When a remaining package is a contained element that needs inspect-each-turn, apply CONCEPT_SANDBOX in this invocation until promotion-ready, then promote. When `implement.verify=comparative`, follow [rework.md](rework.md) (baseline → candidate → compare → reiterate when `implement.iteration=until-bar`). Done when all packages satisfy the spec, pass criteria, verification mode, structure catalog, Sub-task criteria, and binding.
4. **Closeout gate** — Walk the **whole** delivery diff against [structure.md](structure.md#manager-gate-before-leaving-implement) and [testing.md](testing.md) (including **Working surfaces** and **spec locks**). Remaining catalog breaches, missing reports, missing spec locks, missing tests, or missing working-surface proof → re-delegate and stay in this skill. Done when the gate holds or every remainder is a documented exception.
5. **Verify and deliver** — Run the recorded checks, update the same PR (include binding summary, test plan, and structure notes), and apply the implementation tracker row. Keep the Task **In Progress**. Record outcome `built`, or `fixed` when this invocation was fix-forward (return the Task to **In Review**). Apply the workflow transition. Done when checks pass, the gate holds, and the PR and mirrors are current.

## Work packages

| Type | Subagent | Default category | Elevate when |
|------|----------|------------------|--------------|
| Structure exploration | `explore` | Mid | Unfamiliar large area with ambiguous seams → high |
| Research | `generalPurpose` | Mid | Novel domain spike with conflicting approaches → high |
| Implementation | `generalPurpose` | Mid (Routine → low) | Novel design, security/authz, concurrency, large cross-cutting → high |
| Testing | `generalPurpose` | Mid (Routine → low) | Flaky tests, concurrency tests, subtle regression isolation → high |
| Harden | `generalPurpose` | Mid (Routine → low) | Large structural split, layer inversion, cycle break → high |
| Comparative eval | `generalPurpose` | Mid | Novel eval setup, control/performance isolation, conflicting metrics → high |
| Promote | `generalPurpose` | Mid (Routine → low) | Sandbox spans many production seams or public API → high |
| Fix-forward | `generalPurpose` | Low (obvious) / Mid otherwise | Architectural must-fixes, subtle correctness/races, prior lower-tier miss → next tier / high |

Ensure each behavioural package lists spec locks and structure notes; if the plan omitted verification, add Testing packages before verify. For comparative verify, ensure Baseline / Compare / Reiterate packages exist per [rework.md](rework.md). A Harden package during Build repairs catalog breaches in-package; it does not replace `/restructure`.

## Inputs

| Input | When present | When absent |
|-------|----------------|-------------|
| Definition spec (`PLAN.md`, `BUG.md`, `TWEAK.md`, `REFINE.md`, `REWORK.md`, `ITERATE.md`, or `ADOPT.md`) | Apply it, including pass criteria and any Workflow binding | Define it in this invocation (CONCEPT_ALIGNMENT, CONCEPT_DEFINITION, CONCEPT_CLASSIFICATION) and write that spec, then apply it |
| `ARCHITECTURE.md` | Apply the shape. Do not ignore it | Apply CONCEPT_ARCHITECTURE in this invocation, write `ARCHITECTURE.md`, then apply it |
| `RESEARCH.md`, `MODEL.md` | Apply when writing product docs or domain-facing copy | Continue without them |
| `SANDBOX.md` | Apply the promote map when promotion-ready | When the element needs an inspect-loop, define the sandbox in this invocation until accept |

## Output

delivery diff — packages on the delivery branch/PR, with spec locks and the structure gate held. Outcome: `built`, or `fixed` for fix-forward.

This skill does not name a successor. Apply the workflow transition before the turn ends. Do not skip a closeout phase from this skill; the bound chain decides.
