# Main workflow reference

Agent reference for the primary delivery pipeline. **Not a user-invoked skill.**

## Prerequisites

1. Read `docs/agents/WORKSPACE.md` (see [../setup/format.md](../setup/format.md)).
2. If missing → ask the user to run `/setup` (or accept defaults and write WORKSPACE.md first).
3. Resolve the issue tracker via [../tracker/SKILL.md](../tracker/SKILL.md).

## Value-aware sub-agent routing

Whenever a pipeline skill spawns sub-agents (`Task` / investigators / work
packages), apply [CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md):

| Role | Model |
|------|-------|
| **Manager / orchestrator** (plan, merge findings, tracker, ship control) | Parent session — prefer top available **high-capability** model; never hand orchestration to a low-capability worker |
| **Workers** (implement packages, review axes, research axes, fix-forward) | Default **low-capability** (platform catalog); elevate **high-capability** only for Demanding signals or after a failed value-tier attempt |

Bias toward low-capability for value-efficient handling. Especially enforce this in
**implement**, **review**, and **review-fix**; also when **research**, **iterate**,
or **ship** compose those paths. Detect the platform, score difficulty before each
spawn, and pass `model` from the ranked catalog when the harness supports it.

## Pipeline

### Feature workflow

```text
setup (once per repo)
   ↓
explore  →  (research / model)*  →  define  →  implement  →  review-fix  →  ship
   │              │                   │            │              │               │
 ROADMAP.md    RESEARCH.md         PLAN.md     same branch   review↔fix loop  merge that PR
 map Story     / MODEL.md          + branch+PR  + same PR     same Task         + Done
 + route Tasks  (route Tasks)       same Task ───────────────────────────────→ closed-loop
   │                                                      ↑
   └──── sequenced / dependent frontier ──────────────────┘
```

Explore **charts** the foggy effort as a map: Destination, route Tasks (typed and
ordered, with blockers), fog (Not yet specified), and Out of scope. Downstream
skills **walk** the frontier; re-invoke `/explore` on the map to graduate fog.

(`/review` remains available for a one-shot review without auto-fix.)

**One branch, one PR, closed-loop ship** — see [Delivery branch continuity](#delivery-branch-continuity-closed-loop).
When the user continues via **Next**, every skill from define through ship reuses the
Task’s delivery branch and PR. **`/ship`** may also be invoked at any point after
define (or after bug / iterate ready-to-build) to run the **remaining** steps
(`implement` and/or `review-fix` as needed, then closeout). Closeout updates
continuity on that branch, merges it, and leaves no open follow-up PR.

### Bug fix workflow

```text
setup (once per repo)
   ↓
bug  →  implement  →  review-fix  →  ship
 │          │              │               │
BUG.md   same branch   review↔fix loop  merge that PR
+ branch+PR  same PR     same Task         + Done
 Task ──────────────────────────────────→ closed-loop
```

**`/bug` replaces explore + define** for defects: one short alignment → `BUG.md` + one
Task → same delivery loop. Use **explore/define** when the change is a feature or
needs product/definition decisions; use **bug** when behaviour is wrong and the fix is
the work.

### Iterate workflow (post-ship follow-up)

```text
… → ship (merged)
        ↓
iterate  →  review-fix  →  ship  →  (optional) iterate again …
   │              │             │
ITERATE.md    review↔fix     merge+Done
 new Task       new Task      new Task
 new branch+PR
```

**`/iterate`** is for work that **already shipped** but still needs a fix: brief
clarify → new branch from base → implement → **new** PR → `/review-fix`. It does
**not** replace fix-forward on an **open** PR (`/review-fix` / `/implement`). Prefer
`/bug` for a brand-new unrelated defect with no shipped lineage.

### Side paths (same Task + shared markdown)

| Skill | Artifact | When | Continuity updates |
|-------|----------|------|--------------------|
| **research** | `RESEARCH.md` | Multi-axis literature before define/model (arXiv + formal + web + informal) — **supportive evidence only**, not user alignment | Task link, ROADMAP/PLAN notes, ISSUES mirror, **Next** |
| **model** | `MODEL.md` | Math alignment with user before/with define — **math only**, not product definition | Task link (prefer enrich, no parallel Task), ROADMAP/PLAN/RESEARCH links, ISSUES mirror, **Next** |
| **summarise** | *(read-only)* | Anytime (feature or bug Task) | Reports About / Stage / **Next** from the above |

Research and model **add information and direction**. They must not be treated as
substitutes for user answers in **define**. Define always probes the user on
scope, behaviour, constraints, and acceptance.

Typical feature inserts:

```text
… → /research <Task> → /model <Task> → /define <Task> → …
… → /research <Task> → /define <Task> → …
… → /model <Task> → /implement <Task> → …   (if PLAN already exists)
```

Bug path (no inserts required):

```text
/bug → /implement <Task> → /review-fix <Task> → /ship <Task>
```

Post-ship iterate path:

```text
/ship <Task> → /iterate <description> → /review-fix <NewTask> → /ship <NewTask>
             ↘ (problems persist) ──────────────────────────────↗ /iterate …
```

### Review-fix loop

Prefer **`/review-fix`** after implement to avoid manual review↔implement iteration:

```text
review → (must-fix?) → implement fix-forward → review → … → clean → /ship
```

Must-fix = `blocker` + `should-fix` + **actionable** `note`s (see CONCEPT_REVIEW /
review-fix). Plain **`/review`** only posts findings and hands off; you then run
`/implement` yourself (or `/review-fix` to auto-loop).
## Markdown continuity

**Decisions and handoffs always live in markdown**, even when the tracker is Jira,
GitHub, or Linear:

| File | Role |
|------|------|
| `docs/agents/WORKSPACE.md` | Tracker + path + delivery decisions (`/setup`) |
| `ROADMAP.md` | Initiative map + route + keys + **Next** (features) |
| `PLAN.md` | Definition / plan + keys + **Next** (features) |
| `BUG.md` | Bug report + acceptance + **Next** (bug fixes) |
| `ITERATE.md` | Post-ship fix delta + acceptance + **Next** (iterate) |
| `RESEARCH.md` | Multi-axis research brief (supportive evidence) + Task link + **Next** |
| `MODEL.md` | Math alignment with user + Task link + **Next** |
| `docs/agents/ISSUES.md` | Mirror table (when enabled in WORKSPACE) |
| Provider issue (remote or `docs/agents/issues/*.md`) | Work-item system of record for that provider |

Never leave **Next** only in chat. Side-path skills must update the same Task’s
continuity files — not a disconnected second ticket — when a pipeline key is given.

## One issue continuity

**One Task owns work from ready-to-build through ship** (provider-native key).

| Stage | Ticket action |
|-------|----------------|
| **explore** | Create **Story** (the map) + one **Task** per route step (research / model / define / task), with type, sequence, and **Blocked by**. Fog stays in `ROADMAP.md` until sharp enough to ticket. Explore does **not** open the delivery PR for a route Task. |
| **bug** | Create one **Task** (+ optional Sub-tasks) from `BUG.md`. No Story unless requested. Start the Task’s **delivery branch** (+ draft PR when Open PR by default) when committing `BUG.md`. |
| **define** | Take an explore **Task**. Probe particulars with the user (explore / research / model did not decide product scope, behaviour, or acceptance). Enrich *that* issue (description, `PLAN.md`, Sub-tasks). Do **not** create a parallel definition ticket when an explore Task is the subject. Start or **reuse** the Task’s **delivery branch** (+ draft PR) when committing `PLAN.md`. |
| **research / model** | Enrich the **same Task**. If a delivery branch/PR already exists, commit artifacts there. If not and the skill is committing repo files for this Task, start the delivery branch (+ draft PR) so later define/implement continue on it. |
| **implement** | Work the **same Task** (and its Sub-tasks). Spec from `PLAN.md` or `BUG.md`. **Reuse** the existing delivery branch + PR; only create them if missing. Tests/testability first-class; move to **In Review**. |
| **iterate** | After ship: create a **new** Task from `ITERATE.md` (Relates to prior); new branch from base + **new** PR; move new Task to **In Review**. |
| **review** | One-shot multi-axis review (Spec, Correctness, Integration, Architecture, Standards) on the **same** PR; may hand off to fix-forward manually. |
| **review-fix** | Review → fix-forward → re-review on the **same** branch/PR until clean (or max iterations); then ship closeout (or continue via `/ship`). |
| **ship** | **Remaining-workflow orchestrator** after define/bug/iterate-ready: run `implement` and/or `review-fix` as still needed, then closed-loop closeout — push continuity (`PLAN`/`ROADMAP`/`ISSUES`, …) onto the **same** delivery branch → merge **that** PR → close Sub-tasks/Task/(Story when complete). **No** second ship-only PR. |

## Delivery branch continuity (closed-loop)

**Goal:** for one pipeline Task (e.g. `SWD-84`), continuing via **Next** yields
**one branch and one PR** from the first repo-writing skill on that Task through
ship — not separate PRs for research, define, implement, and ship.

### Rules

1. **One delivery branch per Task.** Name it per WORKSPACE (`Branch pattern` + Task
   key). Record **branch name** and **PR URL** on the Task (comment + `PLAN.md` /
   `BUG.md` Tracker section + ISSUES mirror) as soon as they exist.
2. **Resolve before create.** On every pipeline skill that writes to the repo for
   that Task, look up the Task’s recorded branch/PR (issue comment, artifact
   Tracker section, ISSUES, `gh pr list` by head/Task key). If an **open** delivery
   PR or branch exists → **checkout/reuse it**. Do **not** open a second PR.
3. **First writer starts it.** The first of research / model / define / bug that
   commits artifacts for the Task creates the branch (and draft PR when
   `Open PR by default`). Later skills only push commits to that head.
4. **Implement never forks a parallel PR.** If define (or research/bug) already
   opened `cursor/<key>-…`, implement continues there — same PR body updated,
   not `…-implement-…` as a second PR.
5. **Ship finishes remaining work, then is closed-loop on that PR:**
   - If implement and/or review-fix are still outstanding, `/ship` composes them
     first on the **same** delivery branch/PR (no parallel PR).
   - When review-ready/clean: commit markdown closeout (`PLAN.md` shipped notes,
     `ROADMAP.md` phase Done, ISSUES mirror, markdown issue files if provider is
     markdown) onto the **delivery branch** and **push**.
   - Then **merge that PR** (WORKSPACE strategy).
   - Delete the remote head branch after merge when the host allows.
   - Tracker Done transitions may follow merge; they are remote ops, not a new PR.
   - **Never** open a ship-only follow-up PR for continuity leftovers.
6. **Explore** may write `ROADMAP.md` (the map) without owning a route Task’s delivery PR
   — research / model / define own delivery continuity when they first write for that Task.
   Once a route Task has a delivery branch, further ROADMAP Route/Cleared updates for
   that Task go on **that** branch when practical.
7. **Iterate** (post-ship only) always starts a **new** Task + **new** branch +
   **new** PR — that is a new closed-loop, not a continuation of a merged PR.

### Anti-pattern (what this replaces)

```text
❌ /research → PR #A
   /define   → PR #B
   /implement → PR #C
   /ship     → merge #C, then leftover PR #D for ROADMAP/PLAN closeout

✅ /research → branch+draft PR #N (or wait until define)
   /define   → same #N (PLAN.md)
   /implement → same #N (code)
   /review-fix → same #N
   /ship     → closeout commits on #N → merge #N → Done (no open PR left)
```

### Standalone entry

| Entry | Behavior |
|-------|----------|
| `/bug` | Create Task from bug alignment; Next `/implement`. |
| `/iterate` | Post-ship only; create new Task + implement + new PR; Next `/review-fix`. |
| `/define` with no prior explore Task | Create a new Task (+ Sub-tasks) as the pipeline owner. |
| `/implement` with an issue that already has PLAN or BUG | Allowed. |
| Skip **define** on features | Only when already implementation-ready. Prefer define for non-trivial features. |

### Linking

- Explore route Tasks → parent Story (map) via provider parent/relates. Record **Blocked by** on dependents.
- Bug Tasks are usually standalone; may **Relates** to a Story/Task if they block a phase.
- Iterate Tasks are **new** Tasks that **Relates** to the shipped prior Task (or prior iterate Task).
- Define/implement/review/ship comments stay on the **same Task**.
- Comment on the parent Story at define completion and at ship (phase Done).
- Comment on the prior Task when an iterate follow-up Task is created.

## Artifacts

| Artifact | Owner skill | Role |
|----------|-------------|------|
| `WORKSPACE.md` | setup | Tracker and path decisions |
| `ROADMAP.md` | explore | Map: Destination + sequenced route + fog + out of scope + **Next** |
| `BUG.md` | bug | Defect report + acceptance for implement/review |
| `ITERATE.md` | iterate | Post-ship fix delta + acceptance for implement/review |
| `RESEARCH.md` | research | Multi-axis research brief — supportive evidence for a phase/Task (not user alignment) |
| `MODEL.md` | model | Mathematical specification aligned with the user (not product definition) |
| `PLAN.md` | define | Spec for implement + Spec-axis review (user-aligned particulars) |
| Branch + PR | define / bug / research / model (first writer) → implement → ship; **iterate** post-ship | **One** delivery vehicle per Task through ship (iterate always opens a **new** PR) |
| PR review | review / review-fix | Multi-axis findings incl. Architecture (+ auto fix-forward in review-fix) |
| Merge + Done | ship | Remaining-workflow orchestrator then closed-loop closeout on the **same** PR (no leftover PR) |
| *(status reply)* | summarise | About / stage / Next |

Use paths from `WORKSPACE.md`. Record path + commit SHA on the Task when writing artifacts.

## Handoff protocol

Every pipeline skill **ends** by telling the user the next invoke:

```markdown
## Next
`/<skill> <ISSUE-KEY>` — <one-line why>
```

### Continuation keywords

Treat these bare (or near-bare) user phrases like skill invokes. Resolve the active
Task the same way [summarise](../summarise/SKILL.md) does (explicit key → active
ISSUES row → ask once).

| Keyword (examples) | Meaning | Action |
|--------------------|---------|--------|
| **next**, "what's next", "continue", "go" | Advance **one** step | Run the persisted `## Next` skill for that Task (e.g. `/implement`, `/review-fix`). Do **not** skip ahead through the whole tail. |
| **ship**, "ship it", "finish", "finish remaining", "close it out" | Finish **remaining** work through Done | Run [ship](../ship/SKILL.md) for that Task — implement and/or review-fix as still needed, then closeout. |

Rules:

1. **next** and **ship** are first-class cues — do not ask which skill if the cue and
   active Task are clear.
2. Prefer an explicit key in the message (`ship MD-5`, `next SWD-84`) when present.
3. If both could apply, follow the user's word: **ship** → remaining-workflow
   orchestrator; **next** → single persisted Next step.
4. If the Task is not ready for ship (no PLAN/BUG/ITERATE), say so and fall back to
   the correct Next (usually `/define` / `/bug` / `/iterate`).

| After | Next (default) |
|-------|----------------|
| setup | `/explore` or `/bug` (depending on intent) |
| explore | Frontier route Task: `/research` / `/model` / `/define` / checklist as typed — lowest unblocked **Order** |
| bug | `/implement <Task>` — or `/ship <Task>` to finish remaining (implement → review-fix → closeout) |
| research | `/model <Task>` or `/define <Task>` |
| model | `/define <Task>` or `/implement <Task>` if plan exists |
| define | `/implement <Task>` — or `/ship <Task>` to finish remaining (implement → review-fix → closeout) |
| implement | `/review-fix <Task>` (preferred) or `/review <Task>` — or `/ship <Task>` to finish remaining (review-fix → closeout) |
| iterate | `/review-fix <NewTask>` — or `/ship <NewTask>` to finish remaining |
| review (must-fix findings / `REQUEST_CHANGES`) | `/implement <Task>` (fix-forward) — or use `/review-fix` / `/ship` to automate |
| review (no must-fix; non-actionable notes optional) | `/ship <Task>` (closeout) |
| review-fix (CLEAN) | `/ship <Task>` (closeout) |
| review-fix (STOPPED / STALLED) | `/implement <Task>` or `/review <Task>` (manual) or re-run with higher max — or `/ship <Task>` to retry remaining |
| ship (Done) | Done — no next skill (or next phase / next bug); if merged work still wrong → `/iterate` |
| ship (stopped before Done) | `/ship <Task>` to retry remaining, or the specific skill that unblocks |
| summarise | *(reports Next; does not advance — may suggest `/ship` to finish remaining)* |

Also write **Next** into: the issue comment (or markdown Comments section), the
alignment artifact, and the ISSUES mirror when enabled.

### Entry context

| Skill | Load |
|-------|------|
| bug | Existing related Task/Story if linked; codebase pointers from user only |
| iterate | Prior shipped Task + merged PR + `PLAN.md` / `BUG.md` / prior `ITERATE.md` |
| research / model | Task (+ Story), `ROADMAP.md`, sibling artifacts (`RESEARCH.md` / `MODEL.md` / `PLAN.md`) — research is supportive only |
| define | Task (+ parent Story), `ROADMAP.md`, `RESEARCH.md` / `MODEL.md` if present as **supportive** context — still question the user |
| implement | Task + Sub-tasks, `PLAN.md` or `BUG.md` / `MODEL.md` / linked specs; **existing delivery branch/PR**; project test/lint commands |
| review / review-fix | Task + **same** delivery PR + `PLAN.md` / `BUG.md` / `ITERATE.md` / specs |
| **ship** | Task + `PLAN.md` / `BUG.md` / `ITERATE.md` + delivery branch/PR when present; detect stage; compose implement / review-fix as needed; then closeout on that PR |
| summarise | Task + all of the above for stage inference |

## Status chain

```text
To Do / Backlog  →  In Progress  →  In Review  →  Done
     explore/define      implement        implement     ship
     research/model      iterate          iterate
     bug                                  review
```

## Tracker sync matrix (mandatory)

Every pipeline skill **must** update the configured tracker (and markdown mirror when
enabled). Chat-only status is not enough.

| Skill | Create / update issues | Status transitions | Comments / links | Close |
|-------|------------------------|--------------------|------------------|-------|
| **explore** | Create Story (map) + typed route Tasks; link children → Story; record Blocked by | Leave Story/Tasks **To Do** | Story comment: child keys + deps + **Next**; upsert ISSUES | Mis-scoped only |
| **bug** | Create Task (+ optional Sub-tasks); link BUG.md; start delivery branch + draft PR | Leave **To Do** | Task comment: BUG.md + branch/PR + **Next**; ISSUES | — |
| **iterate** | Create **new** Task; link ITERATE.md; Relates → prior Task | New Task → **In Progress** then **In Review** when PR ready | Prior Task comment (follow-up key); new Task comments + PR + **Next** `/review-fix`; ISSUES | — (ship closes the new Task) |
| **research** | Enrich pipeline Task (artifact link); no new Task if key given; reuse/start delivery branch when committing | Leave Task status unchanged (usually **To Do**) | Task comment: RESEARCH.md + branch/PR + summary + **Next**; ROADMAP/PLAN/ISSUES | — |
| **model** | Enrich pipeline Task (preferred); else create Task; reuse/start delivery branch when committing | Leave **To Do** unless already further along | Task comment: MODEL.md + branch/PR + **Next**; ROADMAP/PLAN/RESEARCH/ISSUES | — |
| **define** | Enrich Task; create Sub-tasks per work package; start/reuse delivery branch + draft PR when committing PLAN.md | Task stays **To Do** (ready to implement) | Task + Story comments: PLAN.md, branch, PR URL, sub-task keys, **Next**; ISSUES | — |
| **implement** | May add missing Sub-tasks if plan/bug requires (incl. Testing packages); **reuse** delivery branch/PR | Task → **In Progress** at start; each Sub-task → **In Progress** then **Done** when finished; Task → **In Review** when PR ready (after tests/lint verify) | Comments on Task (session start, packages, **same** PR URL + **Next** `/review-fix`); ISSUES | Sub-tasks **Done** as packages complete — not the parent Task |
| **implement** (fix-forward) | — | Task → **In Progress** if needed, then **In Review** again | Comment: threads addressed + **Next** `/review` or continue inside `/review-fix`; ISSUES | — |
| **review** | — | Must already be **In Review**; do **not** change to Done | Task comment: review summary + **Next**; ISSUES | — |
| **review-fix** | — | Alternates review publish + fix-forward status as above each iteration | Comment each iteration; ISSUES | — (ship closes) |
| **ship** | May compose implement / review-fix first (their rows apply while running) | See [Ship remaining workflow](#ship-remaining-workflow) + [Ship closeout](#ship-closeout) | Task + Story comments; pre-merge ROADMAP/PLAN/ISSUES on delivery branch | **Yes** (after CLEAN) — merge **that** PR (no ship-only PR); close Task, remaining Sub-tasks, and Story when complete |
| **summarise** | — | Read-only (may fix stale mirror **Next** text only) | — | — |

### Rules

1. **Always** `comment` (or markdown Comments) with **Next** when a skill finishes.
2. **Always** upsert `docs/agents/ISSUES.md` when mirror is enabled — same status as the tracker.
3. Provider backends implement `transition` / close natively (Jira Done, GitHub `gh issue close`, Linear Done, markdown Status field).
4. Never mark the **pipeline Task** **Done** before **ship**.
5. Never leave Sub-tasks open after **ship**.

## Ship remaining workflow

**`/ship` finalizes whatever is still left** after define (feature), bug (defect),
or iterate (post-ship Task ready). It is not limited to “clean review → merge”.

```text
detect stage
   ↓
if not ready-to-build (no PLAN/BUG/ITERATE) → stop; tell user /define|/bug|/iterate
   ↓
if implementation outstanding → run /implement (build) on the delivery branch/PR
   ↓
if review not CLEAN → run /review-fix on the same PR
   ↓
if CLEAN (or already ship-ready) → Ship closeout
   ↓
if review-fix STOPPED/STALLED → stop; do not merge; report Next
```

| Invoked when | Remaining |
|--------------|-----------|
| After define / bug (To Do, plan/bug ready) | implement → review-fix → closeout |
| After implement (In Review) | review-fix → closeout |
| After review-fix CLEAN / clean review | closeout |
| After iterate (new Task In Review) | review-fix → closeout |

Composed skills keep their full contracts (tests, status, mirror, delivery-branch
reuse). Ship only chooses **which** of them still need to run.

## Ship closeout

**Closeout is closed-loop on the Task’s single delivery PR.** Do not open a new
branch or PR for closeout. Run closeout only after the remaining path has a CLEAN
review (or the Task was already ship-ready / user explicitly overrides).

Order:

1. **Pre-merge continuity (on the delivery branch)** — while the PR is still
   **open**, commit and push:
   - `PLAN.md` / `BUG.md` / `ITERATE.md` — mark shipped / Next Done + PR link
   - `ROADMAP.md` — phase row Done + PR link (when this Task owns a phase)
   - ISSUES mirror (and markdown issue files if provider is markdown) reflecting
     imminent Done
   - Any other continuity the session owes the repo for this Task
2. **Merge** — merge **that** PR per WORKSPACE strategy. On failure, **stop** —
   do not close tracker issues; do not open a replacement PR for the same closeout.
3. **Sub-tasks** — `transition` every still-open child of the Task → **Done**
   (comment each or one batch comment on the parent listing them).
4. **Task** — `transition` → **Done**; comment with PR URL, merge SHA, list of
   closed Sub-tasks, **Next: Done**.
5. **Story** (if linked):
   - Comment that this phase Task is Done (key + PR).
   - If **all** child Tasks of the Story are **Done**, `transition` Story → **Done**
     and comment "Initiative complete".
   - Otherwise leave Story open; set Story **Next** hint to `/define <next-open-Task>`
     or `/summarise <Story>`.
6. **Remote branch** — delete the delivery head after merge when the host allows
   (`gh pr merge --delete-branch` or equivalent). Confirm no open PR remains for
   this Task.
7. **Stop** if merge failed — do not close anything.

If the PR was **already merged** before ship ran, apply any missing markdown
continuity as a **direct commit on the base branch** only when unavoidable — still
**do not** leave an unmerged closeout PR. Prefer keeping continuity in the delivery
PR before merge so this fallback is rare.

## Fix-forward

When **review** leaves must-fix findings (`blocker`, `should-fix`, or actionable
`note`s) and you are **not** using **review-fix**:

1. Next skill is **implement** on the same Task (not a new issue).
2. Implement treats open PR review threads as the work packages (including actionable notes).
3. Do not invent new scope beyond the review + existing plan/bug.
4. Re-open or keep the PR; return Task to **In Review** when ready (tracker + mirror).
5. User runs **review** again, then **ship**.

Prefer **`/review-fix <KEY>`** to run steps 1–5 automatically until clean (see that skill for max-iteration / stall guards; default max **4**).

## Post-ship iterate

When a Task is **Done** and its PR is **merged**, but the delivered behaviour is still
wrong or incomplete:

1. Next skill is **`/iterate`** (not fix-forward on the merged PR).
2. Iterate creates a **new** Task + `ITERATE.md`, branches from base, opens a **new** PR.
3. User runs **`/review-fix`** on the new Task, then **`/ship`** — or **`/ship`**
   alone to finish remaining (review-fix → closeout).
4. Repeat `/iterate` if problems persist after that ship.

Do **not** use `/iterate` while the original PR is still open — that is fix-forward.

## Anti-patterns

- Creating issues before `WORKSPACE.md` exists (run `/setup` first)
- Hardcoding Jira (or any single provider) when WORKSPACE selects another
- Creating a second Task in define when an explore Task was provided
- Treating `RESEARCH.md` or `MODEL.md` as settled product definition so define skips user probes
- Ending a pipeline skill without tracker comment + **Next** (+ mirror)
- Marking **Done** from implement, iterate, or review (that is **ship**)
- Shipping while Sub-tasks remain open
- Closing the Story while sibling phase Tasks are still open
- Leaving continuity only in chat or only in a remote tracker with mirror enabled but skipped
- Opening an iterate PR while the same work still has an **open** PR (use fix-forward)
- Reusing a merged PR / old head instead of a new branch from base for post-ship fixes
- Opening a **new** branch/PR per skill step (research / define / implement / ship) for the same Task
- Implement ignoring an existing define/research delivery PR and starting a parallel `…-implement-…` PR
- Ship merging the code PR then leaving a **second unmerged PR** for ROADMAP/PLAN/ISSUES closeout
- Recording **Next** without recording the delivery **branch + PR** so the following skill cannot reuse them
- Running all implement/review workers on high-capability by default (violates CONCEPT_DELEGATION — prefer low-capability unless Demanding)
