---
name: implement
description: >-
  Implementation of a pipeline Task through managed, value-routed work
  packages. Reuses the Task's delivery branch/PR, verifies code and tests, and
  moves the Task from In Progress to In Review. Use for an approved PLAN.md,
  BUG.md, TWEAK.md, ITERATE.md, or review fix-forward.
disable-model-invocation: true
---

# Implement

Applies [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) to the
**current repository** on the main pipeline Task.

**On invoke:** read [../concepts/CONCEPT_IMPLEMENTATION.md](../concepts/CONCEPT_IMPLEMENTATION.md),
[testing.md](testing.md), [../workflow/reference.md](../workflow/reference.md),
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
| **Spec source** | Tracker Task + Sub-tasks + `PLAN.md` / `BUG.md` / `TWEAK.md` / linked specs |
| **Branch naming** | WORKSPACE pattern — **reuse** Task delivery branch if it exists |
| **Delivery** | **Same** PR as define/bug/tweak/research when one exists (or branch-only per WORKSPACE) |
| **Verification** | Tests + lint for touched area (or full suite if repo norm); non-degradation; plan checklist; sub-task completion; [testing.md](testing.md) |
| **Testing checklist** | [testing.md](testing.md) — paste into Implementation / Testing / fix-forward briefs |
| **Model routing** | CONCEPT_DELEGATION — score each package; escalate one tier after failed attempts |
| **Work package types** | See table below |
| **PR template** | Summary; Tracker; Spec refs; Test plan; Completed sub-tasks / review threads |

## Modes

| Mode | When | Behavior |
|------|------|----------|
| **Build** (default) | Task To Do / In Progress | Full implementation loop with tests in-package |
| **Fix-forward** | After review with must-fix findings; same Task + open PR | Address review threads only; add/adjust tests for correctness/coverage/testability findings |

## Spec priority

1. Fix-forward: open PR review comments
2. Sub-task descriptions
3. Task description
4. `PLAN.md` / `BUG.md` / `TWEAK.md` / linked specs
5. User paste

Resolve issue: user key/URL, or ask once "Which issue should this implementation track?"

## Tracker status

Follow the [implementation rows](../workflow/tracker-sync.md#matrix), including
Sub-task transitions and the enabled ISSUES mirror. The parent Task remains
open for ship closeout.

## Steps

Follow the CONCEPT_IMPLEMENTATION flow with these specialisations:

1. **Resolve work and status** — Resolve the Task, spec, Sub-tasks or review threads, then apply the implementation start transition. Done when the usable spec and active packages are known and the Task is **In Progress**.
2. **Resolve delivery and commands** — Follow [delivery continuity](../workflow/delivery.md) and inspect repository-owned test/lint commands. Done when the Task's one delivery head is checked out and verification commands are recorded.
3. **Execute packages** — Use CONCEPT_DELEGATION for every worker and include [testing.md](testing.md) in implementation, testing, and fix-forward briefs. Done when all packages satisfy the spec, behavioural tests, and Sub-task completion criteria.
4. **Verify and deliver** — Run the recorded checks, update the same PR, apply the implementation tracker row, and persist the Handoff. Done when checks pass, the Task is **In Review**, the PR and mirrors are current, and **Next** is recorded.

## Work packages

| Type | Subagent | Default category | Elevate when |
|------|----------|------------------|--------------|
| Structure exploration | `explore` | Mid | Unfamiliar large area with ambiguous seams → high |
| Research | `generalPurpose` | Mid | Novel domain spike with conflicting approaches → high |
| Implementation | `generalPurpose` | Mid (Routine → low) | Novel design, security/authz, concurrency, large cross-cutting → high |
| Testing | `generalPurpose` | Mid (Routine → low) | Flaky harness, concurrency tests, subtle regression isolation → high |
| Fix-forward | `generalPurpose` | Low (obvious) / Mid otherwise | Architectural must-fixes, subtle correctness/races, prior lower-tier miss → next tier / high |

Ensure each behavioural package lists test deliverables; if the plan omitted verification, add Testing packages before verify.

## Handoff

```markdown
## Next
`/review-fix <TASK-KEY>` — Review and auto-fix (single pass)
```

(Use `/review <TASK-KEY>` for one-shot review without auto-fix.
Or `/ship <TASK-KEY>` to finish remaining: review-fix → closeout.)
