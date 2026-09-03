# Definition overrides

Shared contract for `/bug`, `/tweak`, `/refine`, and `/rework`. Each skill fills
**Extensions** and **Artifact** only. Prefer `/define` for new work.

**On invoke:** read [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md),
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md), and
[../workflow/SKILL.md](../workflow/SKILL.md).

## Steps

1. **Resolve context** — Load any related Task/Story and user-provided code pointers. Skills that require a thin area description ask once if it is missing. Done when the subject and optional parent are identified.
2. **Align and define** — Follow CONCEPT_ALIGNMENT with this skill's Extensions. Done when the stop condition holds and the user approves the artifact.
3. **Persist and track** — Write the artifact, follow delivery continuity, apply this skill's tracker-sync row, and persist the Handoff. Done when the Task, artifact, branch/PR, mirrors, and **Next** agree.

## Tracker

Follow this skill's [tracker-sync row](../workflow/tracker-sync.md#matrix) and
[delivery continuity](../workflow/delivery.md). Create one **Task**. Use the
provider's bug type/label (or `[Bug]` prefix) only for `/bug`; other overrides
use an ordinary Task. Add Sub-tasks only for genuinely separate packages. A lone
override needs no Story unless the user requests one. Keep the Task **To Do**
and record the artifact, branch/PR, optional parent, and **Next** on every
configured durable surface.

## Handoff

Default Next is `/implement` on the same delivery branch/PR (wording lives on
the skill's artifact). `/rework` names comparative evaluation in that line.
`/ship <TASK-KEY>` finishes remaining along the bound chain.
