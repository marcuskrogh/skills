# Main workflow reference

Agent reference for the primary delivery pipeline. **Not a user-invoked skill.**

## Prerequisites

1. Read `docs/agents/WORKSPACE.md` (see [../setup/format.md](../setup/format.md)).
2. If missing → ask the user to run `/setup` (or accept defaults and write WORKSPACE.md first).
3. Resolve the issue tracker via [../tracker/SKILL.md](../tracker/SKILL.md).

## Pipeline

```text
setup (once per repo)
   ↓
explore  →  design  →  implement  →  review  →  ship
   │           │            │              │            │
 ROADMAP.md  PLAN.md     branch+PR      PR review     merge+Done
 Story+Tasks  same Task   same Task      same Task     same Task
               ↑
        research / model   (optional side paths on the same Task)
```

### Side paths (same Task + shared markdown)

| Skill | Artifact | When | Continuity updates |
|-------|----------|------|--------------------|
| **research** | `RESEARCH.md` | Literature before design/model | Task link, ROADMAP/PLAN notes, ISSUES mirror, **Next** |
| **model** | `MODEL.md` | Math spec before/with design | Task link (prefer enrich, no parallel Task), ROADMAP/PLAN/RESEARCH links, ISSUES mirror, **Next** |
| **summarise** | *(read-only)* | Anytime | Reports About / Stage / **Next** from the above |

Typical inserts:

```text
… → /research <Task> → /model <Task> → /design <Task> → …
… → /research <Task> → /design <Task> → …
… → /model <Task> → /implement <Task> → …   (if PLAN already exists)
```

## Markdown continuity

**Decisions and handoffs always live in markdown**, even when the tracker is Jira,
GitHub, or Linear:

| File | Role |
|------|------|
| `docs/agents/WORKSPACE.md` | Tracker + path + delivery decisions (`/setup`) |
| `ROADMAP.md` | Initiative + phases + keys + **Next** |
| `PLAN.md` | Design spec + keys + **Next** |
| `RESEARCH.md` | Literature brief + Task link + **Next** |
| `MODEL.md` | Math spec + Task link + **Next** |
| `docs/agents/ISSUES.md` | Mirror table (when enabled in WORKSPACE) |
| Provider issue (remote or `docs/agents/issues/*.md`) | Work-item system of record for that provider |

Never leave **Next** only in chat. Side-path skills must update the same Task’s
continuity files — not a disconnected second ticket — when a pipeline key is given.

## One issue continuity

**One Task owns a phase from design through ship** (provider-native key).

| Stage | Ticket action |
|-------|----------------|
| **explore** | Create **Story** + one **Task** per roadmap phase. Tasks are design-ready placeholders. |
| **design** | Take an explore **Task**. Enrich *that* issue (description, `PLAN.md`, Sub-tasks). Do **not** create a parallel design ticket when an explore Task is the subject. |
| **implement** | Work the **same Task** (and its Sub-tasks). Branch + PR; move to **In Review**. |
| **review** | Review the PR for that Task while it is **In Review**. |
| **ship** | Merge (or confirm merge), transition Task to **Done**, close the loop on the Story. |

### Standalone entry

| Entry | Behavior |
|-------|----------|
| `/design` with no prior explore Task | Create a new Task (+ Sub-tasks) as the pipeline owner. |
| `/implement` with an issue that already has a plan | Allowed — design may have been done offline. |
| Skip **design** | Only when the Task is already implementation-ready (acceptance + packages clear). Prefer design for non-trivial phases. |

### Linking

- Explore Tasks → parent Story via provider parent/relates.
- Design/implement/review/ship comments stay on the **same Task**.
- Comment on the parent Story at design completion and at ship (phase Done).

## Artifacts

| Artifact | Owner skill | Role |
|----------|-------------|------|
| `WORKSPACE.md` | setup | Tracker and path decisions |
| `ROADMAP.md` | explore | Project/feature scope and phase list |
| `RESEARCH.md` | research | Literature brief for a phase/Task |
| `MODEL.md` | model | Mathematical specification |
| `PLAN.md` | design | Spec for implement + Spec-axis review |
| Branch + PR | implement | Delivery vehicle |
| PR review | review | Standards + Spec findings |
| Merge + Done | ship | Closeout |
| *(status reply)* | summarise | About / stage / Next |

Use paths from `WORKSPACE.md`. Record path + commit SHA on the Task when writing artifacts.

## Handoff protocol

Every pipeline skill **ends** by telling the user the next invoke:

```markdown
## Next
`/<skill> <ISSUE-KEY>` — <one-line why>
```

| After | Next (default) |
|-------|----------------|
| setup | `/explore` (if starting work) |
| explore | `/design <first-priority-Task>` (or `/research` / `/model` if needed first) |
| research | `/model <Task>` or `/design <Task>` |
| model | `/design <Task>` or `/implement <Task>` if plan exists |
| design | `/implement <Task>` |
| implement | `/review <Task>` |
| review (blocking findings / `REQUEST_CHANGES`) | `/implement <Task>` (fix-forward) |
| review (no blockers) | `/ship <Task>` |
| ship | Done — no next skill |
| summarise | *(reports Next; does not advance)* |

Also write **Next** into: the issue comment (or markdown Comments section), the
alignment artifact, and the ISSUES mirror when enabled.

### Entry context

| Skill | Load |
|-------|------|
| research / model | Task (+ Story), `ROADMAP.md`, sibling artifacts (`RESEARCH.md` / `MODEL.md` / `PLAN.md`) |
| design | Task (+ parent Story), `ROADMAP.md`, `RESEARCH.md` / `MODEL.md` if present |
| implement | Task + Sub-tasks, `PLAN.md` / `MODEL.md` / linked specs |
| review | Task + PR + `PLAN.md` / specs |
| ship | Task + PR + latest review outcome |
| summarise | Task + all of the above for stage inference |

## Status chain

```text
To Do / Backlog  →  In Progress  →  In Review  →  Done
     explore/design      implement        implement     ship
                                         review
```

| Skill | Status duty |
|-------|-------------|
| explore / design | Leave new/enriched Tasks in **To Do** (or project default). |
| implement | **In Progress** at start; **In Review** when PR is ready. |
| implement (fix-forward) | May return briefly to **In Progress**, then **In Review** again. |
| review | Requires **In Review**; does not transition to Done. |
| ship | **Done** on the Task after successful closeout. |

## Fix-forward

When **review** leaves blocking findings:

1. Next skill is **implement** on the same Task (not a new issue).
2. Implement treats open PR review threads as the work packages.
3. Do not invent new scope beyond the review + existing plan.
4. Re-open or keep the PR; return Task to **In Review** when ready.
5. User runs **review** again, then **ship**.

## Anti-patterns

- Creating issues before `WORKSPACE.md` exists (run `/setup` first)
- Hardcoding Jira (or any single provider) when WORKSPACE selects another
- Creating a second Task in design when an explore Task was provided
- Ending a pipeline skill without a **Next** handoff persisted in markdown
- Marking **Done** from implement or review (that is **ship**)
- Leaving continuity only in chat or only in a remote tracker with mirror enabled but skipped
