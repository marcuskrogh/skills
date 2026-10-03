# Workflow contract

Shared delivery rules for pipeline skills. **Not a user-invoked skill.**
Load [disclosed refs](#disclosed-refs) only when a step needs them.

## Preconditions

1. Resolve the **effective workspace** — `$AGENT_WORKSPACE_FILE`, else repo
   `docs/agents/WORKSPACE.md` layered over global `~/.agents/WORKSPACE.md`
   ([../setup/format.md](../setup/format.md) → **Resolution order**).
2. If neither layer resolves → `/setup` first.
3. Resolve the tracker via [../tracker/SKILL.md](../tracker/SKILL.md).
4. Honour **Artifact location** (`repo` vs `external`).

## Delivery identity

- **One Task** owns work from ready-to-build through ship (provider-native key).
- **One open delivery branch + PR** per **delivery** Task through ship.
  Checkout is the **session working tree** ([delivery.md](delivery.md#rules)):
  the folder this session was started in, so a local operator can run the
  delivery head there.
- **Research / model** commit finding docs (`RESEARCH.md` / `MODEL.md`) onto that
  branch and **never open a PR**. **sandbox** commits `SANDBOX.md` plus the
  isolation tree the same way. **First PR-opening writer** is define / bug /
  tweak / refine / rework / adopt, or **implement** after a post-merge sandbox; later
  skills **reuse** the recorded head.
- **Explore** charts the map; it does not open a map-only PR. Prefer one
  define-typed delivery Task for research/model/sandbox/define that share a build
  ([delivery.md](delivery.md#charting-vs-delivery)).
- **Iterate** (post-merge only) opens a **new** Task + branch + PR when the delta
  is a straightforward production fix. **Sandbox post-merge** opens a **new**
  Task + branch from base **without** a PR; implement opens the PR after promote.

Lookup, reuse, and first-writer rules: [delivery.md](delivery.md).

## Stage ownership

Successor, mode, and chain live only in [pipelines.md](pipelines.md). This
table is stage identity: what the skill produces. It does not name a successor.

| Skill | Entry | Produces |
|-------|-------|----------|
| **explore** | Foggy initiative | `ROADMAP.md` + Story + typed route Tasks |
| **adopt** | Brownfield tree not built to the structure bar | `ADOPT.md` + Task (or Story + area Tasks); inventory and frontier behaviour map. The adopt workflow then walks the unit chain |
| **bug** | Defect; fix is the work | `BUG.md` + Task + delivery branch/PR + class binding |
| **tweak** | Small intentional change to existing behaviour | `TWEAK.md` + Task + delivery branch/PR + class binding |
| **refine** | Bounded structural/descriptive improvement; behaviour unchanged | `REFINE.md` + Task + delivery branch/PR + class binding |
| **rework** | Intentional implementation change; no measured degradation | `REWORK.md` + Task + delivery branch/PR + class binding |
| **research** | Multi-axis question | `RESEARCH.md` finding docs on delivery branch (no PR) |
| **model** | Math alignment with user | `MODEL.md` finding docs on delivery branch (no PR) |
| **sandbox** | Isolated inspect-loop for a contained element (incl. post-merge instead of iterate) | `SANDBOX.md` + isolation tree on delivery branch (no PR) |
| **define** | Route or standalone Task (front door for concrete work) | `PLAN.md` + Classification + Workflow binding + Sub-tasks + branch/PR |
| **architect** | Definition spec exists, or this skill defines one | `ARCHITECTURE.md` on the delivery branch (no extra PR) |
| **implement** | Definition spec and `ARCHITECTURE.md` exist, or this skill defines them | Code on the delivery PR (opens PR after post-merge sandbox); Task stays **In Progress** |
| **test** | Delivery diff + pass criteria, or this skill defines the criteria | Tests/seams + touched-code analysis on the **same** PR; Task stays **In Progress** |
| **restructure** (`/harden`) | Delivery diff | Refactoring on the **same** PR; Task → **In Review** |
| **iterate** | Shipped work still wrong | `ITERATE.md` + **new** Task/branch. The iterate workflow continues into sandbox or implement |
| **review** (`/review-fix`) | Task In Review | Lasers → fix → **code review** on the **same** PR → CLEAN or FAILED |
| **human review** | Shipping procedure is human review, and the agent review is CLEAN | Wait for the human's review on the open pull request |
| **fix-forward** (after human review) | That human review is on the pull request | Fixes for those findings; no new code review |
| **ship** | Bound workflow still open | Remaining chain from [pipelines.md](pipelines.md) + merge + Done |
| **summarise** | Anytime | Status only (About / Stage / Next). Reports the workflow transition; does not advance |
| **guide** | User wants a walkthrough | Paced steps (no artifact). Repeats persisted Next or none |
| **explain** | User wants current step/decisions taught | Paced beats (no artifact). Repeats persisted Next or none |

Side paths **research** / **model** enrich the **same** Task; they do not replace
user answers in **define**. **sandbox** likewise enriches the same Task with a
representative isolation tree and inspectables; it does not replace implement. Post-merge
sandbox starts a **new** Task (instead of iterate) when each turn needs inspection.

## Continuation keywords

Bare (or near-bare) cues resolve the active Task the same way
[summarise](../summarise/SKILL.md) does (explicit key → active ISSUES row → ask once).

| Cue | Meaning | Action |
|-----|---------|--------|
| **next**, continue, go | Advance **one** step | Run the persisted `## Next` skill for that Task (written by the workflow, not by the skill) |
| **ship**, finish, close it out | Finish **remaining** through Done | Run [ship](../ship/SKILL.md) |

While a **pace** is open (**guidance** or **explanation**), yes / okay / move on
and similarly approving replies are **advance**, and problem reports are
**block** — they do not fire continue or ship. Explicit `/skill` and bare
**ship** still override.

Prefer an explicit key when present (`ship MD-5`). When both could apply, follow
the user’s word. Successor map: [pipelines.md](pipelines.md). Persistence
targets: [handoff.md](handoff.md).

## Artifacts

| Artifact | Owner | Role |
|----------|-------|------|
| `WORKSPACE.md` | setup | Tracker + path + delivery decisions |
| `ROADMAP.md` | explore | Map + route. The workflow may append **Next** |
| `PLAN.md` | define | Spec + Classification + Workflow binding + keys. The workflow may append **Next** |
| `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` / `ADOPT.md` | bug / tweak / refine / rework / iterate / adopt | Spec + keys. The workflow may append **Next** |
| `RESEARCH.md` / `MODEL.md` | research / model | Finding docs on the delivery branch; never their own PR. The workflow may append **Next** |
| `SANDBOX.md` + isolation tree | sandbox | Promotion input on the delivery branch; never its own PR. The workflow may append **Next** |
| `ARCHITECTURE.md` | architect | Shape of this Task on the delivery branch; never its own PR. The workflow may append **Next** |
| Branch + PR | Define / bug / tweak / refine / rework / adopt → ship | One delivery vehicle per Task (research/model may start the branch only) |
| Merge + Done | ship | Closed-loop closeout on that PR |

Paths follow WORKSPACE. Record path + commit SHA on the Task when location is
`repo`; push full content into the Task (no SHA) when `external`.

## Disclosed refs

| When | Read |
|------|------|
| Creating or reusing branch/PR | [delivery.md](delivery.md) |
| User-facing reply, **Next**, or entry context | [handoff.md](handoff.md) + [pipelines.md](pipelines.md) |
| Tracker create / transition / comment / close | [tracker-sync.md](tracker-sync.md) |
| `/ship` remaining tails or closeout | [ship.md](ship.md) |

Value-aware worker routing: [CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md)
before every `Task` spawn.
