# Definition overrides

Shared contract for `/bug`, `/tweak`, `/refine`, and `/rework`. Each skill fills
**Extensions** and **Artifact** only. Prefer `/define` for new work.

**On invoke:** read [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md),
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md),
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md),
[CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md), and
[../workflow/SKILL.md](../workflow/SKILL.md).

## Steps

1. **Resolve context** — Load any related Task/Story and user-provided code pointers. Skills that require a thin area description ask once if it is missing. Done when the subject and optional parent are identified.
2. **Align and define** — Follow CONCEPT_ALIGNMENT with this skill's Extensions. Done when every in-play probe is user-settled and the user approves the readiness prompt.
3. **Persist and track** — Write the artifact, including `## Classification` and `## Workflow` for this class's catalog default. Follow delivery continuity and apply this skill's tracker-sync row. Record outcome `ready`. Apply the workflow transition. Done when the Task, artifact, branch/PR, and mirrors agree.

## Tracker

Follow this skill's [tracker-sync row](../workflow/tracker-sync.md#matrix) and
[delivery continuity](../workflow/delivery.md). Create one **Task**. Use the
provider's bug type/label (or `[Bug]` prefix) only for `/bug`; other overrides
use an ordinary Task. Add Sub-tasks only for genuinely separate packages. A lone
override needs no Story unless the user requests one. Keep the Task **To Do**
and record the artifact, branch/PR, and optional parent on every configured
durable surface. The workflow appends **Next**. Do not write a successor into
the artifact template.
