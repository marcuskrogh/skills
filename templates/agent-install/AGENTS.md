<!-- marcuskrogh/skills:begin -->
**Prefer workflow.** When the user describes work to deliver — even without naming
a skill — invoke [`.agents/skills/workflows/SKILL.md`](.agents/skills/workflows/SKILL.md).
**Front doors:** foggy → explore; concrete → define (classifies + binds workflow).
Follow persisted **Next**. Do not freestyle coding or ad-hoc planning when a
catalog workflow fits.

Continuation cues: bare **next** / **ship** still apply (see
`.agents/skills/workflow/reference.md`). Explicit `/skill` names win over
re-routing. Lost on which skill to use → [`.agents/skills/help/SKILL.md`](.agents/skills/help/SKILL.md).

**Cursor models (catalog-closed).** On Cursor (Desktop, Cloud, CLI, Mobile), every `Task` spawn of any type —
including `computerUse` and `videoReview` — passes `model` `composer-2.5`
(Routine / Moderate) or `cursor-grok-4.6-high` (Demanding / manager). If that
slug is absent from the Task enum, pass `composer-2.5`. Never `inherit`, omit
`model`, or pick a picker slug. No `*-fast` variants. Third-party picker models
bill the API budget. Load
[`.agents/skills/concepts/CONCEPT_DELEGATION.md`](.agents/skills/concepts/CONCEPT_DELEGATION.md)
and [`.agents/skills/concepts/platforms/cursor.md`](.agents/skills/concepts/platforms/cursor.md)
before every spawn.

**Language.** Before any reply the operator will see, read
[`.agents/skills/concepts/CONCEPT_LANGUAGE.md`](.agents/skills/concepts/CONCEPT_LANGUAGE.md),
[`.agents/skills/concepts/LANGUAGE-PHRASES.md`](.agents/skills/concepts/LANGUAGE-PHRASES.md),
and [`.agents/skills/concepts/LANGUAGE-HUMANIZER.md`](.agents/skills/concepts/LANGUAGE-HUMANIZER.md).
Follow those files. Spell names in full (`GeneralProcessSimulator`, not `GPS`).
In replies, say Cursor or Claude Code, not "the harness".

Authoring skills or concepts → [`.agents/skills/writing-for-agents/SKILL.md`](.agents/skills/writing-for-agents/SKILL.md).
<!-- marcuskrogh/skills:end -->
