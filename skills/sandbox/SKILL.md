---
name: sandbox
description: >-
  Sandbox for isolated, representative inspect-loop development of a contained
  UI, method, or bench. Produces SANDBOX.md and a runnable isolation tree outside
  production paths so each iteration can be inspected (screenshot, plot, report)
  without shipping the product. Use standalone; as a bound workflow step
  (`sandbox: inject`); when implement hits an element that needs an inspect-loop;
  or post-merge instead of iterate when each turn needs complex inspection.
disable-model-invocation: true
---

# Sandbox

Applies [CONCEPT_SANDBOX](../concepts/CONCEPT_SANDBOX.md) to one **element**.
Optional pipeline step — before **implement**, mid-implement, or **post-merge
instead of iterate** when each turn needs inspectables. Produces **promotion
input** on the delivery branch (no sandbox PR). The isolation tree is **representative**
before the inspect-loop starts.

**On invoke:** read [CONCEPT_SANDBOX](../concepts/CONCEPT_SANDBOX.md),
[kinds.md](kinds.md), and [../workflow/SKILL.md](../workflow/SKILL.md). When a
relevant-area gap needs operator agreement, also read
[CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md). When spawning Task /
sub-agents of any type, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Element** | Contained UI/UX slice, method, or bench named on invoke, PLAN, implement package, or post-merge delta |
| **Kind** | `visual` or `measure` — infer from the element; confirm only when costly |
| **Run command** | Per [kinds.md](kinds.md) |
| **Isolation path** | `sandbox/<slug>/` under WORKSPACE Sandbox root |
| **Artifact** | `SANDBOX.md` (path from WORKSPACE) |
| **Representativeness** | Required `## Representativeness` — relevant-area map from [kinds.md](kinds.md); first inspectable only after the map is demonstrated |
| **Bar** | From PLAN/REWORK parity bar or invoke; required for measure |
| **Promote map** | Production target paths + what to copy |
| **Pipeline continuity** | Commit the isolation tree + `SANDBOX.md` onto the delivery branch; never open a PR. Post-merge: new Task + branch from base (Relates → prior), same as iterate lineage without a sandbox PR |
| **Handoff defaults** | `/sandbox` (delta) / `/implement` (accept) / none |
| **Model routing** | CONCEPT_DELEGATION for every Task spawn (`computerUse`, `videoReview`, packages) |

## Steps

Follow CONCEPT_SANDBOX flow. Specialisations:

1. **Resolve** — Load Task, PLAN/REWORK, existing `SANDBOX.md`, and the named element. Post-merge: resolve prior shipped Task + merged PR (same Prior context as [iterate](../iterate/SKILL.md)). Infer kind; require a thin element description or ask once. For measure, require or record the bar. Done when element, kind, isolation path, bar-if-measure, and lineage (if post-merge) are known.
2. **Represent** — Build the relevant-area map per [kinds.md](kinds.md). One CONCEPT_ALIGNMENT question when completeness of that map is a divergence. Do not start the inspect-loop while a relevant area is missing and unwaived. Done when `## Representativeness` is complete and the isolation tree can demonstrate each reproduced area.
3. **Isolate** — Create or resume the isolation tree at the isolation path; do not edit production source for the element. Done when the recorded command yields an inspectable from the representative scenario.
4. **Iterate one turn** — Apply the operator's latest delta (or the initial extract); run the recorded command; follow **Manager inspect**; present the inspectable; ask one question: accept and promote, name a delta, or end sandbox-only. Done when the inspectable is shown and that question is asked.
5. **Persist and continue** — Append the iteration row; commit `SANDBOX.md`, the isolation tree, and inspectables onto the delivery branch (no PR); when linked, apply the sandbox tracker row (post-merge: new-Task variant) and persist **Next** from the verdict. Done when the head, Task, mirrors, and **Next** agree.

A delta on a later **next** / `/sandbox` resumes at step 4 on the same tree.
Re-run **Represent** when a delta would add or drop a relevant area.

## Artifact

```markdown
# Sandbox: <element>

## Element
- …

## Kind
visual | measure

## Isolation
- Path: sandbox/<slug>/
- Command: <command>
- Inspectables: sandbox/<slug>/inspect/

## Representativeness
- Relevant areas: …          # runtime, data, neighbours, path, baseline
- How reproduced: …          # one line per area
- Gaps: …                    # named; operator agrees cannot move the verdict — or none

## Bar
- Metrics / scenarios / tolerances / baseline: …   # measure; omit for visual
- Scenario: the representative map above (not a simplified stand-in)

## Promote map
- Production targets: …
- Copy notes: …

## Iterations
| N | Change | Inspectable | Verdict |
|---|--------|-------------|---------|
| 1 | initial extract | sandbox/<slug>/inspect/01.* | delta: … |

## Role in pipeline
Promotion input for `/implement`. Supportive isolation — not production source.
Post-merge inspect-loop instead of `/iterate` when each turn needs inspection.

## Tracker
- Task: <KEY> (if linked)
- Relates: <PRIOR-KEY>       # post-merge only
- Artifact: SANDBOX.md
- Branch: <delivery-branch>
- PR: — (sandbox never opens a PR)

## Next
`/<skill> <KEY>` — <why>
```

## Pipeline continuity

When a Task key is given/inferred **and the prior delivery is not merged**:

Follow [finding-docs continuity](../workflow/delivery.md#rules) (same branch
rule as research/model: docs **and** sandbox tree on the delivery head) and the
[sandbox tracker row](../workflow/tracker-sync.md#matrix). Create the delivery
branch if needed; reuse it when define already opened the PR — **still do not
open a PR from this skill**. Leave delivery-Task status unchanged (keep
**To Do** unless already further along). Mark a supportive-only route Task
**Done** at handoff once the isolation tree is on the downstream delivery branch.

**Post-merge** (instead of iterate): create a **new** Task Relates → prior;
branch from WORKSPACE base using the new key; commit `SANDBOX.md` + tree;
**never open a PR**. Implement is the first PR-opening writer on that head.
Comment the prior Task. Leave the new Task **To Do** until implement.

Standalone (no lineage): still write `SANDBOX.md` and the tree; **Next** may be
`/define`, `/implement`, or none.

`SANDBOX.md` follows WORKSPACE **Artifact location**. The isolation tree is
source on the delivery branch (outside production paths), not an externalizable
pipeline artifact.

## Handoff

| Verdict | Next |
|---------|------|
| Delta named | `/sandbox <KEY>` — next inspect turn |
| Accept / promote | `/implement <KEY>` — promote per SANDBOX.md (opens PR when post-merge). Promotion-ready only when last verdict is accept **and** `## Representativeness` is complete |
| Sandbox-only end | none, or `/define <KEY>` when product scope remains |
| Bound chain after accept | first remaining skill (usually `/implement`) |
