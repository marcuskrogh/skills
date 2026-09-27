# Agent Skills

Reusable agent skills for **workflow-driven delivery**. Agents prefer a catalog
workflow over freestyle coding: foggy work goes through **explore**, concrete
work through **define** (classify + bind), then a bound chain via persisted
**Next**.

Built on the [Agent Skills](https://agentskills.io) standard. Install via an
agent (preferred) or [skills.sh](https://skills.sh). Works with Cursor, Claude
Code, Codex, GitHub Copilot, and other compatible editors.

[![skills.sh](https://skills.sh/b/marcuskrogh/skills)](https://skills.sh/marcuskrogh/skills)

## Workflows

When you describe work to deliver, the model-invoked
[`workflows`](skills/workflows/SKILL.md) router picks the **first matching**
catalog row and loads only that skill. Pipeline skills stay user-invoked.
The router is how an unnamed request is recognised. Naming a skill
(`/define`, `/bug`, …) is how you invoke one directly. An explicit name wins
over re-routing.

On an active Task, bare **next**, continue, or go runs the persisted **Next**
skill once. Bare **ship**, finish, or close it out runs the remaining chain
through Done. [`/guide`](skills/guide/SKILL.md) and [`/explain`](skills/explain/SKILL.md)
can interrupt that Task without replacing its bound chain.
[`/help`](skills/help/SKILL.md) maps choices and does not start work.
[`/summarise`](skills/summarise/SKILL.md) reports status and does not advance.

Three skills are model-invoked, so the agent can discover them without a slash
name: **workflows** (which path to run), **help** (the map), and
**writing-for-agents** (editing skill or concept prose in this repo). Every
pipeline skill is user-invoked. **workflow**, **tracker**, and **jira** are
composed references. You do not start work by invoking them.

Without an explicit override or continuation: **foggy → explore**, **concrete
→ define**. A whole tree that was not built to the structure bar matches
**adopt** before define. Continuity (one Task, one branch/PR) lives in
[`workflow/reference.md`](skills/workflow/reference.md).

### How a request is recognised

Compare the rows in order. The first row that fits is the workflow.

| Workflow | Recognised when | Invoke |
|----------|-----------------|--------|
| **setup** | Delivery work and no usable `WORKSPACE.md` (repo or global), or you want the tracker, paths, or defaults changed | `/setup` |
| **continue** | Bare **next**, continue, or go on an active Task | **next** (runs the persisted Next skill once) |
| **ship** | Bare **ship**, finish, or close it out | `/ship` |
| **help** | Which skill to run, how workflows relate, or a navigation overview | `/help` |
| **explain** | Teach the current step, a decision, an interface, a numerical point, or recent agent output | `/explain` |
| **guide** | Walk through a manual task one step at a time (install, setup, hardware, or coding you want walked) | `/guide` |
| **sandbox** | Isolated inspect-loop of a contained UI, method, or bench; a bound `sandbox: inject` step; mid-implement when a package needs inspect-each-turn; or a post-merge fix where each turn needs a visual, plot, or report | `/sandbox` |
| **iterate** | A prior Task or PR is **already merged** and still broken or incomplete, and tests plus review on a new PR are enough | `/iterate` |
| **fix-forward** | The open PR has review findings | `/review` (always fixes) |
| **adopt** | The existing codebase (or the named tree) was not built to the structure bar; apply the catalog across it | `/adopt` |
| **explore** | The goal is vague, oversized, or still unclear | `/explore` |
| **research** | You explicitly want a multi-axis literature or evidence pass now | `/research` |
| **model** | You explicitly want a math formulation now | `/model` |
| **implement** | A ready-to-build `PLAN.md`, or a class artifact (`BUG.md`, `TWEAK.md`, `REFINE.md`, `REWORK.md`, `ITERATE.md`, `ADOPT.md`, `SANDBOX.md`), and you want to build or resume | `/implement` |
| **architect** | The bound architecture phase is next, or you want that phase now | `/architect` |
| **test** | The bound testing phase is next, or you want that phase now | `/test` |
| **restructure** | The bound refactoring phase is next, or you want that phase now. `/harden` is the same skill | `/restructure` or `/harden` |
| **review** | Bound review on an In Review PR (find and fix). `/review-fix` is the same skill | `/review` or `/review-fix` |
| **summarise** | Status, where you are, or what is next, reported and not advanced | `/summarise` |
| **define** | Concrete work to pin down (bug, tweak, refine, rework, feature, …). Default front door | `/define` |
| **bug** / **tweak** / **refine** / **rework** | You **explicitly** named that skill. Manual override of define's classifier | `/bug`, `/tweak`, `/refine`, `/rework` |

**research** and **model** usually show up as define's bound `side_paths`, or
because you asked for them. They do not replace define's questions.
**sandbox** is a separate bound step (`sandbox: inject`) before implement, or
mid-implement when a package needs an inspect-loop. After a merge, use
**sandbox** when each turn needs a visual, plot, or report, and **iterate**
when a normal production fix is enough.

Maintaining this skills repo (install, sync, new skill) is
[`/manage-skills`](skills/manage-skills/SKILL.md), outside the delivery
catalog. Authoring `SKILL.md` or `CONCEPT_*.md` prose is
[`writing-for-agents`](skills/writing-for-agents/SKILL.md).

### What each workflow does

| Workflow | Result |
|----------|--------|
| **setup** | `WORKSPACE.md`: tracker, artifact location, paths |
| **continue** | Runs the persisted Next skill once |
| **explore** | `ROADMAP.md` and sequenced route Tasks. No map-only pull request |
| **define** | Aligns with you, classifies, binds a template, writes `PLAN.md`, opens the delivery branch and pull request, sets **Next** |
| **adopt** | `ADOPT.md`. Inventory, then characterize → architect → implement → test → restructure → review → ship per area until Done |
| **bug** / **tweak** / **refine** / **rework** | `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md`, one Task, then the same closeout chain. Prefer `/define` unless you mean the override |
| **research** / **model** | `RESEARCH.md` / `MODEL.md` on the delivery branch. No pull request of their own |
| **sandbox** | `SANDBOX.md` plus an isolation tree on the delivery branch. No pull request of its own. After a post-merge sandbox, implement opens the pull request when the work is promoted |
| **architect** | `ARCHITECTURE.md` on the same branch |
| **implement** | Code on the Task's pull request, then test (unless the binding skips it) |
| **test** | Tests and seams on that pull request. No new product behaviour |
| **restructure** | Refactoring on that pull request, then review. Binding key stays `harden.mode` |
| **fix-forward** | Same as review, on the open pull request |
| **review** | Finds issues, fixes them on the same pull request, publishes a code review, then ship when clean |
| **iterate** | `ITERATE.md`, a **new** Task, branch, and pull request, then test → restructure → review → ship |
| **ship** | Runs whatever closeout remains, merges, marks Done |
| **summarise** | Reports purpose, stage, and the next skill. Does not run it |
| **explain** / **guide** | One paced beat or step, then waits. The bound chain stays in place |
| **help** | The short map. Stops |

### Bound template

`/define` does not leave the later stages for you to choose. After alignment
it records a **class** and a **template** on `PLAN.md`. Later skills follow
that binding. Discriminators are applied in order. The first match wins.
Catalog: [`CLASSIFICATION-CATALOG.md`](skills/concepts/CLASSIFICATION-CATALOG.md).

| Class | Recognised when | Default template |
|-------|-----------------|------------------|
| **bug** | Behaviour is wrong. The fix is the work | **fix-fast** |
| **rework** | Intentional implementation change. Measured outcomes must not degrade | **parity-iterative** |
| **adopt** | The whole tree was not built to the structure bar | **structure-safe** |
| **refine** | Bounded structure, naming, or docs. Behaviour unchanged | **structure-safe** |
| **tweak** | Small intentional behaviour change | **delta-fast** |
| **feature** | A buildable slice that needs scope and acceptance | **feature-standard** (or **feature-heavy** when the change is cross-cutting or high risk) |
| **iterate** | Prior Task already merged. Still wrong or incomplete | **fix-fast** on the new iterate Task |

Default chain:

```text
architect → implement → test → restructure → review → ship
```

Optional prefixes, only when the binding says so: `research` and/or `model`
(`side_paths`), then `sandbox` when `sandbox: inject`. Test and restructure
stay in the chain unless the binding records a skip. Class **adopt** walks
`characterize → architect → implement → test → restructure → review → ship`
per area.

```text
setup → explore? → define → architect → [sandbox?] → implement → test → restructure → review → ship
brownfield:  adopt (inventory, then that unit chain per area until Done)
post-merge fix:  ship → iterate → test → restructure → review → ship
post-merge inspect-loop:  ship → sandbox → implement → test → restructure → review → ship
```

## Concepts vs skills

Concepts own **invariants**. Skills fill **extensions** only. See
[`writing-for-agents`](skills/writing-for-agents/SKILL.md).

Operator-directed replies follow
[`CONCEPT_LANGUAGE`](skills/concepts/CONCEPT_LANGUAGE.md) whenever the skills are
installed. Phrase and cadence tables stay in
[`LANGUAGE-PHRASES`](skills/concepts/LANGUAGE-PHRASES.md) and
[`LANGUAGE-HUMANIZER`](skills/concepts/LANGUAGE-HUMANIZER.md). Always-on
extracts name those files; they do not copy the tables.

Sub-agent routing:
[`CONCEPT_DELEGATION`](skills/concepts/CONCEPT_DELEGATION.md) and the detected
file under [`concepts/platforms/`](skills/concepts/platforms/cursor.md).

## Architecture

```
skills/                         ← source of truth (Agent Skills layout)
├── concepts/                   ← uninvokable CONCEPT_*.md + disclosed refs
├── workflow/                   ← delivery contract (composed; not an entry point)
├── workflows/                  ← model-invoked router
├── help/                       ← model-invoked map (does not start work)
├── explain/ guide/             ← teach the current step; walk a manual task
├── setup/ explore/ define/     ← front doors
├── bug/ tweak/ refine/ rework/ ← manual class overrides
├── adopt/ research/ model/ sandbox/
├── architect/ implement/ test/
├── restructure/ harden/        ← harden aliases restructure
├── review/ review-fix/         ← review-fix aliases review
├── iterate/ ship/ summarise/
├── tracker/ jira/              ← composed tracker (not entry points)
├── manage-skills/              ← install, sync, and repo maintenance
└── writing-for-agents/         ← model-invoked authoring guide

.claude-plugin/                 ← optional Claude Code marketplace manifests
scripts/                        ← validate, sync, install-from-git, arXiv helper
templates/agent-install/        ← consumer AGENTS.md block + Cursor rule
templates/project-sync/         ← startup sync script template
```

Short map, if you only want which front door to use: [`/help`](skills/help/SKILL.md).

## Install

### Ask an agent (preferred)

Use the prompt in [`agent-install.md`](skills/manage-skills/agent-install.md).
Do not freestyle a different install layout.

```bash
curl -fsSL https://raw.githubusercontent.com/marcuskrogh/skills/main/scripts/install-from-git.sh | bash
```

The script replaces `.agents/skills/` (all skills + `concepts/`), stamps
`.skills-version`, and wires prefer-workflow pointers.

### Or use skills.sh (`npx`)

```bash
npx skills add marcuskrogh/skills
```

`npx` does not write the prefer-workflow `AGENTS.md` block. Use the agent
installer when you want that wiring.

### Updating skills

How to advance an existing install: [`manage-skills`](skills/manage-skills/SKILL.md)
(Updating an existing install). Pin with `SKILLS_REF=<tag-or-sha>` on
`install-from-git.sh` or `.agents/sync-skills.sh`.

### Optional: Claude Code plugin

```bash
claude plugin marketplace add marcuskrogh/skills
claude plugin install marcus-skills@marcuskrogh
```

### Author setup (this repo)

```powershell
.\scripts\setup.ps1
```

Validates skills, mirrors them into local agent homes, and installs git hooks
so `git pull` re-syncs.

### Project sync (CI / cloud / VM)

```powershell
.\scripts\setup-project-sync.ps1 -ProjectPath C:\path\to\repo
```

Writes `.agents/sync-skills.sh` and gitignores `.agents/skills/`. For Cursor
Cloud, also pass `-WireCursorCloud` so **install** and **start** both sync.

## Workspace scopes

`/setup` writes a `WORKSPACE.md` at one of two scopes:

| Scope | Path | Committed? | Applies to |
|-------|------|-----------|------------|
| **repository** | `docs/agents/WORKSPACE.md` | Yes | That repo and its collaborators |
| **global** | `~/.agents/WORKSPACE.md` | Never | Every repo on this machine |

Resolution order is in [`setup/format.md`](skills/setup/format.md). Repository
fields override global fields one by one. Language is not a workspace field; a
repo install writes the language extract into `AGENTS.md`, `CLAUDE.md`, and
`.cursor/rules/github-skills.mdc`.

### Keeping repos clean

Global scope plus `Artifact location: external` runs the pipeline without adding
agent files to a consuming repo. Artifact full content is pushed into the
tracker issue. Only the code change lands in the repo, on the Task's delivery
branch/PR.

## Workflow for skill changes

1. Edit `skills/<name>/` or `skills/concepts/` in this repo.
2. `.\scripts\validate-skills.ps1`
3. `.\scripts\sync-local.ps1 -Prune`
4. `git commit` / `git push`

Use `/manage-skills` for the full checklist.

## Scripts

| Script | Purpose |
|--------|---------|
| `install-from-git.sh` | Canonical agent/project install from git |
| `setup.ps1` | Author setup: validate, sync local homes, git hooks |
| `sync-local.ps1` / `sync-local.sh` | Mirror `skills/` into local agent homes |
| `install-to-project.ps1` | Copy skills into a project's `.agents/skills` |
| `validate-skills.ps1` | Frontmatter, naming, plugin.json coverage, concepts |
| `setup-project-sync.ps1` | Wire startup sync (optional `-WireCursorCloud`) |
| `templates/project-sync/sync-skills.sh` | Startup sync to `.agents/skills/` + `.skills-version` |
| `templates/agent-install/` | Consumer `AGENTS.md` block, Cursor rule, global language pointers |
| `setup-github.ps1` | First-time push to GitHub |
| `arxiv_research.py` | arXiv search, lookup, and snowball for `/research` |

## Tracker credentials

Configured by `/setup` in `docs/agents/WORKSPACE.md`.

| Provider | Needs |
|----------|-------|
| **markdown** | None (issues under `docs/agents/issues/`) |
| **jira** | `JIRA_BASE_URL`, `JIRA_EMAIL`, `JIRA_API_TOKEN`, project key |
| **github** | Authenticated `gh` CLI |
| **linear** | Linear MCP or `LINEAR_API_KEY` + team key |

`review` and `ship` also need an authenticated `gh` CLI for PRs.
