# Agent instructions

**Prefer workflow.** When the user describes a feature, bug, tweak, problem, idea,
investigation, or follow-up — even without naming a skill — invoke
[`workflows`](skills/workflows/SKILL.md): infer the supported pipeline, then load
and run only that skill. Do not freestyle coding or ad-hoc planning when a
catalog workflow fits.

Continuation cues: bare **next** / **ship** still apply (see
`skills/workflow/reference.md`). Explicit `/skill` names win over re-routing.

**Cursor models (catalog-closed).** On Cursor, every sub-agent / `Task` `model`
must be Composer or Grok only: `composer-2.5` / `composer-2.5-fast` (Routine /
Moderate) or `cursor-grok-4.5-high` / `cursor-grok-4.5-high-fast` (Demanding /
manager). Third-party picker models bill the API budget. Before spawning workers,
load [`CONCEPT_DELEGATION`](skills/concepts/CONCEPT_DELEGATION.md) and
[`platforms/cursor.md`](skills/concepts/platforms/cursor.md).

Authoring skills or concepts → [`writing-for-agents`](skills/writing-for-agents/SKILL.md).
