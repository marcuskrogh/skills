---
name: workflows
description: >-
  Workflow routing for features, bugs, tweaks, ideas, investigations, reviews,
  follow-ups, and delivery. Infer the supported path from user context, then
  progressively disclose and run only the matching skill.
---

# Workflows

**Model-invoked router.** Default entry for real work in this skills set.

When the user describes a feature, bug, tweak, problem, idea, or other work — with or
without naming a skill — **prefer a catalog workflow** over freestyle coding,
one-off plans, or unstructured Q&A. Infer which path fits, then
**progressive-disclose** only that skill and follow it.

Pipeline skills stay user-invoked (`disable-model-invocation`). This skill is the
always-loaded pointer that keeps workflows discoverable without loading every
pipeline skill into context.

**On invoke:** use the catalog first. For a continuation or in-flight Task, read
[../workflow/reference.md](../workflow/reference.md) and
[../workflow/handoff.md](../workflow/handoff.md). After choosing a path, read
the target skill and only its On-invoke concepts and references.

## Leading words

- **workflow** — named delivery path (feature / bug / tweak / iterate / side / continue)
- **prefer workflow** — if a catalog row fits, route; do not freestyle past it

## Catalog

Pick the **first matching** row. Prefer continuing an in-flight Task over starting a parallel path.

| Workflow | When | First skill to load |
|----------|------|---------------------|
| **setup** | No usable `WORKSPACE.md` (repo or global), or user wants tracker/paths/defaults changed | [setup](../setup/SKILL.md) |
| **continue** | Bare **next** / persisted **Next** / “continue” on an active Task | Run persisted Next once ([continuation keywords](../workflow/reference.md#continuation-keywords); [entry context](../workflow/handoff.md#entry-context)) |
| **ship** | Bare **ship** / “finish” / “close it out” / finish remaining through Done | [ship](../ship/SKILL.md) |
| **bug** | Behaviour is wrong; fix is the work; no foggy product definition needed | [bug](../bug/SKILL.md) |
| **tweak** | Small intentional change to existing behaviour; not a defect; too light for full define | [tweak](../tweak/SKILL.md) |
| **iterate** | Prior Task/PR **already merged**; still broken or incomplete | [iterate](../iterate/SKILL.md) |
| **fix-forward** | Open PR has review findings / REQUEST_CHANGES | [review-fix](../review-fix/SKILL.md) (or implement fix-forward) |
| **explore** | Vague, oversized, or foggy initiative — destination felt, way unclear | [explore](../explore/SKILL.md) |
| **research** | Need multi-axis literature/evidence before deciding; not product alignment | [research](../research/SKILL.md) |
| **model** | Need math formulation aligned with the user (not product scope/UX) | [model](../model/SKILL.md) |
| **define** | Concrete feature/slice to pin down with the user before coding | [define](../define/SKILL.md) |
| **implement** | Ready-to-build PLAN/BUG/TWEAK/ITERATE exists; build or resume build | [implement](../implement/SKILL.md) |
| **review** | Want findings only on an In Review PR (no auto-fix) | [review](../review/SKILL.md) |
| **review-fix** | Want one review → fix → CLEAN on the delivery PR | [review-fix](../review-fix/SKILL.md) |
| **summarise** | Status / “where am I” / “what next” *reported*, not advanced | [summarise](../summarise/SKILL.md) |

Side paths **research** / **model** insert on a feature route; they do not replace
**define** probes with the user.

## Steps

1. **Check preconditions** — Resolve the effective workspace before selecting delivery work. Done when workspace availability is known and **setup** is selected if missing.
2. **Gather cheap context** — Read user wording, named keys, and available active ISSUES / branch / open PR signals. Done when enough context exists to compare catalog rows without loading pipeline skills.
3. **Infer workflow** — Pick the first matching catalog row; ask one question only when equally valid paths would cause material rework. Done when exactly one workflow is selected.
4. **Announce** — State the chosen workflow and first skill in one short line. Done when the user can see the route being entered.
5. **Disclose and run** — Read the selected skill and only its On-invoke concepts/references; execute its tracker, artifact, and Handoff contract. Done when that skill's completion criterion holds.
6. **Honor the boundary** — End at the skill Handoff, except when the selected orchestrator (`ship`, `review-fix`) owns further composition. Done when control is returned with persisted **Next** or the orchestrator's terminal result.

## Invariants

- **Prefer workflow.** If any catalog row fits the ask, route through it. Do not freestyle implement, invent a parallel plan format, or run unstructured intake when a supported path exists.
- **Router, not executor.** This skill chooses and discloses; the target skill owns behaviour.
- **One path.** Do not start explore and bug/tweak/define in parallel for the same ask.
- **Prefer continuity.** In-flight Task + valid **Next** → **continue** or **ship**, not a new map.
- **No skill dump.** Never load all pipeline skills “just in case.”
- **Explicit slash wins.** If the user named `/define` (etc.), run that skill — do not re-route unless they ask which workflow fits.

## Out of catalog

Maintaining this skills repo → [manage-skills](../manage-skills/SKILL.md).
Authoring skill/concept prose → [writing-for-agents](../writing-for-agents/SKILL.md).
True non-pipeline chatter (pure explanation with no work to deliver) need not route.
