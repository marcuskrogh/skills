# Agent instructions

**Prefer workflow.** When the user describes a feature, bug, problem, idea,
investigation, or follow-up — even without naming a skill — invoke
[`workflows`](skills/workflows/SKILL.md): infer the supported pipeline, then load
and run only that skill. Do not freestyle coding or ad-hoc planning when a
catalog workflow fits.

Continuation cues: bare **next** / **ship** still apply (see
`skills/workflow/reference.md`). Explicit `/skill` names win over re-routing.

Authoring skills or concepts → [`writing-for-agents`](skills/writing-for-agents/SKILL.md).
