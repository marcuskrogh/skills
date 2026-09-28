# Agent Skills

Reusable agent skills for workflow-driven delivery. Agents prefer a catalog workflow over freestyle coding. Foggy work goes through **explore**. Concrete work goes through **define** (interview, then classify and bind). A short description starts that interview and does not approve the plan.

Each skill applies concepts and produces an output on its own. The bound workflow writes persisted **Next**. A reply that finishes a skill ends with the `## Next` block. An open interview question does not include that block.

Built on the [Agent Skills](https://agentskills.io) standard. Install via an agent (preferred) or [skills.sh](https://skills.sh). Works with Cursor, Claude Code, Codex, GitHub Copilot, and other compatible editors.

[![skills.sh](https://skills.sh/b/marcuskrogh/skills)](https://skills.sh/marcuskrogh/skills)

## What this repository is

This repository is the source of truth for a set of skills that tell an agent how to take work from a vague idea or a concrete request through definition, architecture, implementation, tests, structure, review, and merge.

Installing it does not start a server. It copies skill files, concepts, and prefer-workflow pointers into a project or into local agent homes so the next chat in that harness follows the catalog.

## Intention

Keep delivery deterministic. The operator describes work. The agent picks the first matching catalog row, interviews when the work is concrete, records a class and a template, and then follows that chain. Skills do not name the skill that follows. The workflow writes **Next**.

## How it is used

1. Install the skills into a consuming project (or this repo, if you author them).
2. Tell the agent what you want delivered, or name a skill (`/define`, `/help`, …).
3. Answer interview questions until you approve the plan.
4. Follow **Next**, or say **next** / **ship**.

`/help` maps choices and does not start work. `/guide` walks a manual task one step at a time. `/explain` teaches the current step.

## What it does

After install, an unnamed delivery request is recognised by [`workflows`](skills/workflows/SKILL.md). Explicit `/skill` names win over re-routing. Typical results are markdown artifacts (`PLAN.md`, `ARCHITECTURE.md`, …), one tracker Task, and one delivery branch and pull request through ship.

## Guide

The front page is an overview and an install guide. The pages below are the rest of the description.

| Page | What it covers |
|------|----------------|
| [Structure](docs/guide/structure.md) | Tree, directories, scripts, templates, and what is not a skill |
| [How it works](docs/guide/how-it-works.md) | Skills vs concepts, routing, classification, Next, tracker, language |
| [Workflows](docs/guide/workflows.md) | Which workflow runs in which situation, templates, and chains |
| [Skills](docs/guide/skills.md) | Each skill: how to use it, where, outputs, and which workflows invoke it |
| [Concepts](docs/guide/concepts.md) | Shared invariants and disclosed catalogs |
| [Examples](docs/guide/examples.md) | Applied situations taken from the catalog |
| [Install in more depth](docs/guide/install.md) | Pinning, updates, author setup, project sync, first use |

Short map only: [`/help`](skills/help/SKILL.md).

## Install

Do not freestyle a different install layout. Agents follow [`agent-install.md`](skills/manage-skills/agent-install.md).

### Ask an agent (preferred)

Paste this prompt in the consuming repository:

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

Or run the script yourself from the consuming project root:

```bash
curl -fsSL https://raw.githubusercontent.com/marcuskrogh/skills/main/scripts/install-from-git.sh | bash
```

If `curl | bash` is unavailable:

```bash
git clone --depth 1 https://github.com/marcuskrogh/skills.git /tmp/marcuskrogh-skills
bash /tmp/marcuskrogh-skills/scripts/install-from-git.sh
```

The script replaces `.agents/skills/` (all skills plus `concepts/`), stamps `.skills-version`, and wires prefer-workflow pointers in `AGENTS.md`, `CLAUDE.md`, and `.cursor/rules/github-skills.mdc`.

Commit those paths in the consuming repo:

```text
.agents/skills/
AGENTS.md
CLAUDE.md
.cursor/rules/github-skills.mdc
```

Confirm:

```bash
test -f .agents/skills/.skills-version
test -f .agents/skills/workflows/SKILL.md
test -d .agents/skills/concepts
grep -q 'marcuskrogh/skills:begin' AGENTS.md
```

Optional environment variables (from [`agent-install.md`](skills/manage-skills/agent-install.md)):

| Variable | Default | Purpose |
|----------|---------|---------|
| `PROJECT_ROOT` | cwd | Consuming repo root |
| `SKILLS_REF` | `main` | Branch, tag, or commit |
| `SKILLS_REPO` | `https://github.com/marcuskrogh/skills.git` | Source remote |
| `SKILLS_CACHE` | `/tmp/marcuskrogh-skills` | Clone cache |
| `SKIP_POINTERS` | unset | Set `1` to skip `AGENTS.md` / Cursor wiring |
| `SKILLS_SOURCE` | unset | Use an existing checkout as-is (ignores `SKILLS_REF`; for local testing) |

Pin a version:

```bash
SKILLS_REF=v1.2.0 bash /path/to/install-from-git.sh
SKILLS_REF=<full-sha> bash /path/to/install-from-git.sh
SKILLS_REF=main bash /path/to/install-from-git.sh
```

The tag `v1.2.0` is an example of the pin syntax. Use a tag or SHA that exists on this repository. This page does not claim a specific release exists.

### Or use skills.sh (`npx`)

```bash
npx skills add marcuskrogh/skills
```

Non-interactive (CI, or an agent that was asked for npx):

```bash
npx skills add marcuskrogh/skills --all -y
```

`npx` does not write the prefer-workflow `AGENTS.md` block. Use the agent installer when you want that wiring. After an npx-only install, either run `install-from-git.sh` or copy the marked block from `templates/agent-install/AGENTS.block.md` into `AGENTS.md` manually. Language rules only apply when that block (or the Cursor rule) is present.

### Optional: Claude Code plugin

```bash
claude plugin marketplace add marcuskrogh/skills
claude plugin install marcus-skills@marcuskrogh
```

### Updating skills

How to advance an existing install: [`manage-skills`](skills/manage-skills/SKILL.md) (Updating an existing install).

| How skills were installed | Update to latest `main` |
|---------------------------|-------------------------|
| Agent-from-git (`install-from-git.sh`) | Re-run the same script (or the agent prompt), then commit |
| skills.sh (project or global) | `npx skills update -y`, or `npx skills add marcuskrogh/skills -y` |
| Startup sync (`.agents/sync-skills.sh`) | `SKILLS_REF=main bash .agents/sync-skills.sh` |
| Copied via `install-to-project.ps1` | Re-run that script from an up-to-date clone, then commit `.agents/skills/` |
| Claude plugin | Update or reinstall the plugin after we ship on `main` |

After agent-from-git, startup sync, or `install-to-project`, check `.agents/skills/.skills-version` for `repo`, `ref`, and `sha`.

### Author setup (this repo)

For people who edit this repository, not for consuming-project install:

```powershell
.\scripts\setup.ps1
```

Validates skills, mirrors them into local agent homes, and installs git hooks so `git pull` re-syncs.

### Project sync (CI / cloud / VM)

```powershell
.\scripts\setup-project-sync.ps1 -ProjectPath C:\path\to\repo
```

Writes `.agents/sync-skills.sh` and gitignores `.agents/skills/`. For Cursor Cloud, also pass `-WireCursorCloud` so **install** and **start** both sync.

### After install, start using it

In a consuming repo that has the pointers wired:

1. Open the project in Cursor, Claude Code, Codex, Copilot, or another compatible harness.
2. If this is a new repo with no `WORKSPACE.md`, ask the agent to run `/setup` before delivery work.
3. Describe the work, or say `/help` if you only want the map.
4. Foggy destination: expect **explore**. Concrete bug, tweak, refine, rework, or feature: expect **define**.

Workspace scopes and tracker credentials: [Install in more depth](docs/guide/install.md).

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
| `test_pipelines.py` | Pipeline transition checks used in this repo |

## Workflow for skill changes

1. Edit `skills/<name>/` or `skills/concepts/` in this repo.
2. `.\scripts\validate-skills.ps1`
3. `.\scripts\sync-local.ps1 -Prune`
4. `git commit` / `git push`

Use `/manage-skills` for the full checklist.
