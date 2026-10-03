# Install

The rest of install. The [front page](../../README.md#install) has the preferred prompt, the `curl` command, the four paths to commit, and the two confirm checks. This page has pinning, other install paths, updates, first use, and author setup.

Canonical procedure: [`agent-install.md`](../../skills/manage-skills/agent-install.md). Also [`manage-skills`](../../skills/manage-skills/SKILL.md) and [`setup`](../../skills/setup/SKILL.md).

## Which path to pick

| Situation | Path |
|-----------|------|
| An agent can run commands in the consuming repo | Agent-from-git (`install-from-git.sh`). Preferred. |
| You want the interactive / multi-harness CLI | `npx skills add marcuskrogh/skills` |
| CI, cloud, or VM should fetch on boot | `setup-project-sync.ps1` (optional `-WireCursorCloud`) |
| Claude Code plugin | `claude plugin marketplace add` then `claude plugin install` |
| You author this skills repo on your machine | `.\scripts\setup.ps1` |

Do not invent an alternate copy tree. Agents follow [`agent-install.md`](../../skills/manage-skills/agent-install.md).

## Agent-from-git

Paste this in the consuming repository:

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

From [`agent-install.md`](../../skills/manage-skills/agent-install.md):

| Step | Result |
|------|--------|
| Fetch `SKILLS_REF` (default `main`) from `SKILLS_REPO` | Cache under `/tmp/marcuskrogh-skills` (or use the clone that contains the script) |
| Replace `.agents/skills/` | Every `skills/*/SKILL.md` folder plus `concepts/` |
| Write `.agents/skills/.skills-version` | `repo`, `ref`, `sha`, `synced_at`, `method=install-from-git` |
| Upsert marked block in `AGENTS.md` | `<!-- marcuskrogh/skills:begin -->` … `end` |
| Wire `CLAUDE.md` | Symlink to `AGENTS.md` when absent; else the same block |
| Write `.cursor/rules/github-skills.mdc` | Prefer-workflow Cursor rule plus language extract |

When the script file lives inside a marcuskrogh/skills checkout, that checkout is used only if its `HEAD` already matches `SKILLS_REF`. Otherwise the installer fetches `SKILLS_REF` into the cache so pins are not silently ignored. For uncommitted or pull-request-branch testing, set `SKILLS_SOURCE` to that checkout.

Commit these paths in the consuming repo:

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

### Environment variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `PROJECT_ROOT` | cwd | Consuming repo root |
| `SKILLS_REF` | `main` | Branch, tag, or commit |
| `SKILLS_REPO` | `https://github.com/marcuskrogh/skills.git` | Source remote |
| `SKILLS_CACHE` | `/tmp/marcuskrogh-skills` | Clone cache |
| `SKIP_POINTERS` | unset | Set `1` to skip `AGENTS.md` / Cursor wiring |
| `SKILLS_SOURCE` | unset | Use an existing checkout as-is (ignores `SKILLS_REF`; for local testing) |

## Pinning

```bash
SKILLS_REF=<tag-or-sha> bash /path/to/install-from-git.sh
SKILLS_REF=<tag-or-sha> bash .agents/sync-skills.sh
SKILLS_REF=main bash /path/to/install-from-git.sh
```

`v1.2.0` is only an example of the pin syntax:

```bash
SKILLS_REF=v1.2.0 bash /path/to/install-from-git.sh
SKILLS_REF=<full-sha> bash /path/to/install-from-git.sh
```

Use a tag or SHA that exists on this repository. This page does not claim a specific release exists. Check GitHub tags or use a full SHA. If a pin fails, `install-from-git.sh` dies with `could not fetch ref`.

If the project already has an older `.agents/sync-skills.sh`, refresh it from this repo first (re-run `setup-project-sync.ps1` or copy `templates/project-sync/sync-skills.sh`), then sync. Older scripts only `git pull` and may not advance cleanly or write a version stamp.

## skills.sh (`npx`)

```bash
npx skills add marcuskrogh/skills
```

Non-interactive (CI, or an agent that was asked for npx):

```bash
npx skills add marcuskrogh/skills --all -y
```

`npx` does not write the prefer-workflow `AGENTS.md` block or the Cursor rule. After an npx-only install, either run `install-from-git.sh` (replaces the skill tree and wires pointers), or copy the marked block from `templates/agent-install/AGENTS.block.md` into `AGENTS.md` manually. Language rules apply when that block or the Cursor rule is present.

## Claude Code plugin

```bash
claude plugin marketplace add marcuskrogh/skills
claude plugin install marcus-skills@marcuskrogh
```

## Updating an existing install

How to advance an existing install: [`manage-skills`](../../skills/manage-skills/SKILL.md) (Updating an existing install).

| How skills were installed | Update to latest `main` |
|---------------------------|-------------------------|
| Agent-from-git (`install-from-git.sh`) | Re-run the same script (or the agent prompt), then commit |
| skills.sh (project or global) | `npx skills update -y`, or `npx skills add marcuskrogh/skills -y` |
| Startup sync (`.agents/sync-skills.sh`) | `SKILLS_REF=main bash .agents/sync-skills.sh` |
| Copied via `install-to-project.ps1` | Re-run that script from an up-to-date clone, then commit `.agents/skills/` |
| Claude plugin | Update or reinstall the plugin after we ship on `main` |

After agent-from-git, startup sync, or `install-to-project`, check `.agents/skills/.skills-version` for `repo`, `ref`, and `sha`.

## First use after install

1. Open the consuming project in Cursor, Claude Code, Codex, Copilot, or another compatible harness.
2. Confirm `.agents/skills/workflows/SKILL.md` exists.
3. If neither `docs/agents/WORKSPACE.md` nor `~/.agents/WORKSPACE.md` exists, run `/setup` before delivery work. Pipeline skills stop and ask for setup when neither layer resolves (unless you explicitly say to proceed with defaults, in which case setup still writes a workspace file before creating issues). See [`setup/format.md`](../../skills/setup/format.md).
4. Describe the work, or say `/help` if you only want the map.
5. An unclear destination matches explore. Concrete work (a bug, a tweak, a refine, a rework, or a feature) matches define.

### Workspace scopes

`/setup` writes a `WORKSPACE.md` at one of two scopes:

| Scope | Path | Committed? | Applies to |
|-------|------|-----------|------------|
| repository | `docs/agents/WORKSPACE.md` | Yes | That repo and its collaborators |
| global | `~/.agents/WORKSPACE.md` | Never | Every repo on this machine |

Resolution order is in [`setup/format.md`](../../skills/setup/format.md). Repository fields override global fields one by one. Language is not a workspace field. A repo install writes the language extract into `AGENTS.md`, `CLAUDE.md`, and `.cursor/rules/github-skills.mdc`.

Global scope plus `Artifact location: external` runs the pipeline without adding agent files to a consuming repo. Artifact full content is pushed into the tracker issue. Only the code change lands in the repo, on the task's delivery branch and pull request.

### Tracker credentials

`/setup` writes provider fields into `WORKSPACE.md`. Two source files list credentials. They do not use the same names.

Published credential list:

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

This page does not invent a mapping from `JIRA_BASE_URL` to format.md's Site. Use format.md when filling `WORKSPACE.md`. Use the published credential list above for what each provider needs. If setup asks for Site, that is the workspace field.

`review` and `ship` also need an authenticated `gh` CLI for pull requests.

## Author machine (this repository)

For people who edit this repository, not for consuming-project install:

```powershell
.\scripts\setup.ps1
```

The path in manage-skills is an example. Use your clone path:

```powershell
cd D:\code\skills
.\scripts\setup.ps1
```

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

Workflow for skill changes in this repo:

1. Edit `skills/<name>/` or `skills/concepts/`.
2. `.\scripts\validate-skills.ps1`
3. `.\scripts\sync-local.ps1 -Prune`
4. `git commit` / `git push`

Use `/manage-skills` for the full checklist.

## Copied install (`install-to-project.ps1`)

Copies skills into a project's `.agents/skills`. Prefer agent-from-git when an agent can install. To update a copied install: re-run the script from an up-to-date clone of this repo, then commit `.agents/skills/`.

## Project sync on Cursor Cloud

```powershell
.\scripts\setup-project-sync.ps1 -ProjectPath C:\path\to\repo
```

Writes `.agents/sync-skills.sh` and gitignores `.agents/skills/`. For Cursor Cloud, also pass `-WireCursorCloud` so install and start both sync:

```powershell
.\scripts\setup-project-sync.ps1 -ProjectPath C:\path\to\repo -WireCursorCloud
```

`-WireCursorCloud` writes `.cursor/environment.json` so install and start both run `.agents/sync-skills.sh`. Install alone can be snapshotted stale. Default `SKILLS_REF` is `main`.

## Scripts

| Script | Purpose |
|--------|---------|
| `install-from-git.sh` | Canonical agent/project install from git |
| `setup.ps1` | Author setup: validate, sync local homes, git hooks |
| `sync-local.ps1` / `sync-local.sh` | Mirror `skills/` into local agent homes |
| `install-to-project.ps1` | Copy skills into a project's `.agents/skills` |
| `validate-skills.ps1` | Frontmatter, naming, plugin.json coverage, concepts |
| `setup-project-sync.ps1` | Wire startup sync (optional `-WireCursorCloud`) |
| `templates/project-sync/sync-skills.sh` | Startup sync to `.agents/skills/` plus `.skills-version` |
| `templates/agent-install/` | Consumer `AGENTS.md` block, Cursor rule, global language pointers |
| `setup-github.ps1` | First-time push to GitHub |
| `arxiv_research.py` | arXiv search, lookup, and snowball for `/research` |
| `test_pipelines.py` | Checks workflow transitions in `pipelines.md` and that independent skills do not name a successor |

The same list, with the repository tree, is in [Structure](structure.md).

## Related pages

- [Front page](../../README.md#install)
- [Structure](structure.md)
- [Examples](examples.md#install-into-a-consuming-repo)
