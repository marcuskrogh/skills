# Agent instructions

**Prefer workflow.** When the user describes a feature, bug, tweak, refine, rework, problem, idea,
investigation, or follow-up — even without naming a skill — invoke
[`workflows`](skills/workflows/SKILL.md): infer the supported pipeline, then load
and run only that skill. Do not freestyle coding or ad-hoc planning when a
catalog workflow fits.

Continuation cues: bare **next** / **ship** still apply (see
`skills/workflow/reference.md`). Explicit `/skill` names win over re-routing.
Lost on which skill to use → [`help`](skills/help/SKILL.md).

**Cursor models (catalog-closed).** On Cursor, every sub-agent / `Task` `model`
must be `composer-2.5` (Routine / Moderate) or `cursor-grok-4.5-high` (Demanding /
manager). No `*-fast` variants. Third-party picker models bill the API budget.
Before spawning workers, load [`CONCEPT_DELEGATION`](skills/concepts/CONCEPT_DELEGATION.md)
and [`platforms/cursor.md`](skills/concepts/platforms/cursor.md).

Authoring skills or concepts → [`writing-for-agents`](skills/writing-for-agents/SKILL.md).
