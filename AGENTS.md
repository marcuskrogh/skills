# Agent instructions

**Prefer workflow.** When the user describes work to deliver — even without naming
a skill — invoke [`workflows`](skills/workflows/SKILL.md). **Front doors:** foggy
→ [`explore`](skills/explore/SKILL.md); concrete (bug, tweak, refine, rework,
feature, …) → [`define`](skills/define/SKILL.md). Define interviews for alignment,
then classifies and binds a workflow. A short description starts that interview;
it does not approve the plan. Skills apply concepts and produce an output; they
do not name the next skill. The bound workflow
([`skills/workflow/pipelines.md`](skills/workflow/pipelines.md)) writes persisted
**Next**. Follow that cue afterward. A reply that
finishes a skill ends with the exact `## Next` block (`/<skill> <KEY>` — why).
An open alignment question does not include that block. Do not freestyle
coding or ad-hoc planning when a catalog workflow fits.

Continuation cues: bare **next** / **ship** still apply (see
`skills/workflow/reference.md`). Explicit `/skill` names win over re-routing
(manual overrides remain available). Lost on which skill to use →
[`help`](skills/help/SKILL.md).

**Cursor models (catalog-closed).** On Cursor (Desktop, Cloud, CLI, Mobile), every `Task` spawn of any type —
including `computerUse` and `videoReview` — must pass an explicit `model`
slug from the Cursor Models allowlist only: `composer-2.5` (Routine /
Moderate) or `cursor-grok-4.6-high` (Demanding / manager). Only `composer-*`
and `cursor-grok-*` slugs are provably first-party; bare `grok-*` and
third-party picker slugs bill **Other Models**. If the chosen slug is absent
from the Task enum, pass the other allowlisted slug, else `composer-2.5`.
Never `inherit`, omit `model`, or pick a picker slug. No `*-fast` variants.
Load
[`CONCEPT_DELEGATION`](skills/concepts/CONCEPT_DELEGATION.md) and
[`platforms/cursor.md`](skills/concepts/platforms/cursor.md) before every spawn.

**Language.** Before any reply the operator will see, read
[`CONCEPT_LANGUAGE`](skills/concepts/CONCEPT_LANGUAGE.md),
[`LANGUAGE-PHRASES`](skills/concepts/LANGUAGE-PHRASES.md), and
[`LANGUAGE-HUMANIZER`](skills/concepts/LANGUAGE-HUMANIZER.md). Follow those
files. Spell names in full (`GeneralProcessSimulator`, not `GPS`). Keep
**harness** for the agent host (Cursor, Claude Code, Codex, …). Do not call a
sandbox tree, wrapper, or other code a harness.

Authoring skills or concepts → [`writing-for-agents`](skills/writing-for-agents/SKILL.md).
