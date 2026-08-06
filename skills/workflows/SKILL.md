---
name: workflows
description: >-
  Route work to a supported pipeline. Use when the user asks to build, fix,
  investigate, ship, continue, or figure out what to do next without naming a
  skill — vague or concrete work requests, defects, foggy initiatives, post-ship
  follow-ups, status that needs action, or “which workflow fits this?” Infer the
  workflow from context, then load and run only the matching skill(s).
---

# Workflows

**Model-invoked router.** Discovers from context when the user wants work done
but has not named a pipeline skill. Infers which **workflow** fits, then
**progressive-discloses** only that path — read the skill and follow it.

Pipeline skills stay user-invoked (`disable-model-invocation`). This skill is the
always-loaded pointer that restores autonomous routing without loading every
pipeline skill into context.

Do **not** restate skill invariants here. After choosing a path, **read and run**
the target skill (and the concepts it points at). Continuity mechanics live in
[../workflow/reference.md](../workflow/reference.md) — load only when the chosen
skill needs them (or when resolving an in-flight Task).

## Leading words

- **workflow** — named delivery path (feature / bug / iterate / side / continue)
- **route** (this skill) — pick a workflow from context, then hand execution to the skill

## Catalog

Pick the **first matching** row. Prefer continuing an in-flight Task over starting a parallel path.

| Workflow | When | First skill to load |
|----------|------|---------------------|
| **setup** | No usable `WORKSPACE.md` (repo or global), or user wants tracker/paths/defaults changed | [setup](../setup/SKILL.md) |
| **continue** | Bare **next** / persisted **Next** / “continue” on an active Task | Run the persisted Next skill once ([workflow reference — continuation](../workflow/reference.md#continuation-keywords)) |
| **ship** | Bare **ship** / “finish” / “close it out” / finish remaining through Done | [ship](../ship/SKILL.md) |
| **bug** | Behaviour is wrong; fix is the work; no foggy product definition needed | [bug](../bug/SKILL.md) |
| **iterate** | Prior Task/PR **already merged**; still broken or incomplete | [iterate](../iterate/SKILL.md) |
| **fix-forward** | Open PR has review findings / REQUEST_CHANGES | [review-fix](../review-fix/SKILL.md) (or implement fix-forward) |
| **explore** | Vague, oversized, or foggy initiative — destination felt, way unclear | [explore](../explore/SKILL.md) |
| **research** | Need multi-axis literature/evidence before deciding; not product alignment | [research](../research/SKILL.md) |
| **model** | Need math formulation aligned with the user (not product scope/UX) | [model](../model/SKILL.md) |
| **define** | Concrete feature/slice to pin down with the user before coding | [define](../define/SKILL.md) |
| **implement** | Ready-to-build PLAN/BUG/ITERATE exists; build or resume build | [implement](../implement/SKILL.md) |
| **review** | Want findings only on an In Review PR (no auto-fix) | [review](../review/SKILL.md) |
| **review-fix** | Want one review → fix → CLEAN on the delivery PR | [review-fix](../review-fix/SKILL.md) |
| **summarise** | Status / “where am I” / “what next” *reported*, not advanced | [summarise](../summarise/SKILL.md) |

### Feature vs bug vs iterate (quick cut)

| Signal | Workflow |
|--------|----------|
| Wrong behaviour; repro imaginable; fix is the deliverable | **bug** |
| Shipped/merged; same lineage still wrong | **iterate** |
| Open PR; review wants changes | **fix-forward** / **review-fix** |
| New capability, unclear shape, or multi-step fog | **explore** (then route Tasks) |
| Slice already sharp enough to define | **define** |
| PLAN/BUG ready | **implement** or **ship** (finish remaining) |

Side paths **research** / **model** insert on a feature route; they do not replace
**define** probes with the user.

## Steps

1. **Preconditions** — If no workspace resolves, choose **setup** first (do not invent pipeline config mid-flight).
2. **Gather cheap context** — User wording; active ISSUES / branch / open PR if present; named keys. Do **not** load every pipeline skill yet.
3. **Infer workflow** — Use the catalog. If two rows fit equally and the wrong pick would waste real work, ask **one** clarifying question; otherwise decide.
4. **Announce** — One short line: chosen workflow + first skill (e.g. “Bug workflow → `/bug`”).
5. **Disclose and run** — Read that skill’s `SKILL.md` (and only the concepts/refs it requires On invoke). Follow it fully — tracker, artifacts, **Next**.
6. **Stop at the skill’s handoff** — Do not auto-chain the entire pipeline unless the user asked to **ship** / finish remaining, or the skill you ran is itself an orchestrator (`ship`, `review-fix`).

## Invariants

- **Router, not executor.** This skill chooses and discloses; the target skill owns behaviour.
- **One path.** Do not start explore and bug in parallel for the same ask.
- **Prefer continuity.** In-flight Task + valid **Next** → **continue** or **ship**, not a new map.
- **No skill dump.** Never load all pipeline skills “just in case.”
- **Explicit slash wins.** If the user named `/define` (etc.), run that skill — do not re-route unless they ask which workflow fits.

## Out of catalog

Maintaining this skills repo → [manage-skills](../manage-skills/SKILL.md).
Authoring skill/concept prose → [writing-for-agents](../writing-for-agents/SKILL.md).
