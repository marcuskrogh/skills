# Structure

How this repository is laid out, what each part contains, and what is not a skill. Source: `README.md` Architecture tree, [`manage-skills`](../../skills/manage-skills/SKILL.md), and the files on `main`.

Return to the [front page](../../README.md).

## Top level

```text
skills/                         source of truth (Agent Skills layout)
├── concepts/                   uninvokable CONCEPT_*.md + disclosed refs
├── workflow/                   delivery contract (composed; not an entry point)
├── workflows/                  model-invoked router
├── help/                       model-invoked map (does not start work)
├── explain/  guide/            teach the current step; walk a manual task
├── setup/  explore/  define/   front doors
├── bug/ tweak/ refine/ rework/ manual class overrides
├── adopt/ research/ model/ sandbox/
├── architect/ implement/ test/
├── restructure/ harden/        harden aliases restructure
├── review/ review-fix/         review-fix aliases review
├── iterate/ ship/ summarise/
├── tracker/ jira/              composed tracker (not entry points)
├── manage-skills/              install, sync, and repo maintenance
└── writing-for-agents/         model-invoked authoring guide

.claude-plugin/                 optional Claude Code marketplace manifests
scripts/                        validate, sync, install-from-git, arXiv helper
templates/agent-install/        consumer AGENTS.md block + Cursor rule
templates/project-sync/         startup sync script template
docs/agents/                    pipeline workspace and Task files for this repo
docs/guide/                     this operator-facing guide
```

License: MIT (`LICENSE`). Copyright (c) 2026 Marcus Krogh Nielsen, Ph.D.

## `skills/`

This is the git source of truth. Edit here. Do not edit the copies under `~/.agents/skills/` or a project's `.agents/skills/` except by running the documented sync or install.

Each invokable skill is a folder with `SKILL.md`. The frontmatter `name` must match the folder name. Shared composed skills (`jira`, `tracker`, `workflow`) stay siblings of the skills that link to them so relative links survive install.

`skills/concepts/` is uninvokable. Sync scripts always copy it next to the skill folders as `concepts/`. Do not nest shared material under a category folder that skills.sh would flatten away, except this `concepts/` bundle.

The installed list of skills in the Claude plugin is `.claude-plugin/plugin.json` → `skills`. Concepts are not listed there.

## `skills/concepts/`

Concepts own shared invariants. Skills fill extensions only. See [Concepts](concepts.md) and [`writing-for-agents`](../../skills/writing-for-agents/SKILL.md).

Disclosed catalogs live beside the concepts: `CLASSIFICATION-CATALOG.md`, `STRUCTURE-CATALOG.md`, `PLATFORM-CATALOGS.md`, `LANGUAGE-PHRASES.md`, `LANGUAGE-HUMANIZER.md`, and `platforms/*.md`.

## Always-on pointers (this repo)

A repo install of these skills writes prefer-workflow plus language extracts into:

| File | Role |
|------|------|
| `AGENTS.md` | Agent instructions (prefer workflow, language, Cursor models) |
| `CLAUDE.md` | Same content for Claude Code |
| `.cursor/rules/github-skills.mdc` | Always-on Cursor rule |

Those files tell the harness to load [`workflows`](../../skills/workflows/SKILL.md) when the operator describes work to deliver.

## `scripts/`

| Script | Purpose (from README and script headers) |
|--------|------------------------------------------|
| `install-from-git.sh` | Canonical consuming-project install from git |
| `setup.ps1` | Author setup: validate, sync local homes, git hooks |
| `sync-local.ps1` / `sync-local.sh` | Mirror `skills/` into local agent homes |
| `install-to-project.ps1` | Copy skills into a project's `.agents/skills` |
| `validate-skills.ps1` | Frontmatter, naming, plugin.json coverage, concepts |
| `setup-project-sync.ps1` | Wire `.agents/sync-skills.sh` (optional `-WireCursorCloud`) |
| `setup-github.ps1` | First-time push to GitHub |
| `arxiv_research.py` | arXiv search, lookup, and snowball for `/research` |
| `test_pipelines.py` | Pipeline transition checks used in this repo |

## `templates/`

| Path | Purpose |
|------|---------|
| `templates/agent-install/AGENTS.block.md` | Marked prefer-workflow block inserted into consuming `AGENTS.md` |
| `templates/agent-install/AGENTS.md` | Same block as a standalone file |
| `templates/agent-install/github-skills.mdc` | Cursor rule copied to `.cursor/rules/github-skills.mdc` |
| `templates/agent-install/global-CLAUDE.block.md` | Global Claude language extract (written by local sync) |
| `templates/agent-install/global-cursor-language.mdc` | Global Cursor language extract |
| `templates/project-sync/sync-skills.sh` | Startup sync into `.agents/skills/` plus `.skills-version` |

## `.claude-plugin/`

Optional Claude Code marketplace manifests. Plugin name is `marcus-skills`. Marketplace name is `marcuskrogh`. This is not required for Cursor or for `install-from-git.sh`.

## `.githooks/`

`post-merge` and `post-checkout`. Author `setup.ps1` sets `core.hooksPath` to `.githooks` so `git pull` re-syncs local skill mirrors.

## `docs/`

| Path | Audience | Role |
|------|----------|------|
| `docs/agents/WORKSPACE.md` | Agents on this repo | Tracker, artifact paths, delivery defaults |
| `docs/agents/PLAN.md` (and siblings) | Agents on an in-flight Task | Pipeline artifacts. Deleted at ship |
| `docs/agents/issues/` | Agents | Markdown tracker when provider is `markdown` |
| `docs/guide/` | Operators | This wiki-style guide |

`docs/agents/` is not a product surface. Do not treat those files as the public description of the skills set.

## Where installed copies live

From [`manage-skills`](../../skills/manage-skills/SKILL.md):

| Location | Role |
|----------|------|
| `skills/` in this repo | Edit here |
| `~/.agents/skills/` | Shared global mirror (sync only) |
| `~/.claude/skills/`, `~/.codex/skills/`, `~/.copilot/skills/`, `~/.cursor/skills/` | Per-harness global mirrors (sync only) |
| `~/.claude/CLAUDE.md`, `~/.cursor/rules/marcuskrogh-skills.mdc` | Global language extract (written by `sync-local`) |
| Project `.agents/skills/` | Per-project install (agent-from-git and skills.sh default) |
| `.claude-plugin/` | Optional Claude Code marketplace manifests |

## What is not in this tree as a skill

These folders on `main` are **not** listed as skills in `.claude-plugin/plugin.json`. Do not treat them as invokable entries:

- `skills/concepts/` (concepts, not skills)
- Any skill that exists only on another branch or pull request. This guide describes `main` only.

`harden` and `review-fix` **are** listed. They are aliases that run `restructure` and `review`.

## Related pages

- [How it works](how-it-works.md)
- [Skills](skills.md)
- [Install in more depth](install.md)
