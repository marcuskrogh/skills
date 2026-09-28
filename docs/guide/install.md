# Install in more depth

Install paths, wiring, first use, and author setup. Canonical procedure: [`agent-install.md`](../../skills/manage-skills/agent-install.md). Also [`manage-skills`](../../skills/manage-skills/SKILL.md) and [`setup`](../../skills/setup/SKILL.md).

The [front page](../../README.md) already has the complete install guide. This page adds first-use, workspace, tracker credentials, pinning notes, and author-machine detail.

## Which path to pick

| Situation | Path |
|-----------|------|
| An agent can run commands in the consuming repo | Agent-from-git (`install-from-git.sh`). Preferred. |
| You want the interactive / multi-harness CLI | `npx skills add marcuskrogh/skills` |
| CI, cloud, or VM should fetch on boot | `setup-project-sync.ps1` (optional `-WireCursorCloud`) |
| Claude Code plugin | `claude plugin marketplace add` then `claude plugin install` |
| You author this skills repo on your machine | `.\scripts\setup.ps1` |

Do not invent an alternate copy tree. Agents must not freestyle installs.

## What agent-from-git writes

From agent-install.md (do not reimplement):

| Step | Result |
|------|--------|
| Fetch `SKILLS_REF` (default `main`) from `SKILLS_REPO` | Cache under `/tmp/marcuskrogh-skills` (or use the clone that contains the script) |
| Replace `.agents/skills/` | Every `skills/*/SKILL.md` folder plus `concepts/` |
| Write `.agents/skills/.skills-version` | `repo`, `ref`, `sha`, `synced_at`, `method=install-from-git` |
| Upsert marked block in `AGENTS.md` | `<!-- marcuskrogh/skills:begin -->` … `end` |
| Wire `CLAUDE.md` | Symlink → `AGENTS.md` when absent; else same block |
| Write `.cursor/rules/github-skills.mdc` | Prefer-workflow Cursor rule plus language extract |

When the script file lives inside a marcuskrogh/skills checkout, that checkout is used **only if** its `HEAD` already matches `SKILLS_REF`. Otherwise the installer fetches `SKILLS_REF` into the cache so pins are not silently ignored. For uncommitted or PR-branch testing, set `SKILLS_SOURCE` to that checkout.

## npx aftercare

`npx` does not write the prefer-workflow `AGENTS.md` block or Cursor rule. After an npx-only install, either:

1. Run `install-from-git.sh` (replaces the skill tree and wires pointers), or
2. Copy the marked block from `templates/agent-install/AGENTS.block.md` into `AGENTS.md` manually.

Language rules only apply when that block (or the Cursor rule) is present.

## Pinning

```bash
SKILLS_REF=<tag-or-sha> bash /path/to/install-from-git.sh
SKILLS_REF=<tag-or-sha> bash .agents/sync-skills.sh
SKILLS_REF=main bash /path/to/install-from-git.sh
```

The README uses `v1.2.0` only as syntax. This repository's tags are not listed here. Check GitHub tags or use a full SHA. If a pin fails, `install-from-git.sh` dies with `could not fetch ref`.

If the project already has an older `.agents/sync-skills.sh`, refresh it from this repo first (re-run `setup-project-sync.ps1` or copy `templates/project-sync/sync-skills.sh`), then sync. Older scripts only `git pull` and may not advance cleanly or write a version stamp.

## First use after install

1. Open the consuming project in the harness.
2. Confirm `.agents/skills/workflows/SKILL.md` exists.
3. If neither `docs/agents/WORKSPACE.md` nor `~/.agents/WORKSPACE.md` exists, run `/setup` before delivery work. Pipeline skills stop and ask for setup when neither layer resolves (unless you explicitly say to proceed with defaults, in which case setup still writes a workspace file before creating issues). See [`setup/format.md`](../../skills/setup/format.md).
4. Describe work, or `/help` for the map.

### Workspace scopes

`/setup` writes a `WORKSPACE.md` at one of two scopes:

| Scope | Path | Committed? | Applies to |
|-------|------|-----------|------------|
| repository | `docs/agents/WORKSPACE.md` | Yes | That repo and its collaborators |
| global | `~/.agents/WORKSPACE.md` | Never | Every repo on this machine |

Resolution order is in [`setup/format.md`](../../skills/setup/format.md). Repository fields override global fields one by one. Language is not a workspace field. A repo install writes the language extract into `AGENTS.md`, `CLAUDE.md`, and `.cursor/rules/github-skills.mdc`.

Global scope plus `Artifact location: external` runs the pipeline without adding agent files to a consuming repo. Artifact full content is pushed into the tracker issue. Only the code change lands in the repo, on the Task's delivery branch/PR.

### Tracker credentials

`/setup` writes provider fields into `WORKSPACE.md`. Two source files list credentials. They do not use the same names.

README table:

| Provider | Needs |
|----------|-------|
| markdown | None (issues under `docs/agents/issues/`) |
| jira | `JIRA_BASE_URL`, `JIRA_EMAIL`, `JIRA_API_TOKEN`, project key |
| github | Authenticated `gh` CLI |
| linear | Linear MCP or `LINEAR_API_KEY` + team key |

[`setup/format.md`](../../skills/setup/format.md) workspace fields:

| Provider | Fields |
|----------|--------|
| markdown | Issues dir, Key prefix, Index |
| jira | Site, Project key, Auth: env (`JIRA_EMAIL` + `JIRA_API_TOKEN`), optional Override file `docs/agents/jira.md` |
| github | Repo (`owner/name`, default current `gh` repo), Labels |
| linear | Team key, API (Linear MCP or `LINEAR_API_KEY`), optional Project |

This page does not invent a mapping from README's `JIRA_BASE_URL` to format.md's Site. Use format.md when filling `WORKSPACE.md`. Use the README table as the published credential list. If setup asks for Site, that is the workspace field.

`review` and `ship` also need an authenticated `gh` CLI for pull requests.

## Author machine (this repository)

```powershell
cd D:\code\skills
.\scripts\setup.ps1
```

The path `D:\code\skills` is the example in manage-skills. Use your clone path.

What `setup.ps1` does:

1. `validate-skills.ps1`
2. `sync-local.ps1 -Prune` (optional `-Link`)
3. `git config core.hooksPath .githooks`

After every skill change:

```powershell
.\scripts\validate-skills.ps1
.\scripts\sync-local.ps1 -Prune
```

`-Prune` removes skill folders from local mirrors that no longer exist in the repo. It always keeps `concepts/`.

Creating a new skill or concept: checklist in [`manage-skills`](../../skills/manage-skills/SKILL.md). Writing rules: [`writing-for-agents`](../../skills/writing-for-agents/SKILL.md).

## Copied install (`install-to-project.ps1`)

Copies skills into a project's `.agents/skills`. Prefer agent-from-git when an agent can install. To update a copied install: re-run the script from an up-to-date clone of this repo, then commit `.agents/skills/`.

## Project sync on Cursor Cloud

```powershell
.\scripts\setup-project-sync.ps1 -ProjectPath C:\path\to\repo -WireCursorCloud
```

`-WireCursorCloud` writes `.cursor/environment.json` so **install** and **start** both run `.agents/sync-skills.sh`. Install alone can be snapshotted stale. Default `SKILLS_REF` is `main`.

## Related pages

- [Front page install](../../README.md#install)
- [Structure](structure.md)
- [Examples](examples.md#install-into-a-consuming-repo)
