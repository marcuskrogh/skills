---
name: implement
description: >-
  Managed sub-agent implementation against a pipeline Task and Sub-tasks from
  define. Builds with tests and testability as first-class deliverables so
  coverage and code quality do not degrade. Moves the issue In Progress then
  In Review; supports fix-forward after review. Persists Next in markdown and
  the configured tracker.
---

# Implement

Applies [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) to the
**current repository** on the main pipeline Task.

**On invoke:** read [../concepts/CONCEPT_IMPLEMENTATION.md](../concepts/CONCEPT_IMPLEMENTATION.md),
[testing.md](testing.md), [../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Spec source** | Tracker Task + Sub-tasks + `PLAN.md` or `BUG.md` / linked specs |
| **Branch naming** | From WORKSPACE (default `<key-lowercase>-<short-description>`) |
| **Delivery** | PR (default from WORKSPACE) or branch-only |
| **Verification** | Tests (new/updated) + lint for touched area (or full suite if repo norm); coverage/quality non-degradation; plan checklist; sub-task completion; [testing.md](testing.md) |
| **Testing checklist** | [testing.md](testing.md) — paste into Implementation / Testing / fix-forward briefs |

## Modes

| Mode | When | Behavior |
|------|------|----------|
| **Build** (default) | Task To Do / In Progress | Full implementation loop with tests in-package |
| **Fix-forward** | After **review** with blockers; same Task + open PR | Address review threads only; add/adjust tests when the finding is correctness, coverage, or testability |

Post-merge follow-ups on already-shipped work use **`/iterate`** (new Task + new PR),
not fix-forward.

## Issue (required)

1. User provides key / URL
2. Or ask once: "Which issue should this implementation track?"

`fetch` Task + Sub-tasks. Prefer Tasks that already have a definition plan.

### Specification priority

1. Fix-forward: open PR review comments
2. Sub-task descriptions
3. Task description
4. `PLAN.md` or `BUG.md` / linked specs
5. User paste

## Status (tracker — mandatory)

| When | Action |
|------|--------|
| Start (build) | Task → **In Progress**; comment session start |
| Each Sub-task started | that Sub-task → **In Progress** |
| Sub-task package done | that Sub-task → **Done** + comment |
| PR ready | Task → **In Review** + comment with PR URL + **Next** `/review-fix` |
| Start (fix-forward) | Task → **In Progress** if needed; keep PR |
| Fix-forward complete | Task → **In Review** + comment + **Next** `/review-fix` (or `/review`) |

Upsert ISSUES mirror on **every** transition/handoff. Do **not** mark the parent Task **Done** (that is **ship**).

### Tracker duties

| Action | Required |
|--------|----------|
| Task In Progress → In Review | yes |
| Sub-tasks In Progress → Done as completed | yes |
| PR link on Task | yes |
| Close parent Task | **no** |

## Pre-work

1. Resolve issue + packages (or review threads)
2. Status → In Progress
3. Ask PR vs branch once (skip if fix-forward / WORKSPACE default is enough and user already chose)
4. Create or reuse branch per WORKSPACE pattern
5. Note the project's usual test/lint commands (from README, CI, package scripts, WORKSPACE)

## Testing and testability (mandatory)

Implementation maintains a **well-structured, testable** codebase. Do not treat tests
as optional polish after "real" coding.

| Rule | Practice |
|------|----------|
| **Tests with behaviour** | Every behavioural work package adds or updates tests in the same package (preferred) or a follow-on **Testing** package **before** verify |
| **Regression on bugs** | Fixes from `BUG.md` / Correctness findings include a failing-case test |
| **Design for testability** | Prefer injectable seams over hard-wired I/O, clocks, and neighbors |
| **No degradation** | Touched-area suite stays green; do not skip/delete coverage to pass; new paths get tests proportional to risk |
| **Honest verification** | Run real commands; never invent green results |

Paste [testing.md](testing.md) into Implementation, Testing, and relevant fix-forward
briefs. Evaluate every sub-agent report against the package report fields in that file.

Missing tests for new behaviour = **insufficient package** → re-delegate before moving on.

## Work packages

| Type | Subagent | Notes |
|------|----------|-------|
| Structure exploration | `explore` | Locate seams, existing test patterns, runners |
| Research | `generalPurpose` | Spike only; no production behaviour without tests planned |
| Implementation | `generalPurpose` | Code **and** tests; include [testing.md](testing.md) |
| Testing | `generalPurpose` | Coverage gaps, regression suites, hardening failure paths |
| Fix-forward | `generalPurpose` | Per review thread or grouped finding; add tests when warranted |

When drafting the plan from Sub-tasks / `PLAN.md`, ensure each behavioural package
lists test deliverables in its acceptance criteria. If the plan omitted verification,
add Testing packages explicitly — do not wait for review to invent coverage.

## PR template

- Summary
- Tracker: `<url or key>`
- Spec references (`PLAN.md` or `BUG.md`, …)
- Test plan (commands run, new/updated tests, coverage notes, any justified gaps)
- Completed sub-tasks / review threads

## Handoff

```markdown
## Next
`/review-fix <TASK-KEY>` — Review and auto-fix until clean
```

(Use `/review <TASK-KEY>` for a one-shot review without auto-fix.)

## Flow

1. Resolve issue + spec
2. In Progress
3. Branch + packages (tests in each behavioural package)
4. Verify (tests/lint/coverage non-degradation + [testing.md](testing.md)) → PR → In Review → **Next** `/review-fix`
