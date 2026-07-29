---
name: bug
description: >-
  Fast bug-report alignment that replaces explore and define for defects.
  Produces BUG.md and a single tracker Task (optional Sub-tasks), then hands off
  to implement → review → ship. Use when fixing a bug without a full feature pipeline.
---

# Bug

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **defect**.
Lightweight alternative to **explore** + **define** for the
[bug fix workflow](../workflow/reference.md#bug-fix-workflow).

**On invoke:** read [../concepts/CONCEPT_ALIGNMENT.md](../concepts/CONCEPT_ALIGNMENT.md),
[../concepts/CONCEPT_DEFINITION.md](../concepts/CONCEPT_DEFINITION.md),
[../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | A bug, regression, or incorrect behaviour in the codebase |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | Repro, expected vs actual, impact, and fix acceptance are clear enough to implement |
| **Alignment / definition artifact** | `BUG.md` (path from WORKSPACE; default repo root or `docs/`) |
| **Readiness prompt** | "Is this enough to implement the fix?" |
| **Depth** | Lightweight — prefer fewer questions than full feature define |

### Probes

- What breaks (symptom) — one concrete failure
- How to reproduce (minimal steps, environment if relevant)
- Expected vs actual behaviour
- Impact / severity (user-facing, data, security, flaky test, …)
- Suspected area (file, module, service) if the user knows — do not deep-dive code yet
- Acceptance for the fix (how we know it is fixed)
- Out of scope (related cleanups that must wait)
- Optional: link to parent Story / existing Task if this bug blocks a phase

### Opening

| Context | First move |
|---------|------------|
| **Thin** | "What is broken?" |
| **Rich** (stack trace, steps already pasted) | First question on the highest-impact gap (often expected vs actual, or acceptance) |

### Scope guard

- No feature definition or roadmap work — if it is clearly a feature, redirect to `/explore` or `/define`
- No implementation or file edits during alignment
- Keep the loop short — prefer fewer questions than define; stop when implementable

## Alignment artifact

```markdown
# Bug: [title]

## Summary
- …

## Repro
1. …

## Expected
- …

## Actual
- …

## Impact
- …

## Suspected area
- …

## Acceptance criteria
- …

## Out of scope
- …

## Work packages
1. …   # optional; omit if a single fix commit is enough

## Tracker
- Task: <KEY>
- Sub-tasks: … (if any)
- Branch: <delivery-branch>
- PR: <url or draft url>

## Next
`/implement <KEY>` — Fix per BUG.md (same branch/PR)
```

## Tracker (after approval)

1. Create a **Task** (type/label **bug** when the provider supports it — e.g. GitHub label `bug`, Jira Bug issue type if available, else Task with `[Bug]` prefix).
2. Description = summary + repro + expected/actual + acceptance; `attach_or_link` `BUG.md`.
3. Optional **Sub-tasks** only when work packages are truly separate (repro test vs fix vs docs). Prefer **no** Sub-tasks for small fixes.
4. Status **To Do**.
5. **Delivery branch:** create (or reuse) the Task’s delivery branch per WORKSPACE;
   write `BUG.md` there; open a **draft** PR when `Open PR by default`. This is the
   same PR implement/review/ship will use — see
   [delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop).
6. `comment` with path + **branch** + **PR URL** + **Next**. Upsert ISSUES mirror.
7. If linked to a parent Story/Task, `link` and comment there.
8. Report key/URL, branch/PR, and **Next**. Session ends.

Do **not** create a Story for a lone bug unless the user asks.

### Tracker duties

| Action | Required |
|--------|----------|
| Create Task (+ optional Sub-tasks) | yes |
| Start delivery branch + draft PR when committing BUG.md | yes |
| Status | **To Do** |
| Comment + branch/PR + **Next** | yes |
| ISSUES mirror | yes when enabled |
| Close | no |
| Second bug-only PR | **no** |

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Fix per BUG.md on the same delivery branch/PR
```

(Or `/ship <TASK-KEY>` to finish remaining: implement → review-fix → closeout.)

Then the shared delivery loop: **implement → review-fix → ship** (one branch/PR,
closed-loop). `/ship` alone can run that remaining tail from this point.

If the bug is a follow-up on work that **just shipped** and the user wants one invoke
through a new PR, prefer **`/iterate`** instead of `/bug` → `/implement`.

## Examples

User: `/bug` — chart shows NaN after midnight UTC.

Agent: What are the minimal steps to reproduce it?
