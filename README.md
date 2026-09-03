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
[`workflows`](skills/workflows/SKILL.md) router picks a catalog path and loads
only that skill. Pipeline skills stay user-invoked. Navigation map:
[`/help`](skills/help/SKILL.md). Teach the current step: [`/explain`](skills/explain/SKILL.md).
Walk through a task: [`/guide`](skills/guide/SKILL.md).

| If you… | Run | What happens |
|---------|-----|----------------|
| Have no usable workspace yet | `/setup` | `WORKSPACE.md` (tracker + paths) |
| Feel a big or foggy goal but not the steps | `/explore` | `ROADMAP.md` + route Tasks |
| Have concrete work (bug, tweak, refine, rework, feature, …) | `/define` | Align, classify, bind, write `PLAN.md` + **Next** |
| Want the structure catalog on a brownfield codebase | `/adopt` | Characterize into tests, then walk the unit chain per area until Done |

Without an explicit override: **foggy → explore**, **concrete → define**.
Whole-tree brownfield structure matches **adopt** before define. Catalog order
and later stages live in [`workflows/SKILL.md`](skills/workflows/SKILL.md).
Continuity (one Task, one branch/PR, **next** vs **ship**) lives in
[`workflow/reference.md`](skills/workflow/reference.md).

| Cue | Meaning |
|-----|---------|
| **next** / continue | Advance **one** persisted Next step |
| **ship** / finish / close it out | Finish **remaining** work through Done |

Explicit `/skill` names win. `/bug`, `/tweak`, `/refine`, `/rework` are manual
overrides of define's classifier.

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
├── workflow/                   ← lean delivery contract + disclosed refs
├── workflows/                  ← model-invoked router
├── setup/ explore/ define/     ← front doors
├── bug/ tweak/ refine/ rework/ ← manual class overrides
├── adopt/ research/ model/ sandbox/
├── architect/ implement/ test/ restructure/ review/ review-fix/
├── iterate/ ship/ summarise/ help/ explain/ guide/
├── tracker/ jira/
├── manage-skills/              ← maintain this repo
└── writing-for-agents/         ← lean shapes + vocabulary

.claude-plugin/                 ← optional Claude Code marketplace manifests
scripts/                        ← validate / sync / install-from-git / project bootstrap
templates/agent-install/        ← consumer AGENTS.md block + Cursor rule
templates/project-sync/         ← startup sync script template
```

Pipeline skill purposes: [`/help`](skills/help/SKILL.md).

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

## Tracker credentials

Configured by `/setup` in `docs/agents/WORKSPACE.md`.

| Provider | Needs |
|----------|-------|
| **markdown** | None (issues under `docs/agents/issues/`) |
| **jira** | `JIRA_BASE_URL`, `JIRA_EMAIL`, `JIRA_API_TOKEN`, project key |
| **github** | Authenticated `gh` CLI |
| **linear** | Linear MCP or `LINEAR_API_KEY` + team key |

`review` and `ship` also need an authenticated `gh` CLI for PRs.
