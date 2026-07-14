# cursor-skills

Personal Cursor Agent Skills — one git repo, available everywhere.

## The problem

| Location | Local IDE | Cloud agents | Cursor App |
|----------|-----------|--------------|------------|
| `~/.cursor/skills/` | Yes | No | No |
| `.cursor/skills/` in a repo | Yes (that repo) | Yes | Yes (if repo linked) |
| GitHub remote install | Yes | Yes | Yes |

Skills edited only in `~/.cursor/skills/` stay on one machine. This repo fixes that.

## Quick start (this machine)

```powershell
.\scripts\setup-cursor.ps1
```

This validates skills, syncs to `~/.cursor/skills/`, and installs git hooks so `git pull` keeps your local IDE in sync.

## Quick start (manual)

```powershell
.\scripts\sync-local.ps1 -Prune
.\scripts\validate-skills.ps1
```

## Architecture

```
cursor-skills/                 ← git source of truth
└── .cursor/skills/
    ├── base/                  ← design specs (never user-invoked)
    │   ├── alignment/
    │   └── implementation/
    ├── explore/               ├─ alignment-derived
    ├── design/                │
    ├── model/                 │
    ├── implement/             └─ implementation-derived
    ├── arxiv-research/
    ├── code-review/
    └── manage-skills/

~/.cursor/skills/              ← local mirror (sync script)
<project>/.cursor/skills/      ← per-repo copy or submodule (cloud)
GitHub remote rule             ← Cursor App / other machines
```

## Skill model

### Base skills (design specifications)

Under `.cursor/skills/base/`. Define *how* an interaction works. `disable-model-invocation: true` — users almost never invoke these directly; derived skills compose them.

| Base | Purpose |
|------|---------|
| **alignment** | Fundamental agreement via relentless one-question adaptive clarification |
| **implementation** | Management-agent delegation against an agreed specification |

### Derived skills (user-invoked)

Each skill stands alone. On invoke, read the relevant base skill, fill the extension contract, produce an artifact or deliver. Skills do not chain or reference other skills — combined workflows will be defined separately later.

| Skill | Base | Output | Jira |
|-------|------|--------|------|
| **explore** | alignment | `ROADMAP.md` | Story + Tasks |
| **design** | alignment | `PLAN.md` | Task + Sub-tasks |
| **model** | alignment (+ LaTeX format) | `MODEL.md` | Task + attachment |
| **implement** | implementation | PR or feature branch | In Progress → In Review |
| **code-review** | — | PR review | Requires In Review ticket |

Jira API reference: [`.cursor/skills/jira/reference.md`](.cursor/skills/jira/reference.md). Requires `JIRA_BASE_URL`, `JIRA_EMAIL`, `JIRA_API_TOKEN`, and usually `JIRA_PROJECT_KEY`.

### Workflows (future)

Multi-skill sequences (e.g. explore then design) are **not** encoded in skills. A separate workflow format will be added later for combining skills when needed.

### Legacy skill mapping

| Removed | Standalone replacement |
|---------|------------------------|
| `grill-me` | `design` and/or `implement` (separate invocations) |
| `grill-me-and-develop` | `design` and/or `implement` |
| `maths-grill-and-develop` | `model` and/or `implement` |
| `align` (base) | `alignment` (base) |

## Making skills global

### 1. Local IDE (all projects on this machine)

```powershell
.\scripts\sync-local.ps1 -Prune
```

Use `-Link` instead of copy if you have Windows Developer Mode enabled and want live edits.

### 2. Cloud agents

Cloud agents clone the project repo — they never see `~/.cursor/skills/`.

**Per project:** install skills into the project and commit:

```powershell
.\scripts\install-to-project.ps1 -ProjectPath C:\path\to\your-repo -All
```

**Shared across projects:** push this repo to GitHub and add it as a remote rule (see below), or use a git submodule.

### 3. Cursor App and other machines

1. Push this repo to GitHub (public or private).
2. In Cursor: **Customize → Rules → Add Rule → Remote Rule (Github)**.
3. Enter your repo URL.

Skills load without manual sync on that device.

### 4. New skill workflow

1. Add `.cursor/skills/<name>/SKILL.md` (base designs under `.cursor/skills/base/<name>/`).
2. `.\scripts\validate-skills.ps1`
3. `.\scripts\sync-local.ps1 -Prune`
4. `git add` / `git commit` / `git push`

Use `/manage-skills` in Agent chat for the full checklist.

## Scripts

| Script | Purpose |
|--------|---------|
| `setup-cursor.ps1` | **Start here** — validate, sync local, install git hooks |
| `sync-local.ps1` / `sync-local.sh` | Copy or link skills to `~/.cursor/skills/` |
| `install-to-project.ps1` | Copy skills or add submodule to a project |
| `validate-skills.ps1` | Check frontmatter and naming |
| `arxiv_research.py` | arXiv search/lookup/snowball helper (stdlib, MCP-free) |
| `setup-github.ps1` | First-time push to GitHub |

## Current skills

### Base (design specs)

- **alignment** — One-question adaptive alignment until fundamental agreement
- **implementation** — Management-agent work-package delegation against a spec

### Derived (user-invoked)

- **explore** — High-level roadmap + Jira Story/Tasks
- **design** — Component design → `PLAN.md` + Jira Task/Sub-tasks
- **model** — Mathematical spec → `MODEL.md` + Jira Task
- **implement** — Managed implementation tracked in Jira
- **code-review** — PR review tied to In Review Jira ticket
- **arxiv-research** — Topic investigation via arXiv Atom API
- **code-review** — Two-axis GitHub PR review (Standards + Spec)
- **manage-skills** — This repo's maintenance workflow

## Remote install (Cursor App + other machines)

Repo: [github.com/marcuskrogh/cursor-skills](https://github.com/marcuskrogh/cursor-skills)

1. Open **Customize** in the Cursor sidebar.
2. Go to **Rules** → **Add Rule** → **Remote Rule (Github)**.
3. Enter: `https://github.com/marcuskrogh/cursor-skills`

Skills load on that device without running the sync script.

## First-time GitHub push

If you need to push a fresh clone:

```powershell
.\scripts\setup-github.ps1
```
