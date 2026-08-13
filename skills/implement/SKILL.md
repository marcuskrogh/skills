---
name: implement
description: >-
  Implementation of a pipeline Task through managed, value-routed work
  packages. Reuses the Task's delivery branch/PR, honors PLAN.md Workflow
  binding when present, verifies code and tests, and moves the Task from In
  Progress to In Review. Use for an approved PLAN.md, BUG.md, TWEAK.md,
  REFINE.md, REWORK.md, ITERATE.md, or review fix-forward.
disable-model-invocation: true
---

# Implement

Applies [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) to the
**current repository** on the main pipeline Task. When `PLAN.md` has a
**Workflow** binding (from define + [CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md)),
honor its parameters — do not reclassify.

**On invoke:** read [../concepts/CONCEPT_IMPLEMENTATION.md](../concepts/CONCEPT_IMPLEMENTATION.md),
[testing.md](testing.md), [../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).
When `implement.verify` is `comparative` (or the spec is `REWORK.md`), also read
[rework.md](rework.md).
When `implement.mode` is `multiagent` (or spawning workers otherwise), also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.
When packages touch **product surfaces** (UI / frontend), also read
[CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md) and
[FRONTEND-CRAFT.md](../concepts/FRONTEND-CRAFT.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Spec source** | Tracker Task + Sub-tasks + `PLAN.md` / `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` / linked specs; load `RESEARCH.md` / `MODEL.md` from PLAN Inputs or delivery branch when present |
| **Workflow binding** | `PLAN.md` `## Workflow` when present; else legacy fallback in [CLASSIFICATION-CATALOG.md](../concepts/CLASSIFICATION-CATALOG.md#legacy-fallback) |
| **Branch naming** | WORKSPACE pattern — **reuse** Task delivery branch if it exists |
| **Delivery** | **Same** PR as define/bug/tweak/refine/rework when one exists (or branch-only per WORKSPACE); research/model may have started the branch with finding docs only |
| **Verification** | Per binding `implement.verify`: `tests` → [testing.md](testing.md); `non-regression` → behaviour unchanged + testing.md; `comparative` → [rework.md](rework.md) + testing.md. Plus lint, plan checklist, sub-task completion |
| **Testing checklist** | [testing.md](testing.md); comparative adds [rework.md](rework.md) |
| **Model routing** | CONCEPT_DELEGATION when `implement.mode=multiagent` or workers are spawned; `single` → manager may implement localized packages without workers when Routine |
| **Work package types** | See table below |
| **PR template** | Summary; Tracker; Spec refs; Workflow binding; Test plan; Completed sub-tasks / review threads |

## Modes

| Mode | When | Behavior |
|------|------|----------|
| **Build** (default) | Task To Do / In Progress | Full implementation loop with tests in-package |
| **Fix-forward** | After review with must-fix findings; same Task + open PR | Address review threads only; add/adjust tests for correctness/coverage/testability findings |

## Spec priority

1. Fix-forward: open PR review comments
2. `PLAN.md` **Workflow** / **Classification** binding (do not override without user ask)
3. Sub-task descriptions
4. Task description
5. `PLAN.md` / `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` / linked specs
6. `RESEARCH.md` / `MODEL.md` on the delivery branch (PLAN Inputs) — supportive finding docs; use when formulating product docs, rationale, or domain-facing copy
7. User paste

Resolve issue: user key/URL, or ask once "Which issue should this implementation track?"

## Tracker status

Follow the [implementation rows](../workflow/tracker-sync.md#matrix), including
Sub-task transitions and the enabled ISSUES mirror. The parent Task remains
open for ship closeout.

## Steps

Follow the CONCEPT_IMPLEMENTATION flow with these specialisations:

1. **Resolve work and status** — Resolve the Task, spec, Workflow binding (or legacy fallback), Sub-tasks or review threads, and any `RESEARCH.md` / `MODEL.md` on the delivery branch (PLAN Inputs); then apply the implementation start transition. Done when the usable spec, binding params, finding-doc inputs, and active packages are known and the Task is **In Progress**.
2. **Resolve delivery and commands** — Follow [delivery continuity](../workflow/delivery.md) and inspect repository-owned test/lint commands. Done when the Task's one delivery head is checked out and verification commands are recorded.
3. **Execute packages** — If `implement.mode=multiagent`, use CONCEPT_DELEGATION for workers; if `single`, keep Routine packages on the manager when safe. Include [testing.md](testing.md) in briefs. When packages write product docs or domain-facing copy, pass `RESEARCH.md` / `MODEL.md` paths as brief inputs. When packages write **product-surface** UI, include [CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md) and [FRONTEND-CRAFT.md](../concepts/FRONTEND-CRAFT.md) in the brief. When `implement.verify=comparative`, follow [rework.md](rework.md) (baseline → candidate → compare → reiterate when `implement.iteration=until-bar`). Done when all packages satisfy the spec, verification mode, Sub-task criteria, and binding.
4. **Verify and deliver** — Run the recorded checks, update the same PR (include binding summary), apply the implementation tracker row, and persist **Next** from the bound **Chain** (usually `/review-fix`). Done when checks pass, the Task is **In Review**, the PR and mirrors are current, and **Next** is recorded.

## Work packages

| Type | Subagent | Default category | Elevate when |
|------|----------|------------------|--------------|
| Structure exploration | `explore` | Mid | Unfamiliar large area with ambiguous seams → high |
| Research | `generalPurpose` | Mid | Novel domain spike with conflicting approaches → high |
| Implementation | `generalPurpose` | Mid (Routine → low) | Novel design, security/authz, concurrency, large cross-cutting → high. UI packages follow CONCEPT_FRONTEND |
| Testing | `generalPurpose` | Mid (Routine → low) | Flaky harness, concurrency tests, subtle regression isolation → high |
| Comparative eval | `generalPurpose` | Mid | Novel harness, control/performance isolation, conflicting metrics → high |
| Fix-forward | `generalPurpose` | Low (obvious) / Mid otherwise | Architectural must-fixes, subtle correctness/races, prior lower-tier miss → next tier / high |

Ensure each behavioural package lists test deliverables; if the plan omitted verification, add Testing packages before verify. For comparative verify, ensure Baseline / Compare / Reiterate packages exist per [rework.md](rework.md).

## Handoff

Prefer the next step in the bound **Chain**. Default:

```markdown
## Next
`/review-fix <TASK-KEY>` — Review and auto-fix per Workflow binding
```

(Use `/review <TASK-KEY>` for one-shot review without auto-fix.
Or `/ship <TASK-KEY>` to finish remaining: review-fix → closeout.)
