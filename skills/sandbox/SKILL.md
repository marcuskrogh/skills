---
name: sandbox
description: >-
  Sandbox for isolated iterative development of a contained UI, method, or
  bench. Produces SANDBOX.md and a runnable harness outside production paths
  so each iteration can be inspected (screenshot, plot, report) without
  shipping the product. Use standalone, as a bound workflow step
  (`sandbox: inject`), or when implement hits an element that needs an
  inspect-loop before production wiring.
disable-model-invocation: true
---

# Sandbox

Applies [CONCEPT_SANDBOX](../concepts/CONCEPT_SANDBOX.md) to one **element**.
Optional pipeline step — before **implement**, or mid-implement when a package
needs inspect-each-turn. Produces **promotion input** on the delivery branch
(no sandbox PR).

**On invoke:** read [CONCEPT_SANDBOX](../concepts/CONCEPT_SANDBOX.md),
[kinds.md](kinds.md), and
[../workflow/reference.md](../workflow/reference.md), plus
[../workflow/handoff.md](../workflow/handoff.md) when writing **Next**. When
linked to a Task, also read [../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
and [../tracker/SKILL.md](../tracker/SKILL.md). When spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md).

User-facing replies: [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Element** | Contained UI/UX slice, method, or bench named on invoke, PLAN, or implement package |
| **Kind** | `visual` or `measure` — infer from the element; confirm only when costly |
| **Harness** | Per [kinds.md](kinds.md) |
| **Isolation path** | `sandbox/<slug>/` under WORKSPACE Sandbox root |
| **Artifact** | `SANDBOX.md` (path from WORKSPACE) |
| **Bar** | From PLAN/REWORK parity bar or invoke; required for measure |
| **Promote map** | Production target paths + what to copy |
| **Pipeline continuity** | Commit harness + `SANDBOX.md` onto the delivery branch; never open a PR |
| **Handoff defaults** | `/sandbox` (delta) / `/implement` (accept) / none |
| **Model routing** | CONCEPT_DELEGATION when packages are workers; inspect presentation stays on manager |

## Steps

Follow CONCEPT_SANDBOX flow. Specialisations:

1. **Resolve** — Load Task, PLAN/REWORK, existing `SANDBOX.md`, and the named element. Infer kind; require a thin element description or ask once. For measure, require or record the bar. Done when element, kind, isolation path, and bar-if-measure are known.
2. **Isolate** — Create or resume the harness at the isolation path per [kinds.md](kinds.md); do not edit production source for the element. Done when the recorded command yields an inspectable.
3. **Iterate one turn** — Apply the operator's latest delta (or the initial extract); run the harness; present the inspectable; ask one question: accept and promote, name a delta, or end sandbox-only. Done when the inspectable is shown and that question is asked.
4. **Persist and continue** — Append the iteration row; commit `SANDBOX.md`, harness, and inspectables onto the delivery branch (no PR); when linked, apply the sandbox tracker row and persist **Next** from the verdict. Done when the head, Task, mirrors, and **Next** agree.

A delta on a later **next** / `/sandbox` resumes at step 3 on the same tree.

## Artifact

```markdown
# Sandbox: <element>

## Element
- …

## Kind
visual | measure

## Isolation
- Path: sandbox/<slug>/
- Harness: <command>
- Inspectables: sandbox/<slug>/inspect/

## Bar
- Metrics / scenarios / tolerances / baseline: …   # measure; omit for visual

## Promote map
- Production targets: …
- Copy notes: …

## Iterations
| N | Change | Inspectable | Verdict |
|---|--------|-------------|---------|
| 1 | initial extract | sandbox/<slug>/inspect/01.* | delta: … |

## Role in pipeline
Promotion input for `/implement`. Supportive isolation — not production source.

## Tracker
- Task: <KEY> (if linked)
- Artifact: SANDBOX.md
- Branch: <delivery-branch>
- PR: — (sandbox never opens a PR)

## Next
`/<skill> <KEY>` — <why>
```

## Pipeline continuity

When a Task key is given/inferred:

Follow [finding-docs continuity](../workflow/delivery.md#rules) (same branch
rule as research/model: docs **and** sandbox tree on the delivery head) and the
[sandbox tracker row](../workflow/tracker-sync.md#matrix). Create the delivery
branch if needed; reuse it when define already opened the PR — **still do not
open a PR from this skill**. Leave delivery-Task status unchanged (keep
**To Do** unless already further along). Mark a supportive-only route Task
**Done** at handoff once the harness is on the downstream delivery branch.

Standalone: still write `SANDBOX.md` and the tree; **Next** may be `/define`,
`/implement`, or none.

`SANDBOX.md` follows WORKSPACE **Artifact location**. The isolation tree is
source on the delivery branch (outside production paths), not an externalizable
pipeline artifact.

## Handoff

| Verdict | Next |
|---------|------|
| Delta named | `/sandbox <KEY>` — next inspect turn |
| Accept / promote | `/implement <KEY>` — promote per SANDBOX.md |
| Sandbox-only end | none, or `/define <KEY>` when product scope remains |
| Bound chain after accept | first remaining skill (usually `/implement`) |
