# Agent instructions

**Prefer workflow.** When the user describes work to deliver — even without naming
a skill — invoke [`workflows`](skills/workflows/SKILL.md). **Front doors:** foggy
→ [`explore`](skills/explore/SKILL.md); concrete (bug, tweak, refine, rework,
feature, …) → [`define`](skills/define/SKILL.md), which classifies the work and
binds an efficient workflow. Follow persisted **Next** afterward. Do not freestyle
coding or ad-hoc planning when a catalog workflow fits.

Continuation cues: bare **next** / **ship** still apply (see
`skills/workflow/reference.md`). Explicit `/skill` names win over re-routing
(manual overrides remain available). Lost on which skill to use →
[`help`](skills/help/SKILL.md).

**Cursor models (catalog-closed).** On Cursor (Desktop, Cloud, CLI, Mobile), every `Task` spawn of any type —
including `computerUse` and `videoReview` — passes `model` `composer-2.5`
(Routine / Moderate) or `cursor-grok-4.6-high` (Demanding / manager). If that
slug is absent from the Task enum, pass `composer-2.5`. Never `inherit`, omit
`model`, or pick a picker slug. No `*-fast` variants. Third-party picker models
bill the API budget. Load
[`CONCEPT_DELEGATION`](skills/concepts/CONCEPT_DELEGATION.md) and
[`platforms/cursor.md`](skills/concepts/platforms/cursor.md) before every spawn.

**Language.** Before any reply the operator will see, read
[`CONCEPT_LANGUAGE`](skills/concepts/CONCEPT_LANGUAGE.md),
[`LANGUAGE-PHRASES`](skills/concepts/LANGUAGE-PHRASES.md), and
[`LANGUAGE-HUMANIZER`](skills/concepts/LANGUAGE-HUMANIZER.md). Follow those
files. Spell names in full (`GeneralProcessSimulator`, not `GPS`). In replies,
say Cursor or Claude Code, not "the harness".

Authoring skills or concepts → [`writing-for-agents`](skills/writing-for-agents/SKILL.md).
