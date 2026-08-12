# Agent Skills

Reusable agent skills for workspace setup, alignment, definition, tweaks, refinements, reworks, modelling, implementation, review, and ship.

Built on the [Agent Skills](https://agentskills.io) standard. Install via an agent (preferred when possible) or [skills.sh](https://skills.sh); works with any compatible harness (Cursor, Claude Code, Codex, GitHub Copilot, and others).

[![skills.sh](https://skills.sh/b/marcuskrogh/skills)](https://skills.sh/marcuskrogh/skills)

## Quickstart

### Ask an agent (preferred)

Paste this into an agent in the **consuming** repo. Do not freestyle a different install layout.

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

Pick the skills you want and which agents to install them for. Skills land in each agent's standard skill directory (project or global). Relative links between skills stay intact because they install as siblings under `.agents/skills/` (or the equivalent home for that agent). Concepts install alongside as `concepts/` (not invokable). `npx` does not write the prefer-workflow `AGENTS.md` block — use the agent installer when you want that wiring.

## Updating skills (existing install → latest main)

If a project already has skills installed and you want the newest `main`:

| Install style | Command |
|---------------|---------|
| **Agent-from-git** | Re-run `scripts/install-from-git.sh` (or the agent prompt above), then commit |
| **skills.sh** | `npx skills update -y` |
| **skills.sh** (force re-add) | `npx skills add marcuskrogh/skills -y` |
| **Startup sync** | `SKILLS_REF=main bash .agents/sync-skills.sh` |
| **Committed copy** (`install-to-project.ps1`) | Pull/clone this repo on `main`, re-run the install script, commit `.agents/skills/` |

Agent-from-git, startup sync, and `install-to-project` write `.agents/skills/.skills-version` (`repo`, `ref`, `sha`, `synced_at`) so you can see what is installed.

Projects that already committed an older `.agents/sync-skills.sh` should refresh that script from `templates/project-sync/sync-skills.sh` (or re-run `setup-project-sync.ps1`) before relying on `SKILLS_REF` / the version stamp.

Pin a tag or commit with the agent installer or sync script, then return to tracking `main` when ready:

```bash
SKILLS_REF=<tag-or-sha> bash /path/to/install-from-git.sh   # pin
SKILLS_REF=main bash /path/to/install-from-git.sh           # latest main again
# startup sync equivalent:
SKILLS_REF=<tag-or-sha> bash .agents/sync-skills.sh
SKILLS_REF=main bash .agents/sync-skills.sh
```

## Optional: Claude Code plugin

If you use Claude Code and prefer a managed bundle instead of editable copies:

```bash
claude plugin marketplace add marcuskrogh/skills
claude plugin install marcus-skills@marcuskrogh
```

Or inside Claude Code: `/plugin marketplace add marcuskrogh/skills` then `/plugin install marcus-skills@marcuskrogh`.

| Path | Philosophy |
|------|------------|
| **Agent-from-git** | Canonical committed install + prefer-workflow pointers — agents run one script |
| **skills.sh** | Editable copies in your project — fork and adapt (CLI / multi-harness) |
| **Claude plugin** | Read-only bundle that updates when this repo ships |

## Author setup (this repo)

```powershell
.\scripts\setup.ps1
```

Validates skills, mirrors them into common local agent homes (`.agents`, `.claude`, `.codex`, `.copilot`, `.cursor`), and installs git hooks so `git pull` re-syncs.

## Project sync (CI / cloud / VM)

For environments that should pull skills at startup instead of committing them:

```powershell
.\scripts\setup-project-sync.ps1 -ProjectPath C:\path\to\repo
```

Writes `.agents/sync-skills.sh` and gitignores `.agents/skills/`. Each sync checks out `SKILLS_REF` (default `main`), replaces `.agents/skills/`, and records the revision in `.agents/skills/.skills-version`.

If the environment is **Cursor Cloud**, also pass `-WireCursorCloud` to add
`.cursor/environment.json` that runs the same sync on **install** (Build) and
**start** (every boot). `start` matters because Cursor can reuse a snapshotted
Build and skip re-running `install`, which would otherwise leave skills stale
while `marcuskrogh/skills` advances on `main`.

## Architecture

```
skills/                         ← source of truth (Agent Skills layout)
├── concepts/                   ← uninvokable CONCEPT_*.md + disclosed refs
│   ├── CONCEPT_ALIGNMENT.md
│   ├── CONCEPT_CLASSIFICATION.md
│   ├── CLASSIFICATION-CATALOG.md
│   ├── CONCEPT_DELEGATION.md   ← difficulty → low/mid/high; catalogs disclosed
│   ├── PLATFORM-CATALOGS.md
│   ├── platforms/
│   ├── CONCEPT_IMPLEMENTATION.md
│   ├── CONCEPT_ITERATION.md
│   ├── CONCEPT_DEFINITION.md
│   ├── CONCEPT_RESEARCH.md
│   └── CONCEPT_REVIEW.md
├── workflow/                   ← lean delivery contract + disclosed delivery/handoff/tracker/ship refs
├── workflows/                  ← model-invoked router (explore/define front doors)
├── setup/                      ← workspace alignment → WORKSPACE.md
├── explore/                    ← fog-clearing wayfinding → ROADMAP.md
├── define/                     ← front door: align + classify + bind → PLAN.md
├── bug/                        ← manual override → BUG.md
├── tweak/                      ← manual override → TWEAK.md
├── refine/                     ← manual override → REFINE.md
├── rework/                     ← manual override → REWORK.md (comparative eval)
├── research/                   ← multi-axis research brief → RESEARCH.md
├── model/                      ← mathematical alignment → MODEL.md
├── implement/                  ← honors PLAN Workflow binding
├── iterate/                    ← post-ship fix → review-fix
├── review/                     ← adaptive-depth; honors bound review.mode/depth
├── review-fix/                ← one review → fix-forward → CLEAN
├── ship/                       ← remaining-workflow orchestrator → Done
├── summarise/                  ← status: about / stage / Next
├── help/                       ← front-door map (explain only)
├── tracker/                    ← pluggable issue tracker
├── jira/                       ← Jira REST details
├── manage-skills/              ← meta: maintain this repo
└── writing-for-agents/         ← lean shapes + vocabulary

.claude-plugin/                 ← optional Claude Code marketplace manifests
scripts/                        ← validate / sync / install-from-git / project bootstrap
templates/agent-install/        ← consumer AGENTS.md block + Cursor rule
templates/project-sync/         ← startup sync script template
```

### Concepts vs skills

| Kind | Naming | Invokable? | In agent skill list? | When loaded |
|------|--------|------------|----------------------|-------------|
| **Skill** | `skills/<name>/SKILL.md` | Yes (unless `disable-model-invocation`) | Yes (name + description) | On invoke / composition |
| **Concept** | `skills/concepts/CONCEPT_<NAME>.md` | No | No | Only when an invoked skill tells the agent to read it |

Invokable skills **derive from** concepts and further specify them for a purpose (e.g. `define` applies alignment + definition + **classification** for concrete work; `bug` / `tweak` / `refine` / `rework` remain manual overrides with the same class semantics). Concepts own **invariants**; skills fill **extensions** only — see `writing-for-agents`. Pipeline skills are **user-invoked**; the model-invoked **`workflows`** router prefers **explore** / **define** front doors, then progressive-discloses only that skill. **`help`** explains the catalog without starting delivery.

**Sub-agent value routing:** skills that delegate (`implement`, `review`, `review-fix`, and composers like `ship` / `iterate` / `research` axes) apply `CONCEPT_DELEGATION` — score difficulty (Routine → **low**, Moderate → **mid**, Demanding → **high**), keep the manager/orchestrator on high-capability, escalate one tier at a time, and pick **catalog-closed** from ranked platform catalogs via `PLATFORM-CATALOGS.md` (then only the detected harness file under `concepts/platforms/`). On **Cursor**, that file is a closed allowlist of **Composer** + **Grok** only (third-party picker models bill the API budget).

## Pipelines

**Front doors:** `/explore` (fog) and `/define` (concrete work). Define
**classifies** the work (bug / tweak / refine / rework / feature / …) and
**binds** an efficient workflow template + parameters onto `PLAN.md` and the
tracker; later steps follow that chain via **Next**.

```text
setup → explore? → define (classify + bind) → [bound chain, often implement → review-fix → ship]
```

Explore charts a **map** of foggy work into sequenced, dependent route Tasks
(usually define, optionally research/model). Each define Task → **one delivery
branch + one PR** from the first repo-writing skill on that Task through ship.
Continuing via **Next** reuses that branch/PR. **`/ship`** may be invoked after
define (or after a bound implement/review stage) to run any **remaining** steps,
then merge and leave no leftover open PR.

**Manual overrides** (`/bug`, `/tweak`, `/refine`, `/rework`, …) remain
user-invokable when you want to skip define’s classifier; prefer `/define` for
new work.

**Classification + binding** — see `concepts/CONCEPT_CLASSIFICATION.md` and
`concepts/CLASSIFICATION-CATALOG.md` (templates such as fix-fast,
parity-iterative, feature-heavy; params for multiagent implement/review,
comparative verify, review depth).

**Post-ship iterate** (merged work still needs a fix)

```text
ship → iterate → review-fix → ship → (optional) iterate …
```

`/review` remains a one-shot adaptive-depth review; `/review-fix` runs one review → fix-forward →
CLEAN (no re-review; fix-biased: blockers, should-fix, and actionable notes).
`/iterate` opens a **new** branch/PR after ship (not fix-forward on an open PR).
`/summarise` works anytime.

Bare continuation cues (see workflow **Continuation keywords**): **`next`** advances
one persisted Next step; **`ship`** finishes remaining work through Done.

Run `/setup` first — either **globally** (once per machine, `~/.agents/WORKSPACE.md`)
or **per repo** (`docs/agents/WORKSPACE.md`), see [Workspace scopes](#workspace-scopes).
Continuity (keys, status, **Next**, artifact links, **branch/PR**) is mirrored to
markdown when enabled. See `skills/workflow/reference.md` and
`skills/workflow/delivery.md`.

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

Repository fields **override global fields one by one**, so a repo can change just
the tracker and inherit everything else. Set `Extends global: false` in a repo file
to opt out of inheritance entirely.

### Keeping repos clean

Global scope plus `Artifact location: external` runs the whole pipeline without
adding a single file to a consuming repo:

- `WORKSPACE.md` lives in `~/.agents/`
- `PLAN.md` / `ROADMAP.md` / `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `MODEL.md` / `RESEARCH.md` / `ITERATE.md`
  are written under `~/.agents/artifacts/<repo>/` and their **full content is
  pushed into the tracker issue**, which becomes the durable, shareable copy
- Disable the markdown mirror so the remote tracker is the sole source of truth

Only the code change itself lands in the repo, on the Task's delivery branch/PR.

| Skill | Invoke | Purpose |
|-------|--------|---------|
| **setup** | user | Workspace alignment → `WORKSPACE.md` (tracker + paths), repository or global scope |
| **explore** | user | Clear fog on vague/large work → `ROADMAP.md` map + Story + sequenced route Tasks (one delivery unit by default; no hanging charting PRs) |
| **define** | user | **Front door** for concrete work → align, **classify**, **bind workflow** → `PLAN.md` + Sub-tasks + delivery branch/PR |
| **bug** / **tweak** / **refine** / **rework** | user | Manual overrides (class-specific artifacts); prefer `/define` for new work |
| **research** | user | Multi-axis research brief → `RESEARCH.md` (supportive; often via define `side_paths`) |
| **model** | user | Math alignment → `MODEL.md` (math only; often via define `side_paths`) |
| **implement** | user | Build on the **same** delivery branch/PR; honors PLAN Workflow binding (verify mode, multiagent) |
| **iterate** | user | Post-ship fix → `ITERATE.md` + new Task/branch/PR → review-fix |
| **review** | user | Adaptive-depth PR review — honors bound `review.depth` / `review.mode` when present |
| **review-fix** | user | One review → auto fix-forward → CLEAN → ship |
| **ship** | user | Finish remaining work along the bound chain, then merge + Done. Bare **ship** is a continuation keyword |
| **summarise** | user | About / workflow stage / what to run Next |
| **help** | model | Front-door map — explains choices; does not start delivery |

## Other skills

| Skill | Invoke | Purpose |
|-------|--------|---------|
| **workflows** | model | Infer which pipeline fits a work request, then load and run that skill |
| **manage-skills** | user | Maintain and sync this repository |
| **writing-for-agents** | model | Lean shapes + vocabulary when creating/editing skills or concepts |
| **tracker** | composed | Issue tracker contract + backends |
| **jira** | composed | Jira REST details for the jira backend |
| **workflow** | composed | Pipeline continuity + handoffs |

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
