---
name: workflows
description: >-
  Workflow routing. Foggy → explore; concrete → define (alignment interview,
  then classify and bind). A short description starts that interview; it does
  not approve the plan. Finished skill replies end with the exact ## Next
  block. Honor Next/ship. Walkthroughs → guide; current-step teaching →
  explain. Infer the path, then disclose and run only that skill.
---

# Workflows

**Model-invoked router.** Default entry for real work in this skills set.

When the user describes work to deliver — with or without naming a skill —
**prefer a catalog workflow** over freestyle coding. **Front doors:** foggy →
**explore**; concrete → **define** (alignment interview, then classification
and workflow binding). A short description starts that interview; it does not
approve the plan. Walkthroughs → **guide**; current-step teaching → **explain**.
Continuations and explicit `/skill` names still apply.

Pipeline skills stay user-invoked (`disable-model-invocation`). This skill is the
always-loaded pointer that keeps workflows discoverable without loading every
pipeline skill into context.

**On invoke:** use the catalog first. For a continuation or in-flight Task,
read [../workflow/SKILL.md](../workflow/SKILL.md). After choosing a path, read
the target skill and only its On-invoke concepts and references.

## Leading words

- **workflow** — named delivery path or bound template after define
- **prefer workflow** — if a catalog row fits, route; do not freestyle past it

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
| **fix-forward** | Open PR has review findings | [review](../review/SKILL.md) (always fix) |
| **adopt** | Entire existing codebase was not built to the structure bar; apply the catalog across it until the route is Done | [adopt](../adopt/SKILL.md) |
| **explore** | Vague, oversized, or foggy initiative — destination felt, way unclear | [explore](../explore/SKILL.md) |
| **research** | User explicitly wants multi-axis literature/evidence now (not product alignment) | [research](../research/SKILL.md) |
| **model** | User explicitly wants math formulation now (not product scope/UX) | [model](../model/SKILL.md) |
| **implement** | An approved PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/ADOPT artifact already exists on the Task; build or resume. The user's message is not that artifact | [implement](../implement/SKILL.md) |
| **architect** | Bound architecture phase after define, or user wants that phase now | [architect](../architect/SKILL.md) |
| **test** | Bound testing phase after implement, or user wants that phase now | [test](../test/SKILL.md) |
| **restructure** / **harden** | Bound refactoring phase after test, or user wants that phase now (`/harden` is an alias) | [restructure](../restructure/SKILL.md) |
| **review** / **review-fix** | Bound review on an In Review PR (find and fix). `/review-fix` is an alias | [review](../review/SKILL.md) |
| **summarise** | Status / “where am I” / “what next” *reported*, not advanced | [summarise](../summarise/SKILL.md) |
| **define** | Concrete work to pin down (bug, tweak, adopt, refine, rework, feature, …) — interview, then classify and bind. **Default front door.** A user description is not an approved plan | [define](../define/SKILL.md) |
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
4. **Announce** — One short line naming the workflow and first skill, then that skill's first action. For define, explore, bug, tweak, refine, and rework, the first action is the one alignment question. Done when the user can see the route and either that question or the skill's completed handoff.
5. **Disclose and run** — Read the selected skill and only its On-invoke concepts/references; execute until the skill's turn boundary. Done when an alignment skill has asked its one question and stopped, or the skill's output and outcome exist.
6. **Honor the boundary** — An open alignment turn stops on its one question (a one-line route name may sit above it). It has no `## Next` block. A finished skill applies [pipelines.md](../workflow/pipelines.md). **immediate** runs the next skill now, then resolve again. **cue** persists **Next** and stops. **stop** persists Next none. `ship` runs the remaining suffix. A finished reply ends with the exact `## Next` block. Done when that boundary holds.

## Invariants

- **Prefer workflow.** If any catalog row fits the ask, route through it. Do not freestyle implement, invent a parallel plan format, or run unstructured intake when a supported path exists.
- **Front doors.** Without an explicit override or continuation, concrete delivery asks → **define**; foggy asks → **explore**. Do not route silent asks to `/bug` `/tweak` `/refine` `/rework` `/sandbox`. Whole-tree structure on a brownfield codebase matches the **adopt** row before define.
- **Interview before build.** Concrete work with no user-approved definition artifact matches **define** (foggy work matches **explore**). The user's description is the alignment subject. It does not match **implement**, **architect**, **test**, **restructure**, or **ship**. A short description does not approve the plan.
- **Reply ends on Next.** A reply that finishes a skill ends with the exact `## Next` block in [handoff.md](../workflow/handoff.md). An open alignment turn is the one question; it has no pipeline Next and does not start the next skill.
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
