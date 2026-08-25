---
name: workflows
description: >-
  Workflow routing. Prefer explore (fog) or define (concrete work — classify
  and bind); honor Next/ship; walkthroughs → guide; current-step teaching →
  explain. Infer the path, then disclose and run only that skill.
---

# Workflows

**Model-invoked router.** Default entry for real work in this skills set.

When the user describes work to deliver — with or without naming a skill —
**prefer a catalog workflow** over freestyle coding. **Front doors:** foggy →
**explore**; concrete → **define** (classification + workflow binding happen
inside define). Walkthroughs → **guide**; current-step teaching → **explain**.
Continuations and explicit `/skill` names still apply.

Pipeline skills stay user-invoked (`disable-model-invocation`). This skill is the
always-loaded pointer that keeps workflows discoverable without loading every
pipeline skill into context.

**On invoke:** use the catalog first. User-facing replies: read
[CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md). For a continuation or
in-flight Task, read [../workflow/reference.md](../workflow/reference.md) and
[../workflow/handoff.md](../workflow/handoff.md). After choosing a path, read
the target skill and only its On-invoke concepts and references.

## Leading words

- **workflow** — named delivery path or bound template after define
- **prefer workflow** — if a catalog row fits, route; do not freestyle past it
- **front door** — explore (fog) or define (concrete); primary human entries

## Catalog

Pick the **first matching** row. Prefer continuing an in-flight Task over starting a parallel *delivery* path. **guide** and **explain** may interrupt an in-flight Task without replacing its bound chain.

| Workflow | When | First skill to load |
|----------|------|---------------------|
| **setup** | Delivery work with no usable `WORKSPACE.md` (repo or global), or user wants tracker/paths/defaults changed | [setup](../setup/SKILL.md) |
| **continue** | Bare **next** / persisted **Next** / “continue” on an active Task | Run persisted Next once ([continuation keywords](../workflow/reference.md#continuation-keywords); [entry context](../workflow/handoff.md#entry-context)) |
| **ship** | Bare **ship** / “finish” / “close it out” / finish remaining through Done | [ship](../ship/SKILL.md) |
| **help** | Which skill / how workflows relate / navigation overview | [help](../help/SKILL.md) |
| **explain** | Current step, decision, interface, numerical point, or recent agent output taught in simple terms | [explain](../explain/SKILL.md) |
| **guide** | Walk through a manual task one step at a time (install, setup, hardware, coding the user wants walked) | [guide](../guide/SKILL.md) |
| **sandbox** | Explicit isolated inspect-loop of a contained UI/method/bench; bound `sandbox: inject`; mid-implement inspect-loop; or **post-merge instead of iterate** when each turn needs visual/plot/report inspection | [sandbox](../sandbox/SKILL.md) |
| **iterate** | Prior Task/PR **already merged**; still broken or incomplete — straightforward production fix (tests/review on the new PR suffice) | [iterate](../iterate/SKILL.md) |
| **fix-forward** | Open PR has review findings / REQUEST_CHANGES | [review-fix](../review-fix/SKILL.md) (or implement fix-forward) |
| **explore** | Vague, oversized, or foggy initiative — destination felt, way unclear | [explore](../explore/SKILL.md) |
| **research** | User explicitly wants multi-axis literature/evidence now (not product alignment) | [research](../research/SKILL.md) |
| **model** | User explicitly wants math formulation now (not product scope/UX) | [model](../model/SKILL.md) |
| **implement** | Ready-to-build PLAN (or legacy BUG/TWEAK/REFINE/REWORK/ITERATE/SANDBOX) exists; build or resume | [implement](../implement/SKILL.md) |
| **review** | Want findings only on an In Review PR (no auto-fix) | [review](../review/SKILL.md) |
| **review-fix** | Want one review → fix → CLEAN on the delivery PR | [review-fix](../review-fix/SKILL.md) |
| **summarise** | Status / “where am I” / “what next” *reported*, not advanced | [summarise](../summarise/SKILL.md) |
| **define** | Concrete work to pin down (bug, tweak, refine, rework, feature, …) — **default front door** | [define](../define/SKILL.md) |
| **bug** / **tweak** / **refine** / **rework** | User **explicitly** named that skill (manual override) | matching skill |

Side paths **research** / **model** usually appear via define’s bound `side_paths`
or an explicit user ask; they do not replace define probes with the user.
**sandbox** is a separate bound step (`sandbox: inject`) — before implement, or
mid-implement when a package needs inspect-each-turn — and may also be invoked
explicitly. Post-merge, prefer sandbox over iterate when each turn needs
inspectables.

## Steps

1. **Check preconditions** — Resolve the effective workspace before selecting delivery work. **guide**, **explain**, and **help** may run without one. Done when workspace availability is known and **setup** is selected if delivery work is missing a workspace.
2. **Gather cheap context** — Read user wording, named keys, and available active ISSUES / branch / open PR signals. Done when enough context exists to compare catalog rows without loading pipeline skills.
3. **Infer workflow** — Pick the first matching catalog row; ask one question only when equally valid paths would cause material rework. Done when exactly one workflow is selected.
4. **Announce** — State the chosen workflow and first skill in one short line. Done when the user can see the route being entered.
5. **Disclose and run** — Read the selected skill and only its On-invoke concepts/references; execute its tracker, artifact, and Handoff contract. Done when that skill's completion criterion holds.
6. **Honor the boundary** — End at the skill Handoff, except when the selected orchestrator (`ship`, `review-fix`) owns further composition. Done when control is returned with persisted **Next** or the orchestrator's terminal result.

## Invariants

- **Prefer workflow.** If any catalog row fits the ask, route through it. Do not freestyle implement, invent a parallel plan format, or run unstructured intake when a supported path exists.
- **Front doors.** Without an explicit override or continuation, concrete delivery asks → **define**; foggy asks → **explore**. Do not route silent asks to `/bug` `/tweak` `/refine` `/rework` `/sandbox`.
- **Router, not executor.** This skill chooses and discloses; the target skill owns behaviour.
- **One path.** Do not start explore and define in parallel for the same ask.
- **Help maps.** If the user only wants a map or which skill to run, prefer **help** over starting a delivery skill.
- **Pace side paths.** A request to teach the current step or a decision → **explain**. A request to be walked through a manual task → **guide**. They interrupt without replacing a bound chain; they do not open a delivery Task.
- **Prefer continuity.** In-flight Task + valid **Next** → **continue** or **ship**, not a new map — unless the ask is **guide** or **explain**.
- **Honor binding.** When a Task already has a Workflow binding, continuations follow that chain.
- **No skill dump.** Never load all pipeline skills “just in case.”
- **Explicit slash wins.** If the user named `/define` or `/bug` (etc.), run that skill — do not re-route unless they ask which workflow fits.

## Out of catalog

Maintaining this skills repo → [manage-skills](../manage-skills/SKILL.md).
Authoring skill/concept prose → [writing-for-agents](../writing-for-agents/SKILL.md).
A brief aside can stay in the current skill. A request to teach the current
step or to walk through a task routes to **explain** or **guide**.
