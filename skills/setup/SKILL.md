---
name: setup
description: >-
  Workspace alignment at repository or global (user-level) scope: choose issue
  tracker (markdown, Jira, GitHub, or Linear), artifact location, and delivery
  conventions. Writes docs/agents/WORKSPACE.md, or ~/.agents/WORKSPACE.md for
  machine-wide defaults that apply to every repo without adding files to it.
  Use when onboarding a repo, setting global defaults, changing tracker, or
  before first explore/define.
---

# Setup

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) to **workspace
configuration**. Produces a `WORKSPACE.md` that all pipeline skills read first,
at either scope:

| Scope | Path | Use when |
|-------|------|----------|
| **repository** | `docs/agents/WORKSPACE.md` (path overridable) | Settings belong to this repo and its collaborators |
| **global** | `~/.agents/WORKSPACE.md` | The user wants one setup for every repo, with nothing added to the repos |

Repository settings override global ones field by field — see
[format.md](format.md) → **Resolution order**.

**On invoke:** read [../concepts/CONCEPT_ALIGNMENT.md](../concepts/CONCEPT_ALIGNMENT.md),
[format.md](format.md), and [../tracker/reference.md](../tracker/reference.md).

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | How the agent pipeline runs — for this repo, or for every repo (global scope) |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | Scope, tracker provider, artifact location/paths, and delivery defaults are unambiguous |
| **Alignment artifact** | `docs/agents/WORKSPACE.md` or `~/.agents/WORKSPACE.md` (see [format.md](format.md)) |
| **Readiness prompt** | "Does this workspace setup look right to commit?" (repository) / "…to save as your global default?" (global) |

### Probes

- **Scope**: this repository, or global default for every repo
- Issue tracker provider: **markdown** | **jira** | **github** | **linear**
- Provider-specific settings (project key, issues dir, Linear team, GitHub repo)
- Whether to **always mirror** issue keys/status/Next into markdown (`docs/agents/ISSUES.md`)
- **Artifact location**: inside the repo, or **external** (e.g. `~/.agents/artifacts/<repo>`) with content pushed into the tracker issue
- Artifact roots: agents dir, roadmap path, plan path pattern, model path
- Default base branch, branch naming, PR default (open vs branch-only), merge strategy
- Confirm **one delivery PR per Task** (define→ship closed-loop; default yes)
- Whether pipeline skills may invent a default setup if no `WORKSPACE.md` resolves (recommend: no — run setup)

### Opening

| Context | First move |
|---------|------------|
| **Thin** | "Should this setup apply to this repository only, or become your global default for every repo?" then "Which issue tracker — local markdown, Jira, GitHub Issues, or Linear?" |
| **Rich** / existing `WORKSPACE.md` | Load the effective workspace (both layers); state which fields come from global; ask the highest-impact divergence (usually tracker or paths) |
| **Global exists, repo does not** | Show the inherited setup and ask only what this repo must differ on — do not re-interview |

### Scope guard

- No feature definition, modelling, or implementation
- Do not create pipeline Story/Task issues during setup (only config + empty dirs/index if markdown)
- Global scope: do not create repo directories, do not stage or commit anything into a repo

## After approval

1. Write the workspace file per [format.md](format.md):
   - **repository** → `docs/agents/WORKSPACE.md` with `Scope: repository`; record only fields that differ from global when a global layer exists.
   - **global** → `~/.agents/WORKSPACE.md` with `Scope: global`, creating `~/.agents/` if needed.
2. Ensure the agents directory exists (repository scope only).
3. If provider is **markdown**: create issues dir + `INDEX.md` stub per [../tracker/backends/markdown.md](../tracker/backends/markdown.md) (repository scope only).
4. If mirror enabled: create `docs/agents/ISSUES.md` stub (headers only, repository scope only).
5. If artifact location is **external**: create the resolved root and confirm the path back to the user. Never add it to a repo or `.gitignore`.
6. Commit when the user wants (ask once): workspace setup only. **Never commit a global workspace file** — report its path instead.
7. Verify provider credentials are reachable (see [../tracker/reference.md](../tracker/reference.md)); report anything missing rather than failing later mid-pipeline.
8. Report path, scope, and chosen tracker. **Next** depends on intent:

```markdown
## Next
`/explore` — Chart foggy or large work (map + route)
```

or

```markdown
## Next
`/bug` — Report and fix a defect
```

or, if they only wanted config: no further skill.

## Re-run

Re-invoking `/setup` updates the workspace file at the scope being edited; ask
which scope when both exist. Do not delete existing issues; note migrations the
user must do if the provider changes. Changing global scope does not rewrite
repository files that already override it.

