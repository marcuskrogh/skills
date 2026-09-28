# Workflows

Which workflow runs in which situation, what it produces, and which skills it loads. Source: [`workflows`](../../skills/workflows/SKILL.md), [`help`](../../skills/help/SKILL.md), [`CLASSIFICATION-CATALOG.md`](../../skills/concepts/CLASSIFICATION-CATALOG.md), and [`pipelines.md`](../../skills/workflow/pipelines.md).

Return to the [front page](../../README.md).

The router picks the **first matching** row. Prefer continuing an in-flight Task over starting a parallel delivery path. **guide** and **explain** may interrupt without replacing the bound chain.

## Catalog (recognition order)

| Workflow | Recognised when | First skill | Result |
|----------|-----------------|-------------|--------|
| **setup** | Delivery work and no usable `WORKSPACE.md` (repo or global), or you want the tracker, paths, or defaults changed | [`setup`](../../skills/setup/SKILL.md) | `WORKSPACE.md` |
| **continue** | Bare **next**, continue, or go on an active Task | persisted Next, once | that skill's output |
| **ship** | Bare **ship**, finish, or close it out | [`ship`](../../skills/ship/SKILL.md) | remaining chain, then merge and Done |
| **help** | Which skill to run, how workflows relate, or a navigation overview | [`help`](../../skills/help/SKILL.md) | the short map. Stops |
| **explain** | Teach the current step, a decision, an interface, a numerical point, or recent agent output | [`explain`](../../skills/explain/SKILL.md) | paced teaching. Bound chain stays |
| **guide** | Walk through a manual task one step at a time (install, setup, hardware, or coding you want walked) | [`guide`](../../skills/guide/SKILL.md) | one step, then wait |
| **sandbox** | Isolated inspect-loop of a contained UI, method, or bench; a bound `sandbox: inject` step; mid-implement when a package needs inspect-each-turn; or a post-merge fix where each turn needs a visual, plot, or report | [`sandbox`](../../skills/sandbox/SKILL.md) | `SANDBOX.md` plus isolation tree. No pull request of its own |
| **iterate** | A prior Task or PR is **already merged** and still broken or incomplete, and tests plus review on a new PR are enough | [`iterate`](../../skills/iterate/SKILL.md) | `ITERATE.md`, new Task, branch, and pull request |
| **fix-forward** | The open PR has review findings | [`review`](../../skills/review/SKILL.md) (always fixes) | same as review, on the open pull request |
| **adopt** | The existing codebase (or the named tree) was not built to the structure bar | [`adopt`](../../skills/adopt/SKILL.md) | `ADOPT.md`. Inventory, then characterize → architect → implement → test → restructure → review → ship per area until Done |
| **explore** | The goal is vague, oversized, or still unclear | [`explore`](../../skills/explore/SKILL.md) | `ROADMAP.md` and sequenced route Tasks. No map-only pull request |
| **research** | You explicitly want a multi-axis literature or evidence pass now | [`research`](../../skills/research/SKILL.md) | `RESEARCH.md` on the delivery branch. No pull request of its own |
| **model** | You explicitly want a math formulation now | [`model`](../../skills/model/SKILL.md) | `MODEL.md` on the delivery branch. No pull request of its own |
| **implement** | An approved `PLAN.md` or class artifact already exists on the Task, and you want to build or resume. A chat description is not that file | [`implement`](../../skills/implement/SKILL.md) | code on the Task's pull request, then test unless the binding skips it |
| **architect** | The bound architecture phase is next, or you want that phase now | [`architect`](../../skills/architect/SKILL.md) | `ARCHITECTURE.md` on the same branch |
| **test** | The bound testing phase is next, or you want that phase now | [`test`](../../skills/test/SKILL.md) | tests and seams on that pull request. No new product behaviour |
| **restructure** | The bound refactoring phase is next, or you want that phase now. `/harden` is the same skill | [`restructure`](../../skills/restructure/SKILL.md) | refactoring on that pull request, then review |
| **review** | Bound review on an In Review PR (find and fix). `/review-fix` is the same skill | [`review`](../../skills/review/SKILL.md) | findings fixed, code review published, then ship when clean |
| **summarise** | Status, where you are, or what is next, reported and not advanced | [`summarise`](../../skills/summarise/SKILL.md) | status report. Does not run the next skill |
| **define** | Concrete work to pin down. Default front door | [`define`](../../skills/define/SKILL.md) | interview, then `PLAN.md`, class, template, branch, and pull request |
| **bug** / **tweak** / **refine** / **rework** | You **explicitly** named that skill | matching skill | interview, then the class artifact, one Task, and the same closeout chain |

**research** and **model** usually show up as define's bound `side_paths`, or because you asked for them. They do not replace define's questions.

**sandbox** is a separate bound step (`sandbox: inject`) before implement, or mid-implement when a package needs an inspect-loop. After a merge, use **sandbox** when each turn needs a visual, plot, or report, and **iterate** when a normal production fix is enough.

Maintaining this skills repo is [`/manage-skills`](../../skills/manage-skills/SKILL.md), outside the delivery catalog.

## Closed-loop shape

```text
setup → explore? → define (classify + bind) → architect → [sandbox?] → implement → test → restructure → review → ship
brownfield structure:  adopt (inventory → [characterize → architect → implement → test → restructure → review → ship] per area until Done)
post-merge fix:  ship → iterate → test → restructure → review → ship
post-merge inspect-loop:  ship → sandbox → implement → test → restructure → review → ship
```

Architect is always in the delivery chain. Test and restructure stay unless the binding records a skip. Docs-only work may skip test (`test.mode=skip`). Harden skip is an explicit user ask only. Class **adopt** never skips test.

## Bound templates

`/define` records a class and a template on `PLAN.md`. Later skills follow that binding.

| Template | Intent | Default chain |
|----------|--------|---------------|
| fix-fast | Clear defect, contained blast radius | architect → implement → test → restructure → review → ship |
| delta-fast | Small intentional behaviour change | same |
| structure-safe | Behaviour-preserving structural or docs work | same |
| parity-iterative | Implementation swap with a non-degradation bar | architect → implement (comparative loop) → test → restructure → review → ship |
| feature-standard | Ordinary feature slice | architect → implement → test → restructure → review → ship |
| feature-heavy | Cross-cutting or high-risk feature | architect → implement (multiagent OK) → test → restructure → review (full sequential) → ship |

Optional prefixes, only when the binding says so: `research` and/or `model` (`side_paths`), then `sandbox` when `sandbox: inject`.

Default parameters by template are in [`CLASSIFICATION-CATALOG.md`](../../skills/concepts/CLASSIFICATION-CATALOG.md). Structure and testing are the floor. Efficiency applies to review breadth and implement.mode only.

Override examples from that catalog (not a complete copy):

- Wide blast radius, new layers, public API, authz, or ADR risk → full multiagent review; feature prefers feature-heavy
- Purely non-behavioural docs or comments → `test.mode=skip` only; harden stays dedicated
- Math unclear and blocks acceptance → `side_paths=model`
- Literature needed before locking approach → `side_paths=research`
- Contained UI or method that needs inspect-each-turn → `sandbox=inject`
- Class adopt → `implement.verify=non-regression`, `test.mode=dedicated` (cannot skip)

## Three pipeline maps

From [`pipelines.md`](../../skills/workflow/pipelines.md):

| Situation | Workflow map |
|-----------|----------------|
| `PLAN.md` / class spec has `## Workflow`, or a legacy class artifact | **delivery** (adopt class uses **adopt**) |
| Explicit `/iterate`, or post-merge sandbox | **iterate** |
| Route Task whose Story is an explore map | **explore** until the frontier is a define-typed delivery Task |
| Invoked skill, no Task and no binding | **standalone** (Next none) |

Mode **cue** writes Next and stops. Mode **immediate** runs the next skill in the same session. Adopt walks with immediate between unit steps. `ship` runs the remaining suffix with immediate until closeout.

## Side paths vs front doors

Do not route a silent ask to `/bug`, `/tweak`, `/refine`, `/rework`, or `/sandbox`. Those are manual overrides or bound steps. The default front door for concrete work is **define**.

`/help` maps. It does not start setup, explore, define, or implement unless you ask to begin that work after help.

## Related pages

- [How it works](how-it-works.md)
- [Skills](skills.md)
- [Examples](examples.md)
