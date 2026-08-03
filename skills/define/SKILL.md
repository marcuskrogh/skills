---
name: define
description: >-
  Define a component, system, or pipeline Task before coding via user-agent
  alignment. Enriches an explore route/define Task (or creates a Task) with
  PLAN.md, Sub-tasks, and the Task’s delivery branch/PR for closed-loop ship.
  Explore charts the foggy map; research/model add supportive inputs — define owns
  particulars and always questions the user. Persists keys and Next in markdown.
  Use when agreeing on a definition before implementation.
---

# Define

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **specific topic**.
Produces `PLAN.md` and Sub-tasks on the **pipeline Task**.

**On invoke:** read [../concepts/CONCEPT_ALIGNMENT.md](../concepts/CONCEPT_ALIGNMENT.md),
[../concepts/CONCEPT_DEFINITION.md](../concepts/CONCEPT_DEFINITION.md),
[../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Relation to prior skills

**Define is user-agent alignment on particulars.** Prior artifacts orient the
session — they do **not** replace questioning the user.

| Prior artifact | How define uses it |
|----------------|--------------------|
| `ROADMAP.md` / explore route Task | Destination + this step’s question — not a finished spec |
| `RESEARCH.md` | Supportive literature — evidence and orientation, **not** user answers |
| `MODEL.md` | Math foundations the user already aligned on — **not** product scope/UX/acceptance |

Always run definition probes with the user. Do **not** treat roadmap notes, Story
text, open questions, research themes, recommended reading, or model formulations
as already-decided product scope, behaviour, or acceptance.

If the Task still needs literature or math before a sound definition, hand off to
`/research` or `/model` instead of inventing those answers in define — then return
and still probe the user on definition particulars.

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | Component, system, feature, or explore route (define) Task |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | No obvious divergence points remain for scope, behavior, constraints, and acceptance — resolved **with the user** |
| **Alignment / definition artifact** | `PLAN.md` (path from WORKSPACE) |
| **Readiness prompt** | "Does this plan look complete?" |

### Probes

Use definition probes from CONCEPT_DEFINITION, specialised for a pipeline phase:

- Scope boundaries (in / out)
- UX and behavior where multiple valid implementations exist
- Data sources, ownership, and edge cases
- Compatibility with existing code or conventions
- Non-obvious constraints the user cares about
- Acceptance criteria and verification approach
- Open questions / fog pointers parked by **explore** on this route Task (preferred starting list)
- Pipeline Task key from a prior **explore** map (preferred)
- How (if at all) to apply findings from `RESEARCH.md` / constraints from `MODEL.md` — ask; do not assume

### Opening

| Context | First move |
|---------|------------|
| **Thin** | "What do you want to define?" (or resolve Task key) |
| **Rich** / Task key given | Load Task (+ Story, `ROADMAP.md`, `RESEARCH.md` / `MODEL.md` if present); first **definition** divergence with the user — never skip questioning because explore, research, or model already ran |

### Scope guard

- No production code or implementation during definition
- Writing/updating `PLAN.md` (and continuity mirrors) on the Task’s **delivery
  branch** is required after approval — that is not “implementation”
- No sub-agent delegation — alignment / definition only
- Do not re-open map-level wayfinding; stay on this route Task's step
- Do not adopt research conclusions or invent product decisions from literature without user confirmation

## Entry (pipeline)

When the user passes an explore **route Task** key:

1. `fetch` the Task and parent Story via tracker.
2. Load `ROADMAP.md`, and `RESEARCH.md` / `MODEL.md` if present — as **supportive context**.
3. Use Task summary/description as the **route step** to define — assume particulars are still open unless the user already answered them **in this define session**.
4. Start the alignment loop with the user. Cite research/model only as options or constraints to confirm — never as settled definition.

## Alignment artifact

```markdown
# Implementation plan: [title]

## Summary
- …

## Scope / Decisions / Constraints
- … (user-aligned in this define session)

## Inputs (supportive — not substitutes for decisions above)
- Research: RESEARCH.md (if any)
- Model: MODEL.md (if any)

## Acceptance criteria
- …

## Work packages
1. …
2. …

## Open items
- …

## Tracker
- Provider: …
- Story: <KEY> (if linked)
- Task: <KEY>
- Sub-tasks: …
- Branch: <delivery-branch>
- PR: <url or draft url>

## Next
`/implement <KEY>` — Build per this plan (same branch/PR)
```

(`PLAN.md` may also note `/ship <KEY>` as an alternate Next to finish remaining
work through Done.)
## Tracker (after approval)

Follow one-issue continuity, [delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop),
and the [tracker sync matrix](../workflow/reference.md#tracker-sync-matrix-mandatory).

### Explore route Task provided (preferred)

1. **Update that Task** — do not create a parallel definition issue. Status stays **To Do**.
2. Create **Sub-tasks** per work package — status **To Do**; link parent = Task.
3. **Delivery branch:** resolve existing open branch/PR for this Task (from research/model
   comments or `gh`). If none, create the branch per WORKSPACE pattern. Write `PLAN.md`
   on that branch; open or update a **draft** PR when `Open PR by default` (same PR
   implement will use — do **not** plan a second implement-only PR).
   When **Artifact location** is `external`, write `PLAN.md` under the external root
   instead and push its content into the Task; still create the branch (and PR when
   there is a code change to carry) so implement has its delivery vehicle.
4. `attach_or_link` path on the Task; `comment` Task + Story with plan path, **branch**,
   **PR URL**, sub-task keys, **Next**.
5. Upsert ISSUES mirror for Task + Sub-tasks (include branch/PR).

### Standalone

Create a new **Task** + Sub-tasks (**To Do**), then same artifact/branch/PR/mirror/comment steps.

### Tracker duties

| Action | Required |
|--------|----------|
| Enrich Task / create Sub-tasks | yes |
| Start or reuse delivery branch + draft PR | yes when committing PLAN.md |
| Task status | remain **To Do** |
| Comments + branch/PR + **Next** | Task + Story |
| ISSUES mirror | yes when enabled |
| Close Task | no (ship only) |
| Second PR for define alone | **no** |

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Build per PLAN.md on the same delivery branch/PR
```

(Or `/ship <TASK-KEY>` to finish remaining: implement → review-fix → closeout.)