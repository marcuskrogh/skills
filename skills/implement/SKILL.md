---
name: implement
description: >-
  Managed sub-agent implementation against a pipeline Task and Sub-tasks from
  define. Reuses the Task’s existing delivery branch/PR (does not open a parallel
  implement-only PR). Scores package difficulty across low/mid/high capability
  tiers (Routine → low, Moderate → mid, Demanding → high); manager stays
  high-capability. Builds with tests and testability as first-class deliverables
  so coverage and code quality do not degrade. Moves the issue In Progress then
  In Review; supports fix-forward after review. Persists Next in markdown and the
  configured tracker.
disable-model-invocation: true
---

# Implement

Applies [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) to the
**current repository** on the main pipeline Task.

**On invoke:** read [../concepts/CONCEPT_IMPLEMENTATION.md](../concepts/CONCEPT_IMPLEMENTATION.md),
[../concepts/CONCEPT_DELEGATION.md](../concepts/CONCEPT_DELEGATION.md)
(and [../concepts/PLATFORM-CATALOGS.md](../concepts/PLATFORM-CATALOGS.md) when assigning models),
[testing.md](testing.md), [../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Spec source** | Tracker Task + Sub-tasks + `PLAN.md` or `BUG.md` / linked specs |
| **Branch naming** | WORKSPACE pattern — **reuse** Task delivery branch if it exists |
| **Delivery** | **Same** PR as define/bug/research when one exists (or branch-only per WORKSPACE) |
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

Post-merge follow-ups → `/iterate`, not fix-forward.

## Spec priority

1. Fix-forward: open PR review comments
2. Sub-task descriptions
3. Task description
4. `PLAN.md` or `BUG.md` / linked specs
5. User paste

Resolve issue: user key/URL, or ask once "Which issue should this implementation track?"

## Tracker status

| When | Action |
|------|--------|
| Start (build) | Task → **In Progress**; comment session start |
| Each Sub-task started | Sub-task → **In Progress** |
| Sub-task package done | Sub-task → **Done** + comment |
| PR ready / fix-forward complete | Task → **In Review** + comment with PR URL + **Next** `/review-fix` |
| Start (fix-forward) | Task → **In Progress** if needed; keep PR |

Upsert ISSUES mirror on every transition. Parent Task **Done** is **ship** only.

| Action | Required |
|--------|----------|
| Task In Progress → In Review | yes |
| Sub-tasks In Progress → Done as completed | yes |
| PR link on Task | yes |
| Close parent Task | **no** |

## Steps

1. Resolve issue + packages (or review threads) → In Progress.
2. **Delivery branch (mandatory reuse):** resolve existing open branch/PR for this Task; else create once. Never a parallel implement-only PR. See [delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop).
3. Note project test/lint commands from environment (README, CI, package scripts, WORKSPACE).
4. Draft/execute packages per CONCEPT_IMPLEMENTATION + CONCEPT_DELEGATION. Paste [testing.md](testing.md) into briefs; missing tests for new behaviour = insufficient → re-delegate.
5. Verify → same PR ready → In Review → **Next**.

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
