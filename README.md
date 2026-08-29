# Agent Skills

Reusable agent skills for **workflow-driven delivery** — not a flat skill dump.
Agents prefer a catalog workflow over freestyle coding: foggy work goes through
**explore**, concrete work through **define** (classify + bind), then a bound
chain via persisted **Next** through implement → test → harden → review-fix → ship.

Built on the [Agent Skills](https://agentskills.io) standard. Install via an
agent (preferred when possible) or [skills.sh](https://skills.sh); works with any
compatible harness (Cursor, Claude Code, Codex, GitHub Copilot, and others).

[![skills.sh](https://skills.sh/b/marcuskrogh/skills)](https://skills.sh/marcuskrogh/skills)

## Workflows

The central idea: **prefer workflow**. When you describe work to deliver — with
or without naming a skill — the model-invoked
[`workflows`](skills/workflows/SKILL.md) router picks a catalog path and loads
only that skill. Pipeline skills stay user-invoked
(`disable-model-invocation`); `workflows` is the always-loaded pointer that
keeps delivery discoverable without dumping every skill into context.

Lost on which skill to use? Ask for [`/help`](skills/help/SKILL.md) — maps
the set; does not start delivery. Want the current step taught?
[`/explain`](skills/explain/SKILL.md). Want to be walked through a task?
[`/guide`](skills/guide/SKILL.md).

### Front doors

| If you… | Run | What happens |
|---------|-----|----------------|
| Have no usable workspace yet | `/setup` | `WORKSPACE.md` (tracker + paths) |
| Feel a big/foggy goal but not the steps | `/explore` | `ROADMAP.md` + route Tasks; research/model/sandbox = artifacts on the delivery branch → `/define` |
| Have concrete work (bug, tweak, refine, rework, feature, …) | `/define` | Align → **classify** → **bind workflow** → `PLAN.md` + **Next** |

Without an explicit override or continuation: **foggy → explore**, **concrete →
define**. Do not route silent asks to `/bug` `/tweak` `/refine` `/rework`
`/sandbox`.

### Define: classify + bind

[`/define`](skills/define/SKILL.md) is the default front door for concrete work.
After user alignment it:

1. Infers a closed **class** (bug / tweak / refine / rework / feature / …)
2. Binds an efficient **template** + **parameters** (e.g. fix-fast,
   parity-iterative, feature-heavy; single vs multiagent; verify mode;
   **test and harden are always bound** unless the user explicitly skips them;
   review depth and lasers; optional research/model side paths; optional sandbox
   inspect-loop)
3. Writes Classification + Workflow onto `PLAN.md` and the tracker
4. Sets **Next** to the first step of the bound **Chain**

Later skills honor that binding; they do not re-guess class from vibes.
Catalog: [`CONCEPT_CLASSIFICATION`](skills/concepts/CONCEPT_CLASSIFICATION.md) +
[`CLASSIFICATION-CATALOG`](skills/concepts/CLASSIFICATION-CATALOG.md).

### Persisted Next and continuations

Every pipeline skill ends by writing **Next** to durable surfaces (artifact,
tracker, mirror). Continuations:

| Cue | Meaning |
|-----|---------|
| **next** / continue | Advance **one** persisted Next step |
| **ship** / finish / close it out | Finish **remaining** work through Done |

Explicit `/skill` names win over re-routing. In-flight Task + valid Next →
continue or ship, not a new map — unless they asked for a walkthrough
([`/guide`](skills/guide/SKILL.md)) or teaching
([`/explain`](skills/explain/SKILL.md)). Details:
[`workflow/reference.md`](skills/workflow/reference.md),
[`workflow/handoff.md`](skills/workflow/handoff.md).

### Typical chain

```text
setup → explore? → define (classify + bind) → [sandbox?] → [bound chain, often implement → test → harden → review-fix → ship]
```

Explore charts a **map**; research / model commit **finding docs**
(`RESEARCH.md` / `MODEL.md`) onto the delivery branch and **never open their
own PRs**. Sandbox commits `SANDBOX.md` plus an isolation tree the same way —
inspect each iteration without shipping production. Define opens the single
delivery PR. Each define Task owns **one
delivery branch + one PR** through ship. Continuing via **Next** reuses that
branch/PR (implement reads research/model docs when writing product docs, and
promotes an accepted sandbox). **`/ship`** may run after define (or mid-chain) to finish any **remaining**
steps, then merge and close out.

### Post-ship iterate

```text
ship → iterate → test → harden → review-fix → ship → (optional) iterate …
ship → sandbox → implement → test → harden → review-fix → ship   # inspect-loop instead of iterate
```

`/iterate` opens a **new** Task/branch/PR after merge (not fix-forward on an
open PR) when the delta is a straightforward production fix. Prefer
[`/sandbox`](skills/sandbox/SKILL.md) when each turn needs visual, plot, or
report inspection of a contained element — the sandbox must be
**representative** of production in every area that would change the
inspectable or comparison, then implement promotes. `/review` is findings-only;
`/review-fix` runs lasers → fix-forward → **code review** → CLEAN. `/test` and
`/harden` are the dedicated testing and structure phases before that.
`/summarise` reports status anytime without advancing.

### Manual overrides vs define

`/bug`, `/tweak`, `/refine`, `/rework` remain user-invokable when you want to
skip define’s classifier. Prefer `/define` for new work — the agent classifies
and binds. Explicit slash always wins.

### Compact catalog

Pick the **first matching** row (same order as
[`workflows/SKILL.md`](skills/workflows/SKILL.md)):

| Workflow | When | First skill |
|----------|------|-------------|
| **setup** | Delivery work with no usable `WORKSPACE.md`, or change tracker/paths | [setup](skills/setup/SKILL.md) |
| **continue** | Bare **next** / persisted Next on an active Task | Run persisted Next once |
| **ship** | Bare **ship** / finish remaining through Done | [ship](skills/ship/SKILL.md) |
| **help** | Which skill / navigation overview | [help](skills/help/SKILL.md) |
| **explain** | Current step or decision taught in simple terms | [explain](skills/explain/SKILL.md) |
| **guide** | Walk through a manual task one step at a time | [guide](skills/guide/SKILL.md) |
| **sandbox** | Explicit isolated inspect-loop; or post-merge instead of iterate when each turn needs inspection | [sandbox](skills/sandbox/SKILL.md) |
| **iterate** | Prior Task/PR **already merged**; still broken — straightforward production fix | [iterate](skills/iterate/SKILL.md) |
| **fix-forward** | Open PR has review findings / REQUEST_CHANGES | [review-fix](skills/review-fix/SKILL.md) |
| **explore** | Vague, oversized, or foggy initiative | [explore](skills/explore/SKILL.md) |
| **research** / **model** | Explicit multi-axis evidence or math now | [research](skills/research/SKILL.md) / [model](skills/model/SKILL.md) |
| **implement** | Ready-to-build PLAN (or legacy artifact / SANDBOX.md) exists | [implement](skills/implement/SKILL.md) |
| **test** / **harden** | Dedicated testing or structure closeout phases | [test](skills/test/SKILL.md) / [harden](skills/harden/SKILL.md) |
| **review** / **review-fix** | Findings only, or lasers→fix→code review→CLEAN | [review](skills/review/SKILL.md) / [review-fix](skills/review-fix/SKILL.md) |
| **summarise** | Status reported, not advanced | [summarise](skills/summarise/SKILL.md) |
| **define** | Concrete work to pin down — **default front door** | [define](skills/define/SKILL.md) |
| **bug** / **tweak** / **refine** / **rework** | User **explicitly** named that skill | matching skill |

Side paths **research** / **model** usually appear via define’s bound
`side_paths` or an explicit ask. **sandbox** is a separate bound step
(`sandbox: inject`), an explicit `/sandbox`, or the post-merge inspect-loop
instead of iterate. **guide** and **explain** interrupt to walk or teach
without opening a Task. Maintaining this skills repo →
[`manage-skills`](skills/manage-skills/SKILL.md).

### Delivery contract (one line)

One Task → one open delivery branch/PR through ship; research / model add finding
docs on that branch only (no separate PR); sandbox adds a representative harness
the same way; explore maps without owning a route
PR; iterate (post-merge only) opens a new Task + PR; sandbox post-merge opens a
new Task + branch without a PR. Continuity (keys, status,
Next, artifacts, branch/PR) mirrors to markdown when enabled — see
[`skills/workflow/`](skills/workflow/SKILL.md).

## Concepts vs skills

| | Skills | Concepts |
|-|--------|----------|
| Path | `skills/<name>/SKILL.md` | `skills/concepts/CONCEPT_<NAME>.md` |
| In agent skill list | Yes (name + description) | **No** |
| Invokable | Yes (unless `disable-model-invocation`) | Never |
| Loaded when | Skill is invoked / composed | An invoked skill instructs the agent to read it |

Concepts own **invariants**; skills fill **extensions** only — see
[`writing-for-agents`](skills/writing-for-agents/SKILL.md). Example: `define`
applies alignment + definition + **classification** for concrete work; `bug` /
`tweak` / `refine` / `rework` are manual overrides with the same class
semantics. User-facing agent prose follows
[`CONCEPT_LANGUAGE`](skills/concepts/CONCEPT_LANGUAGE.md).

**Sub-agent value routing:** skills that delegate (`implement`, `test`, `harden`,
`review`, `review-fix`, `sandbox`, and composers like `ship` / `iterate` / `research` axes)
apply [`CONCEPT_DELEGATION`](skills/concepts/CONCEPT_DELEGATION.md) — score
difficulty (Routine → low, Moderate → mid, Demanding → high), keep the manager
on high-capability, escalate one tier at a time, and pick **catalog-closed**
from [`PLATFORM-CATALOGS.md`](skills/concepts/PLATFORM-CATALOGS.md) (then only
the detected harness file under `concepts/platforms/`) for **every** `Task`
type (`computerUse`, `videoReview`, …). On **Cursor**, that file is a closed
allowlist of **Composer** + **Grok** only (`composer-2.5` for Routine /
Moderate; `cursor-grok-4.6-high` for Demanding / manager). No `*-fast` variants;
third-party picker models bill the API budget — see
[`platforms/cursor.md`](skills/concepts/platforms/cursor.md). Sandbox inspect
capture stays on the manager.

## Architecture

```
skills/                         ← source of truth (Agent Skills layout)
├── concepts/                   ← uninvokable CONCEPT_*.md + disclosed refs
│   ├── CONCEPT_ALIGNMENT.md
│   ├── CONCEPT_CLASSIFICATION.md
│   ├── CLASSIFICATION-CATALOG.md
│   ├── CONCEPT_DELEGATION.md   ← difficulty → low/mid/high; catalogs disclosed
│   ├── PLATFORM-CATALOGS.md
│   ├── platforms/              ← cursor, claude-code, codex, github-copilot, general
│   ├── CONCEPT_IMPLEMENTATION.md
│   ├── CONCEPT_ITERATION.md
│   ├── CONCEPT_LANGUAGE.md     ← user-facing prose; setup can persist general
│   ├── CONCEPT_DEFINITION.md
│   ├── CONCEPT_GUIDANCE.md
│   ├── CONCEPT_EXPLANATION.md
│   ├── CONCEPT_RESEARCH.md
│   ├── CONCEPT_REVIEW.md
│   ├── CONCEPT_SANDBOX.md
│   ├── CONCEPT_STRUCTURE.md    ← Clean Code / SOLID / smell bar
│   └── STRUCTURE-CATALOG.md
├── workflow/                   ← lean delivery contract + disclosed refs
├── workflows/                  ← model-invoked router (explore/define front doors)
├── setup/                      ← workspace alignment → WORKSPACE.md
├── explore/                    ← fog-clearing wayfinding → ROADMAP.md
├── define/                     ← front door: align + classify + bind → PLAN.md
├── bug/                        ← manual override → BUG.md
├── tweak/                      ← manual override → TWEAK.md
├── refine/                     ← manual override → REFINE.md
├── rework/                     ← manual override → REWORK.md (comparative eval)
├── research/                   ← finding docs → RESEARCH.md on delivery branch (no PR)
├── model/                      ← math finding docs → MODEL.md on delivery branch (no PR)
├── sandbox/                    ← isolated inspect-loop → SANDBOX.md + harness (no PR)
├── implement/                  ← honors PLAN Workflow binding; structure as-you-go
├── test/                       ← dedicated testing phase
├── harden/                     ← dedicated structure phase
├── iterate/                    ← post-ship fix → test → harden → review-fix
├── review/                     ← lasers + code review; honors bound review.mode/depth/lasers
├── review-fix/                 ← lasers → fix-forward → code review → CLEAN
├── ship/                       ← remaining-workflow orchestrator → Done
├── summarise/                  ← status: about / stage / Next
├── help/                       ← front-door map (does not start delivery)
├── explain/                    ← paced teaching of current step and decisions
├── guide/                      ← paced walkthrough of a manual task
├── tracker/                    ← pluggable issue tracker
├── jira/                       ← Jira REST details
├── manage-skills/              ← meta: maintain this repo
└── writing-for-agents/         ← lean shapes + vocabulary

.claude-plugin/                 ← optional Claude Code marketplace manifests
scripts/                        ← validate / sync / install-from-git / project bootstrap
templates/agent-install/        ← consumer AGENTS.md block + Cursor rule
templates/project-sync/         ← startup sync script template
```

### Pipeline skills

| Skill | Invoke | Purpose |
|-------|--------|---------|
| **setup** | user | Workspace alignment → `WORKSPACE.md` (repository or global) |
| **explore** | user | Clear fog → `ROADMAP.md` + Story + route Tasks (one delivery unit; research/model = finding docs, no separate PRs) |
| **define** | user | **Front door** for concrete work → align, classify, bind → `PLAN.md` |
| **bug** / **tweak** / **refine** / **rework** | user | Manual overrides; prefer `/define` for new work |
| **research** / **model** | user | Finding docs on delivery branch (no PR; often via define `side_paths`) |
| **sandbox** | user | Isolated, representative inspect-loop on delivery branch (no PR; inject, mid-implement, or post-merge instead of iterate) |
| **implement** | user | Build on the **same** delivery branch/PR; tests and structure as-you-go; promotes SANDBOX |
| **test** | user | Adversarial testing phase on the same PR |
| **harden** | user | Behaviour-preserving structure phase on the same PR |
| **iterate** | user | Post-ship straightforward fix → new Task/branch/PR → test → harden → review-fix |
| **review** | user | Laser findings + published code review (no auto-fix) |
| **review-fix** | user | Lasers → fix-forward → code review → CLEAN → ship |
| **ship** | user | Finish remaining along the bound chain, then merge + Done |
| **summarise** | user | About / stage / what to run Next (does not advance) |
| **help** | model | Front-door map — maps skills; does not start delivery |
| **explain** | user | Paced teaching of the current step and decisions |
| **guide** | user | Paced walkthrough of a manual task; does not start delivery |

### Other skills

| Skill | Invoke | Purpose |
|-------|--------|---------|
| **workflows** | model | Infer which pipeline fits, then load and run that skill |
| **manage-skills** | user | Maintain and sync this repository |
| **writing-for-agents** | model | Lean shapes + vocabulary when authoring skills/concepts |
| **tracker** | composed | Issue tracker contract + backends |
| **jira** | composed | Jira REST details for the jira backend |
| **workflow** | composed | Pipeline continuity + handoffs |

## Install

### Ask an agent (preferred)

Paste this into an agent in the **consuming** repo. Do not freestyle a different
install layout.

```text
Install marcuskrogh/skills into this repository from git using the canonical
installer. Do not use another install method.

1. From the project root, run exactly:
   curl -fsSL https://raw.githubusercontent.com/marcuskrogh/skills/main/scripts/install-from-git.sh | bash
2. If curl|bash is unavailable: shallow-clone
   https://github.com/marcuskrogh/skills.git at ref main into a temp dir, then
   run: bash <clone>/scripts/install-from-git.sh
3. Commit the paths the script lists (.agents/skills/, AGENTS.md, CLAUDE.md,
   .cursor/rules/github-skills.mdc).
4. Confirm .agents/skills/.skills-version exists and
   .agents/skills/workflows/SKILL.md is present.
```

That script replaces `.agents/skills/` (all skills + `concepts/`), stamps
`.skills-version`, and wires prefer-workflow pointers. Full invariants:
[`skills/manage-skills/agent-install.md`](skills/manage-skills/agent-install.md).

### Or use skills.sh (`npx`)

```bash
npx skills add marcuskrogh/skills
```

Pick the skills you want and which agents to install them for. Skills land in
each agent's standard skill directory (project or global). Relative links stay
intact because they install as siblings under `.agents/skills/` (or the
equivalent home). Concepts install alongside as `concepts/` (not invokable).
`npx` does not write the prefer-workflow `AGENTS.md` block — use the agent
installer when you want that wiring.

### Updating skills (existing install → latest main)

| Install style | Command |
|---------------|---------|
| **Agent-from-git** | Re-run `scripts/install-from-git.sh` (or the agent prompt above), then commit |
| **skills.sh** | `npx skills update -y` |
| **skills.sh** (force re-add) | `npx skills add marcuskrogh/skills -y` |
| **Startup sync** | `SKILLS_REF=main bash .agents/sync-skills.sh` |
| **Committed copy** (`install-to-project.ps1`) | Pull/clone this repo on `main`, re-run the install script, commit `.agents/skills/` |

Agent-from-git, startup sync, and `install-to-project` write
`.agents/skills/.skills-version` (`repo`, `ref`, `sha`, `synced_at`).

Projects that already committed an older `.agents/sync-skills.sh` should refresh
that script from `templates/project-sync/sync-skills.sh` (or re-run
`setup-project-sync.ps1`) before relying on `SKILLS_REF` / the version stamp.

Pin a tag or commit, then return to tracking `main`:

```bash
SKILLS_REF=<tag-or-sha> bash /path/to/install-from-git.sh   # pin
SKILLS_REF=main bash /path/to/install-from-git.sh           # latest main again
# startup sync equivalent:
SKILLS_REF=<tag-or-sha> bash .agents/sync-skills.sh
SKILLS_REF=main bash .agents/sync-skills.sh
```

### Optional: Claude Code plugin

```bash
claude plugin marketplace add marcuskrogh/skills
claude plugin install marcus-skills@marcuskrogh
```

Or inside Claude Code: `/plugin marketplace add marcuskrogh/skills` then
`/plugin install marcus-skills@marcuskrogh`.

| Path | Philosophy |
|------|------------|
| **Agent-from-git** | Canonical committed install + prefer-workflow pointers — agents run one script |
| **skills.sh** | Editable copies in your project — fork and adapt (CLI / multi-harness) |
| **Claude plugin** | Read-only bundle that updates when this repo ships |

### Author setup (this repo)

```powershell
.\scripts\setup.ps1
```

Validates skills, mirrors them into common local agent homes (`.agents`,
`.claude`, `.codex`, `.copilot`, `.cursor`), and installs git hooks so `git pull`
re-syncs.

### Project sync (CI / cloud / VM)

For environments that should pull skills at startup instead of committing them:

```powershell
.\scripts\setup-project-sync.ps1 -ProjectPath C:\path\to\repo
```

Writes `.agents/sync-skills.sh` and gitignores `.agents/skills/`. Each sync
checks out `SKILLS_REF` (default `main`), replaces `.agents/skills/`, and
records the revision in `.agents/skills/.skills-version`.

If the environment is **Cursor Cloud**, also pass `-WireCursorCloud` to add
`.cursor/environment.json` that runs the same sync on **install** (Build) and
**start** (every boot). `start` matters because Cursor can reuse a snapshotted
Build and skip re-running `install`, which would otherwise leave skills stale
while `marcuskrogh/skills` advances on `main`.

## Workspace scopes

`/setup` writes a `WORKSPACE.md` at one of two scopes:

| Scope | Path | Committed? | Applies to |
|-------|------|-----------|------------|
| **repository** | `docs/agents/WORKSPACE.md` | Yes | That repo and its collaborators |
| **global** | `~/.agents/WORKSPACE.md` | Never | Every repo on this machine |

Resolution order, evaluated before any tracker or artifact operation:

1. `$AGENT_WORKSPACE_FILE` (explicit override)
2. Repo `docs/agents/WORKSPACE.md`
3. Global `~/.agents/WORKSPACE.md`, then `$XDG_CONFIG_HOME/agents/WORKSPACE.md`,
   then harness homes (`~/.copilot`, `~/.claude`, `~/.codex`, `~/.cursor`)
4. Neither → the skill stops and asks you to run `/setup`

Repository fields **override global fields one by one**, so a repo can change
just the tracker and inherit everything else. Set `Extends global: false` in a
repo file to opt out of inheritance entirely.

`/setup` also asks **Agent language**: `user-facing` (default; skill replies)
or `general` (the same [CONCEPT_LANGUAGE](skills/concepts/CONCEPT_LANGUAGE.md)
contract on all operator-directed agent prose in that workspace). A global
file can set it for every repo; a repo field overrides.

### Keeping repos clean

Global scope plus `Artifact location: external` runs the whole pipeline without
adding a single file to a consuming repo:

- `WORKSPACE.md` lives in `~/.agents/`
- `PLAN.md` / `ROADMAP.md` / `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` /
  `MODEL.md` / `RESEARCH.md` / `SANDBOX.md` / `ITERATE.md` are written under
  `~/.agents/artifacts/<repo>/` and their **full content is pushed into the
  tracker issue**, which becomes the durable, shareable copy
- Disable the markdown mirror so the remote tracker is the sole source of truth

Only the code change itself lands in the repo, on the Task's delivery branch/PR.

## Workflow for skill changes

1. Edit `skills/<name>/` or `skills/concepts/` in this repo.
2. `.\scripts\validate-skills.ps1`
3. `.\scripts\sync-local.ps1 -Prune` (or rely on the post-merge hook after `git pull`)
4. `git commit` / `git push`

Use `/manage-skills` for the full checklist.

## Scripts

| Script | Purpose |
|--------|---------|
| `install-from-git.sh` | **Canonical** agent/project install from git → `.agents/skills/` + pointers |
| `setup.ps1` | Author setup — validate, sync local homes, git hooks |
| `sync-local.ps1` / `sync-local.sh` | Mirror `skills/` into local agent homes |
| `install-to-project.ps1` | Copy skills into a project's `.agents/skills` (from a local clone) |
| `validate-skills.ps1` | Frontmatter, naming, plugin.json coverage, concepts |
| `setup-project-sync.ps1` | Wire startup sync into a project (optional `-WireCursorCloud`) |
| `templates/project-sync/sync-skills.sh` | Startup sync: fetch `SKILLS_REF` (default `main`) → `.agents/skills/` + `.skills-version` |
| `templates/agent-install/` | Consumer `AGENTS.md` block + Cursor rule used by `install-from-git.sh` |
| `setup-github.ps1` | First-time push to GitHub |

## Tracker credentials

Configured by `/setup` in `docs/agents/WORKSPACE.md`. Provider-specific:

| Provider | Needs |
|----------|-------|
| **markdown** | None (issues under `docs/agents/issues/`) |
| **jira** | `JIRA_BASE_URL`, `JIRA_EMAIL`, `JIRA_API_TOKEN`, project key |
| **github** | Authenticated `gh` CLI |
| **linear** | Linear MCP or `LINEAR_API_KEY` + team key |

`review` and `ship` also need an authenticated `gh` CLI for PRs.
