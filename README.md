# Agent Skills

Reusable agent skills for workspace setup, alignment, definition, modelling, implementation, review, and ship.

Built on the [Agent Skills](https://agentskills.io) standard. Install once via [skills.sh](https://skills.sh); works with any compatible harness (Cursor, Claude Code, Codex, GitHub Copilot, and others).

[![skills.sh](https://skills.sh/b/marcuskrogh/skills)](https://skills.sh/marcuskrogh/skills)

## Quickstart

```bash
npx skills add marcuskrogh/skills
```

Pick the skills you want and which agents to install them for. Skills land in each agent's standard skill directory (project or global). Relative links between skills stay intact because they install as siblings under `.agents/skills/` (or the equivalent home for that agent). Concepts install alongside as `concepts/` (not invokable).

## Updating skills (existing install → latest main)

If a project already has skills installed and you want the newest `main`:

| Install style | Command |
|---------------|---------|
| **skills.sh** | `npx skills update -y` |
| **skills.sh** (force re-add) | `npx skills add marcuskrogh/skills -y` |
| **Startup sync** | `SKILLS_REF=main bash .agents/sync-skills.sh` |
| **Committed copy** (`install-to-project.ps1`) | Pull/clone this repo on `main`, re-run the install script, commit `.agents/skills/` |

Startup sync and `install-to-project` write `.agents/skills/.skills-version` (`repo`, `ref`, `sha`, `synced_at`) so you can see what is installed.

Projects that already committed an older `.agents/sync-skills.sh` should refresh that script from `templates/project-sync/sync-skills.sh` (or re-run `setup-project-sync.ps1`) before relying on `SKILLS_REF` / the version stamp.

Pin a tag or commit with the sync script, then return to tracking `main` when ready:

```bash
SKILLS_REF=<tag-or-sha> bash .agents/sync-skills.sh   # pin
SKILLS_REF=main bash .agents/sync-skills.sh           # latest main again
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
| **skills.sh** | Editable copies in your project — fork and adapt |
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

If the environment is **Cursor Cloud**, also pass `-WireCursorCloud` to add `.cursor/environment.json` that runs the same sync.

## Architecture

```
skills/                         ← source of truth (Agent Skills layout)
├── concepts/                   ← uninvokable CONCEPT_*.md (loaded only when a skill references them)
│   ├── CONCEPT_ALIGNMENT.md
│   ├── CONCEPT_DELEGATION.md   ← difficulty → ranked low-/high-capability catalogs (platform-dependent; manager stays high-capability)
│   ├── CONCEPT_IMPLEMENTATION.md
│   ├── CONCEPT_ITERATION.md
│   ├── CONCEPT_DEFINITION.md
│   ├── CONCEPT_RESEARCH.md
│   └── CONCEPT_REVIEW.md
├── setup/                      ← workspace alignment → docs/agents/WORKSPACE.md
├── explore/                    ← fog-clearing wayfinding → ROADMAP.md map + sequenced route Tasks
├── bug/                        ← defect alignment → BUG.md (skips explore/define)
├── research/                   ← multi-axis research brief → RESEARCH.md
├── model/                      ← mathematical alignment → MODEL.md
├── define/                     ← topic definition → PLAN.md (enriches pipeline Task)
├── implement/                  ← managed implementation from a pipeline Task (tests + testability first-class)
├── iterate/                    ← post-ship fix: brief align + new branch/PR → review-fix
├── review/                     ← multi-axis Spec/Correctness/Integration/Architecture/Standards
├── review-fix/                ← review ↔ fix-forward until clean
├── ship/                       ← remaining-workflow orchestrator → closed-loop merge + Done
├── summarise/                  ← status: about / stage / Next
├── tracker/                    ← pluggable issue tracker (markdown/jira/github/linear)
├── jira/                       ← Jira REST details (tracker backend)
├── workflow/                   ← pipeline contract (composed)
└── manage-skills/              ← meta: maintain this repo

.claude-plugin/                 ← optional Claude Code marketplace manifests
scripts/                        ← validate / sync / project bootstrap (incl. arxiv_research.py)
templates/project-sync/         ← startup sync script template
```

### Concepts vs skills

| Kind | Naming | Invokable? | In agent skill list? | When loaded |
|------|--------|------------|----------------------|-------------|
| **Skill** | `skills/<name>/SKILL.md` | Yes (unless `disable-model-invocation`) | Yes (name + description) | On invoke / composition |
| **Concept** | `skills/concepts/CONCEPT_<NAME>.md` | No | No | Only when an invoked skill tells the agent to read it |

Invokable skills **derive from** concepts and further specify them for a purpose (e.g. `define` applies alignment + definition for a pipeline Task; `bug` applies the same concepts lightly for defects).

**Sub-agent value routing:** skills that delegate (`implement`, `review`, `review-fix`, and composers like `ship` / `iterate` / `research` axes) apply `CONCEPT_DELEGATION` — score difficulty, default workers to the platform’s **low-capability** (value) tier, elevate to **high-capability** only when Demanding, keep the manager/orchestrator on high-capability, and pick from ranked platform catalogs (with a General fallback).

## Pipelines

**Feature**

```text
setup → explore → (research / model / define route…) → implement → review-fix → ship
```

Explore charts a **map** of foggy work into sequenced, dependent route Tasks
(research, model, define, …). Each define Task → **one delivery branch + one PR**
from the first repo-writing skill on that Task through ship. Continuing via
**Next** reuses that branch/PR. **`/ship`** may be invoked after define (or after
bug / iterate ready-to-build) to run any **remaining** steps (`implement` →
`review-fix` → closeout as needed), then merge and leave no leftover open PR.

**Bug fix** (`/bug` replaces explore + define)

```text
setup → bug → implement → review-fix → ship
```

Same closed-loop delivery (bug starts the branch/PR when writing `BUG.md`).

**Post-ship iterate** (merged work still needs a fix)

```text
ship → iterate → review-fix → ship → (optional) iterate …
```

`/review` remains a one-shot review; `/review-fix` loops review ↔ fix until clean
(fix-biased: blockers, should-fix, and actionable notes). `/iterate` opens a **new**
branch/PR after ship (not fix-forward on an open PR). `/summarise` works anytime.

Bare continuation cues (see workflow **Continuation keywords**): **`next`** advances
one persisted Next step; **`ship`** finishes remaining work through Done.

Run `/setup` first in each consuming repo. Continuity (keys, status, **Next**, artifact links, **branch/PR**) is mirrored to markdown when enabled. See `skills/workflow/reference.md` (especially **Delivery branch continuity**).

| Skill | Invoke | Purpose |
|-------|--------|---------|
| **setup** | user | Workspace alignment → `WORKSPACE.md` (tracker + paths) |
| **explore** | user | Clear fog on vague/large work → `ROADMAP.md` map + Story + sequenced route Tasks (research / model / define / …) |
| **bug** | user | Defect alignment → `BUG.md` + Task + delivery branch/PR (then implement) |
| **research** | user | Multi-axis research brief → `RESEARCH.md` (arXiv + formal + web + informal; supportive, not user alignment) |
| **model** | user | Math alignment → `MODEL.md` (math only; does not replace define) |
| **define** | user | User-agent topic definition → `PLAN.md` + Sub-tasks + delivery branch/PR (owns particulars; always questions the user) |
| **implement** | user | Build on the **same** delivery branch/PR; tests and testability required; low-capability-biased work-package routing |
| **iterate** | user | Post-ship fix → `ITERATE.md` + new Task/branch/PR → review-fix |
| **review** | user | Thorough multi-axis PR review (Spec, Correctness, Integration, Architecture, Standards) — fix-biased severity; low-capability-biased axis workers |
| **review-fix** | user | Review ↔ auto fix-forward (blockers, should-fix, actionable notes) until clean → ship; same value routing inside the loop |
| **ship** | user | Finish remaining work after define/bug/iterate-ready (implement and/or review-fix as needed), then closed-loop merge + Done. Bare **ship** is a continuation keyword (like **next**). |
| **summarise** | user | About / workflow stage / what to run Next |

## Other skills

| Skill | Invoke | Purpose |
|-------|--------|---------|
| **manage-skills** | user | Maintain and sync this repository |
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
| `setup.ps1` | Author setup — validate, sync local homes, git hooks |
| `sync-local.ps1` / `sync-local.sh` | Mirror `skills/` into local agent homes |
| `install-to-project.ps1` | Copy skills into a project's `.agents/skills` |
| `validate-skills.ps1` | Frontmatter, naming, plugin.json coverage, concepts |
| `setup-project-sync.ps1` | Wire startup sync into a project (optional `-WireCursorCloud`) |
| `templates/project-sync/sync-skills.sh` | Startup sync: fetch `SKILLS_REF` (default `main`) → `.agents/skills/` + `.skills-version` |
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
