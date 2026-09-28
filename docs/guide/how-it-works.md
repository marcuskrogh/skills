# How it works

How the installed skills set behaves after install. Source: [`workflows`](../../skills/workflows/SKILL.md), [`help`](../../skills/help/SKILL.md), [`writing-for-agents`](../../skills/writing-for-agents/SKILL.md), [`workflow/reference.md`](../../skills/workflow/reference.md), and [`CONCEPT_LANGUAGE`](../../skills/concepts/CONCEPT_LANGUAGE.md).

Return to the [front page](../../README.md).

## Skills vs concepts

A **skill** is invokable. It applies one or more concepts and produces one output (a markdown spec, a delivery diff, a published review, or a paced reply). It can run alone. It does not name the skill that follows.

A **concept** is never invoked. It owns invariants every applying skill shares. Long catalogs sit in sibling files (`CLASSIFICATION-CATALOG.md`, `STRUCTURE-CATALOG.md`, platform files).

The bound **workflow** chooses order and how each step uses the previous output. That map lives in [`pipelines.md`](../../skills/workflow/pipelines.md), not inside each skill.

## Three kinds of skill

From [`SKILL-MECHANICS.md`](../../skills/writing-for-agents/SKILL-MECHANICS.md):

| Kind | Invocation | Examples |
|------|------------|----------|
| Router | model-invoked | `workflows`, `writing-for-agents`, `help` |
| Pipeline / meta | user-invoked | `explore`, `define`, `implement`, `manage-skills`, … |
| Composed reference | user-invoked, not for humans | `workflow`, `tracker`, `jira` |

Model-invoked means the agent can discover the skill from its description without a slash name. Pipeline skills stay user-invoked so their descriptions do not load every turn. Discovery of which pipeline to run is `workflows`' job.

Aliases: `/harden` runs [`restructure`](../../skills/restructure/SKILL.md). `/review-fix` runs [`review`](../../skills/review/SKILL.md). Binding keys stay `harden.mode`.

## How a request is recognised

When you describe work to deliver, the model-invoked [`workflows`](../../skills/workflows/SKILL.md) router picks the **first matching** catalog row and loads only that skill. Compare rows in order. The first row that fits is the workflow.

Naming a skill (`/define`, `/bug`, …) invokes it directly. An explicit name wins over re-routing.

Without an explicit override or continuation:

- Foggy, oversized, or unclear destination → **explore**
- Concrete work (bug, tweak, refine, rework, feature, …) → **define**
- Whole existing tree not built to the structure bar → **adopt** (before define)

A short description starts define's interview. It does not approve the plan.

Full row table: [Workflows](workflows.md).

## Interview, class, and binding

**define** (and the manual class skills) interview until scope, behaviour or parity, constraints, and pass criteria are settled and you approve the readiness prompt. Then the agent classifies and binds.

Classes are closed. Discriminators are applied in order. First match wins. Catalog: [`CLASSIFICATION-CATALOG.md`](../../skills/concepts/CLASSIFICATION-CATALOG.md).

| Class | Recognised when | Default template |
|-------|-----------------|------------------|
| bug | Behaviour is wrong. The fix is the work | fix-fast |
| rework | Intentional implementation change. Measured outcomes must not degrade | parity-iterative |
| adopt | The whole tree was not built to the structure bar | structure-safe |
| refine | Bounded structure, naming, or docs. Behaviour unchanged | structure-safe |
| tweak | Small intentional behaviour change | delta-fast |
| feature | A buildable slice that needs scope and acceptance | feature-standard (feature-heavy when cross-cutting or high risk) |
| iterate | Prior Task already merged. Still wrong or incomplete | fix-fast on the new iterate Task |

The template records implement, test, harden, and review parameters. Later skills honor that binding. They do not reclassify unless you overturn it.

## Next

A reply that finishes a skill ends with:

```markdown
## Next
`/<skill> <ISSUE-KEY>` — <one-line why>
```

The heading, the slash invoke, and the em dash stay exact. An open interview question has no `## Next` block and does not start the next skill.

The **workflow** writes that line (chat, tracker comment, artifact, ISSUES mirror). Skills do not choose the successor.

Bare cues on an active Task ([`workflow/reference.md`](../../skills/workflow/reference.md)):

| Cue | Meaning |
|-----|---------|
| **next**, continue, go | Run the persisted Next skill once |
| **ship**, finish, close it out | Run remaining chain through Done |

`/guide` and `/explain` can interrupt without replacing the bound chain. While a paced walkthrough or explanation is open, yes / okay / move on is **advance**, not continue.

## One Task, one branch, one pull request

From [`workflow/reference.md`](../../skills/workflow/reference.md):

- One delivery Task owns the work from ready-to-build through ship.
- One open delivery branch and pull request per delivery Task.
- Research, model, and sandbox commit finding docs (and the sandbox isolation tree) onto that branch and **never** open a pull request of their own.
- Explore charts `ROADMAP.md`. It does not open a map-only pull request.
- Define / bug / tweak / refine / rework / adopt open the delivery pull request (implement opens it after a post-merge sandbox).
- Iterate (post-merge) starts a new Task, branch, and pull request.

## Workspace and tracker

Pipeline skills need a `WORKSPACE.md` first.

| Scope | Path | Committed? |
|-------|------|------------|
| repository | `docs/agents/WORKSPACE.md` | Yes |
| global | `~/.agents/WORKSPACE.md` | Never |

Resolution order is in [`setup/format.md`](../../skills/setup/format.md). Repository fields override global fields one by one. If neither exists, delivery work routes to `/setup`.

Tracker provider is chosen in that file: markdown, Jira, GitHub, or Linear. Pipeline skills compose [`tracker`](../../skills/tracker/SKILL.md). You configure the tracker through `/setup`, not by invoking tracker.

Status chain: To Do → In Progress → In Review → Done. Delivery Tasks reach Done only via **ship**.

## Language

Operator-directed replies follow [`CONCEPT_LANGUAGE`](../../skills/concepts/CONCEPT_LANGUAGE.md). Phrase and cadence tables stay in [`LANGUAGE-PHRASES`](../../skills/concepts/LANGUAGE-PHRASES.md) and [`LANGUAGE-HUMANIZER`](../../skills/concepts/LANGUAGE-HUMANIZER.md). Always-on extracts name those files. They do not copy the tables.

Keep **harness** for the agent host (Cursor, Claude Code, Codex, Copilot, and other Agent Skills hosts). Do not use it for a sandbox tree, wrapper, or other code. Spell local names in full.

Skill and concept files follow [`writing-for-agents`](../../skills/writing-for-agents/SKILL.md), not operator language.

## Sub-agent routing

Before every Task spawn, the agent loads [`CONCEPT_DELEGATION`](../../skills/concepts/CONCEPT_DELEGATION.md) and the matching file under [`concepts/platforms/`](../../skills/concepts/platforms/cursor.md). On Cursor, model slugs are catalog-closed as described in the always-on extract.

## What maintaining this repo is

Install, sync, new skill, and plugin coverage are [`/manage-skills`](../../skills/manage-skills/SKILL.md). That path sits outside the delivery catalog. Authoring `SKILL.md` or `CONCEPT_*.md` is [`writing-for-agents`](../../skills/writing-for-agents/SKILL.md).

## Related pages

- [Workflows](workflows.md)
- [Skills](skills.md)
- [Examples](examples.md)
