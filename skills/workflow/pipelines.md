# Workflow pipelines

Normative map from a skill **outcome** to the next skill. Skills do not carry this map. Load with [handoff.md](handoff.md) when a skill finishes or **Next**
is resolved.

Applies [CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md).

## Rules

- **One map.** Successor, mode, and chain membership come from the tables below.
  First matching **Transitions** row wins.
- **Apply, do not redefine.** A step applies the previous step's output. It
  does not rewrite that artifact.
- **Workflows make inputs exist.** Run the producing step before the consumer
  so the consumer takes the apply path. Define when absent: if a consumer is
  invoked alone and a required input is missing, that skill defines the input
  ([CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md)).
- **Modes.** `cue` — write **Next** and stop. `immediate` — run the next skill
  in this session, then resolve again. `stop` — **Next** is none. `immediate`
  is not the user cue **continue** (that cue runs one persisted **Next**).
- **chain-first** — first included step of the chain below. **chain-next** —
  the next included step after **After**. If **After** is included, take the
  following included step. If **After** is a chain step this binding omitted
  (a skip), take the next included step after that position. If **After** is
  not a chain step, use chain-first. Past the last step, the result is none.
- **Tokens.** `frontier` — skill for the next unblocked route row (table
  below). `blocking` — the skill that reported the hard stop. `none` — no
  successor.

## How a step applies the previous output

| Step | Applies |
|------|---------|
| **research** | The route or task question. Writes `RESEARCH.md`. |
| **model** | `RESEARCH.md` when it exists, as literature only. Writes `MODEL.md`. |
| **define** / **bug** / **tweak** / **refine** / **rework** | Supportive `ROADMAP.md`, `RESEARCH.md`, `MODEL.md`, `SANDBOX.md` when they exist. They do not replace user alignment. Writes the definition spec and the workflow binding. |
| **architect** | The definition spec (`PLAN.md` or the class spec). Writes `ARCHITECTURE.md`. |
| **sandbox** | The element and, when present, the parity bar on the definition spec. Writes `SANDBOX.md` and the isolation tree. |
| **implement** | The definition spec and `ARCHITECTURE.md`. Promotes `SANDBOX.md` when the verdict is accept. Uses `RESEARCH.md` / `MODEL.md` when product copy needs them. Writes the delivery diff. |
| **test** | Pass criteria on the definition spec, against the delivery diff. |
| **restructure** | The structure catalog on the delivery diff. Keeps behaviour the definition spec already fixed. |
| **review** | The definition spec and `ARCHITECTURE.md` (when present) against the diff. |
| **ship** | The same delivery head. Merges after `CLEAN`. |
| **explore** | Writes `ROADMAP.md`. The frontier row is the next step. |
| **adopt** | Writes `ADOPT.md` (inventory + frontier behaviour map). Later steps apply that map. Proof gates: [../adopt/route.md](../adopt/route.md). |
| **iterate** | Writes `ITERATE.md` on a new Task. Mode **immediate** applies it via sandbox (inspect-loop) or implement (straightforward fix). |

## Chains

Include a step when **When** matches the binding. Defaults: `side_paths=none`,
`sandbox=none`, `test.mode=dedicated`, `harden.mode=dedicated`. Class **adopt**
always includes test. `test.mode=skip` is docs-only or an explicit user ask.
`harden.mode=skip` is an explicit user ask only.

| Chain | Step | When |
|-------|------|------|
| delivery | research | side_paths=research or side_paths=research+model |
| delivery | model | side_paths=model or side_paths=research+model |
| delivery | architect | always |
| delivery | sandbox | sandbox=inject |
| delivery | implement | always |
| delivery | test | class=adopt or test.mode!=skip |
| delivery | restructure | harden.mode!=skip |
| delivery | review | always |
| delivery | ship | always |
| iterate | implement | always |
| iterate | test | test.mode!=skip |
| iterate | restructure | harden.mode!=skip |
| iterate | review | always |
| iterate | ship | always |
| adopt | architect | always |
| adopt | implement | always |
| adopt | test | always |
| adopt | restructure | always |
| adopt | review | always |
| adopt | ship | always |

**delivery** is the chain for every classification template (fix-fast,
delta-fast, structure-safe, parity-iterative, feature-standard, feature-heavy)
and for manual `/bug` `/tweak` `/refine` `/rework` once that skill has recorded
the class default binding. Prefix order is the table order: side paths, architect,
sandbox, implement, then closeout.

**iterate** is the post-merge delta chain (explicit `/iterate`, and post-merge
`/sandbox` after accept). It does not reopen architect. Inspect-loop is a
transition into sandbox, then implement, then this chain.

**adopt** walks [../adopt/route.md](../adopt/route.md) with mode **immediate**.
Do not drop characterize, test, or restructure. After ship, an open area returns
to adopt; an empty route stops.

## Frontier

| Route type | Skill |
|------------|-------|
| research | research |
| model | model |
| sandbox | sandbox |
| define | define |
| task | none |

## Transitions

| Workflow | After | Outcome | When | Next | Mode |
|----------|-------|---------|------|------|------|
| delivery | review | FAILED | * | implement | cue |
| delivery | implement | fixed | * | review | cue |
| delivery | sandbox | delta | * | sandbox | cue |
| delivery | sandbox | end | * | none | stop |
| delivery | ship | done | * | none | stop |
| delivery | * | * | * | chain-next | cue |
| explore | explore | ready | frontier=research | research | cue |
| explore | explore | ready | frontier=model | model | cue |
| explore | explore | ready | frontier=sandbox | sandbox | cue |
| explore | explore | ready | frontier=define | define | cue |
| explore | explore | ready | frontier=task | none | stop |
| explore | sandbox | delta | * | sandbox | cue |
| explore | sandbox | end | * | frontier | cue |
| explore | sandbox | accept | * | frontier | cue |
| explore | research | ready | * | frontier | cue |
| explore | model | ready | * | frontier | cue |
| iterate | iterate | inspect-loop | * | sandbox | immediate |
| iterate | iterate | ready | * | implement | immediate |
| iterate | sandbox | delta | * | sandbox | cue |
| iterate | sandbox | end | * | none | stop |
| iterate | sandbox | accept | * | implement | immediate |
| iterate | review | FAILED | * | implement | cue |
| iterate | implement | fixed | * | review | cue |
| iterate | ship | done | * | none | stop |
| iterate | * | * | * | chain-next | cue |
| adopt | review | FAILED | * | implement | cue |
| adopt | implement | fixed | * | review | immediate |
| adopt | ship | done | route-empty | none | stop |
| adopt | ship | done | route-open | adopt | immediate |
| adopt | * | hard-stop | * | blocking | cue |
| adopt | adopt | mapped | * | chain-first | immediate |
| adopt | * | * | * | chain-next | immediate |
| standalone | * | * | * | none | stop |

## Which workflow

| Situation | Workflow |
|-----------|----------|
| `PLAN.md` / class spec has `## Workflow`, or a legacy class artifact | **delivery** (adopt class uses **adopt**) |
| Explicit `/iterate`, or post-merge sandbox | **iterate** |
| Route Task whose Story is an explore map | **explore** until the frontier is a define-typed delivery Task |
| Invoked skill, no Task and no binding | **standalone** |

Class **adopt** uses the **adopt** workflow even when the template name is
structure-safe. Manual class skills record the delivery binding and then use
**delivery**.

## Outputs

| Skill | Output | Outcome |
|-------|--------|---------|
| explore | `ROADMAP.md` | ready |
| define | `PLAN.md` | ready |
| bug | `BUG.md` | ready |
| tweak | `TWEAK.md` | ready |
| refine | `REFINE.md` | ready |
| rework | `REWORK.md` | ready |
| research | `RESEARCH.md` | ready |
| model | `MODEL.md` | ready |
| sandbox | `SANDBOX.md` | delta, accept, end |
| architect | `ARCHITECTURE.md` | ready |
| implement | delivery diff | built, fixed |
| test | tests on the delivery diff | ready, skipped |
| restructure | structural edits on the delivery diff | ready, skipped |
| review | pull-request review | CLEAN, FAILED |
| iterate | `ITERATE.md` | ready, inspect-loop |
| adopt | `ADOPT.md` | mapped, hard-stop |
| setup | `WORKSPACE.md` | ready |
| ship | merged delivery PR, Task Done | done |
