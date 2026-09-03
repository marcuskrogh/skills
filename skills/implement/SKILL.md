---
name: implement
description: >-
  Implementation of a pipeline Task through managed, value-routed work
  packages. Reuses the Task's delivery branch/PR, honors PLAN.md Workflow
  binding when present, enforces tests and structure as-you-go, and hands
  off to the bound testing phase. Use for an approved PLAN.md, BUG.md,
  TWEAK.md, REFINE.md, REWORK.md, ITERATE.md, ADOPT.md, or review fix-forward.
disable-model-invocation: true
---

# Implement

Applies [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) to the
**current repository** on the main pipeline Task. When `PLAN.md` has a
**Workflow** binding (from define + [CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md)),
honor its parameters — do not reclassify.

**On invoke:** read [../concepts/CONCEPT_IMPLEMENTATION.md](../concepts/CONCEPT_IMPLEMENTATION.md),
[../concepts/CONCEPT_STRUCTURE.md](../concepts/CONCEPT_STRUCTURE.md),
[../concepts/STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md),
[testing.md](testing.md), [structure.md](structure.md),
and [../workflow/SKILL.md](../workflow/SKILL.md).
When `implement.verify` is `comparative` (or the spec is `REWORK.md`), also read
[rework.md](rework.md).
When `sandbox=inject` or `SANDBOX.md` is present, follow its Promote map
(production targets + copy notes).
When `implement.mode` is `multiagent` (or spawning workers otherwise), also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.

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
| **Closeout gate** | [structure.md](structure.md#manager-gate-before-next-test) + [testing.md](testing.md) on the **whole** diff before `/test` |
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

1. **Resolve work and status** — Resolve the Task, spec, Workflow binding (or legacy fallback), Sub-tasks or review threads, and any `RESEARCH.md` / `MODEL.md` / `SANDBOX.md` on the delivery branch (PLAN Inputs); then apply the implementation start transition. If `sandbox=inject` (or post-merge sandbox) and `SANDBOX.md` is not promotion-ready (`## Representativeness` incomplete or last verdict is not accept), hand off `/sandbox` instead of implementing that element in production. If spec is `ADOPT.md` and the Behaviour map is missing, still has `gap` rows, or a startable area has no working-surface rows, persist Next `/adopt` (characterize) and stop. Done when the usable spec, binding params, finding-doc/sandbox inputs, and active packages are known and the Task is **In Progress** (or Next is `/sandbox` or `/adopt`).
2. **Resolve delivery and commands** — Follow [delivery continuity](../workflow/delivery.md) and inspect repository-owned test/lint commands. Done when the Task's one delivery head is checked out and verification commands are recorded.
3. **Execute packages** — If `implement.mode=multiagent`, use CONCEPT_DELEGATION for workers; if `single`, keep Routine packages on the manager when safe. Include [testing.md](testing.md), [structure.md](structure.md), and [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md) in briefs. Pass-criteria rows from the definition artifact go in the brief. Fail a package that omits **spec locks** for those rows (testing.md). When spec is `ADOPT.md`, also include the Behaviour map, lock-suite commands, and working-surface commands; fail a package that rewrites lock-test expectations or that skips working-surface proof when the area owns a startable surface. Fail a package that still breaches the structure catalog, that omits the structure/testing report, or that defers catalog work to harden or lasers. Change size does not relax the briefs. When packages write product docs or domain-facing copy, pass `RESEARCH.md` / `MODEL.md` paths as brief inputs. When promoting a sandbox, follow `SANDBOX.md` Promote map into production paths. When a remaining package is a contained element that needs inspect-each-turn, hand off `/sandbox` rather than iterating on production. When `implement.verify=comparative`, follow [rework.md](rework.md) (baseline → candidate → compare → reiterate when `implement.iteration=until-bar`). Done when all packages satisfy the spec, pass criteria, verification mode, structure catalog, Sub-task criteria, and binding.
4. **Closeout gate** — Walk the **whole** delivery diff against [structure.md](structure.md#manager-gate-before-next-test) and [testing.md](testing.md) (including **Working surfaces** and **spec locks**). Remaining catalog breaches, missing reports, missing spec locks, missing tests, or missing working-surface proof → re-delegate; do not hand off. Done when the gate holds or every remainder is a documented exception.
5. **Verify and deliver** — Run the recorded checks, update the same PR (include binding summary, test plan, and structure notes), apply the implementation tracker row, and persist **Next** `/test` (then the bound chain includes `/restructure`). Keep the Task **In Progress**. Fix-forward during review returns **In Review**. Done when checks pass, the gate holds, the PR and mirrors are current, and **Next** is recorded.

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

## Handoff

Prefer the next step in the bound **Chain**. Default after Build:

```markdown
## Next
`/test <TASK-KEY>` — Dedicated testing phase, then restructure, then review
```

When `test.mode=skip` (docs-only or explicit user ask) and class is not adopt, Next is `/restructure`.
Adopt / `ADOPT.md` always Next `/test`. Do not skip `/restructure` from implement. Fix-forward invoked from review
returns to that orchestrator — do not rewrite Next to `/test`.

(Use `/ship <TASK-KEY>` to finish remaining along the bound chain.)
