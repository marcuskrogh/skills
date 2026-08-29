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
5. Honour WORKSPACE `Agent language` (`user-facing` default, or `general`) per
   [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md).

## Delivery identity

- **One Task** owns work from ready-to-build through ship (provider-native key).
- **One open delivery branch + PR** per **delivery** Task through ship.
- **Research / model** commit finding docs (`RESEARCH.md` / `MODEL.md`) onto that
  branch and **never open a PR**. **sandbox** commits `SANDBOX.md` plus the
  isolation tree the same way. **First PR-opening writer** is define / bug /
  tweak / refine / rework, or **implement** after a post-merge sandbox; later
  skills **reuse** the recorded head.
- **Explore** charts the map; it does not open a map-only PR. Prefer one
  define-typed delivery Task for research/model/sandbox/define that share a build
  ([delivery.md](delivery.md#charting-vs-delivery)).
- **Iterate** (post-merge only) opens a **new** Task + branch + PR when the delta
  is a straightforward production fix. **Sandbox post-merge** opens a **new**
  Task + branch from base **without** a PR; implement opens the PR after promote.

Lookup, reuse, and first-writer rules: [delivery.md](delivery.md).

## Stage ownership

| Skill | Entry | Produces | Default Next |
|-------|-------|----------|--------------|
| **explore** | Foggy initiative | `ROADMAP.md` + Story + typed route Tasks | Frontier skill by Order |
| **bug** | Defect; fix is the work | `BUG.md` + Task + delivery branch/PR | `/implement` |
| **tweak** | Small intentional change to existing behaviour | `TWEAK.md` + Task + delivery branch/PR | `/implement` |
| **refine** | Bounded structural/descriptive improvement; behaviour unchanged | `REFINE.md` + Task + delivery branch/PR | `/implement` |
| **rework** | Intentional implementation change; no measured degradation | `REWORK.md` + Task + delivery branch/PR | `/implement` (comparative) |
| **research** | Multi-axis question | `RESEARCH.md` finding docs on delivery branch (no PR) | `/model` or `/define` |
| **model** | Math alignment with user | `MODEL.md` finding docs on delivery branch (no PR) | `/define` |
| **sandbox** | Isolated inspect-loop for a contained element (incl. post-merge instead of iterate) | `SANDBOX.md` + harness on delivery branch (no PR) | `/sandbox` (delta) or `/implement` (promote) |
| **define** | Route or standalone Task (front door for concrete work) | `PLAN.md` + Classification + Workflow binding + Sub-tasks + branch/PR | First skill in bound Chain (usually `/implement`) |
| **implement** | PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/SANDBOX ready | Code on **same** PR (opens PR after post-merge sandbox); Task stays **In Progress** | `/test` (or `/harden` / `/review-fix` when those phases are skipped) |
| **test** | After implement; `test.mode=dedicated` | Tests/seams on the **same** PR; Task stays **In Progress** | `/harden` or `/review-fix` |
| **harden** | After test (or implement when test skipped); `harden.mode=dedicated` | Structure edits on the **same** PR; Task → **In Review** | `/review-fix` |
| **iterate** | Shipped work still wrong; straightforward production fix | `ITERATE.md` + **new** Task/PR; then bound closeout chain | `/test` (or first remaining closeout step) |
| **review** | Task In Review | Findings + **code review** on the **same** PR | `/review-fix` or `/ship` |
| **review-fix** | Task In Review | Lasers → fix-forward → **code review** → CLEAN | `/ship` |
| **ship** | After ready-to-build | Remaining work + merge + Done | Done (or `/iterate` / `/sandbox`) |
| **summarise** | Anytime | Status only (About / Stage / Next) | *(reports; does not advance)* |
| **guide** | User wants a walkthrough | Paced steps (no artifact) | Resume persisted Next or none |
| **explain** | User wants current step/decisions taught | Paced beats (no artifact) | Resume persisted Next or none |

Side paths **research** / **model** enrich the **same** Task; they do not replace
user answers in **define**. **sandbox** likewise enriches the same Task with a
representative harness and inspectables; it does not replace implement. Post-merge
sandbox starts a **new** Task (instead of iterate) when each turn needs inspection.

## Continuation keywords

Bare (or near-bare) cues resolve the active Task the same way
[summarise](../summarise/SKILL.md) does (explicit key → active ISSUES row → ask once).

| Cue | Meaning | Action |
|-----|---------|--------|
| **next**, continue, go | Advance **one** step | Run the persisted `## Next` skill for that Task |
| **ship**, finish, close it out | Finish **remaining** through Done | Run [ship](../ship/SKILL.md) |

While a **pace** is open (**guidance** or **explanation**), yes / okay / move on
and similarly approving replies are **advance**, and problem reports are
**block** — they do not fire continue or ship. Explicit `/skill` and bare
**ship** still override.

Prefer an explicit key when present (`ship MD-5`). When both could apply, follow
the user’s word. Full Next table and persistence targets: [handoff.md](handoff.md).

## Artifacts

| Artifact | Owner | Role |
|----------|-------|------|
| `WORKSPACE.md` | setup | Tracker + path + delivery decisions |
| `ROADMAP.md` | explore | Map + route + **Next** |
| `PLAN.md` | define | Spec + Classification + Workflow binding + keys + **Next** |
| `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` | bug / tweak / refine / rework / iterate (manual override) | Spec + keys + **Next** |
| `RESEARCH.md` / `MODEL.md` | research / model | Finding docs on the delivery branch for define / implement (+ **Next**); never their own PR |
| `SANDBOX.md` + isolation tree | sandbox | Promotion input on the delivery branch for implement (+ **Next**); never its own PR |
| Branch + PR | Define / bug / tweak / refine / rework → ship | One delivery vehicle per Task (research/model may start the branch only) |
| Merge + Done | ship | Closed-loop closeout on that PR |

Paths follow WORKSPACE. Record path + commit SHA on the Task when location is
`repo`; push full content into the Task (no SHA) when `external`.

## Disclosed refs

| When | Read |
|------|------|
| Creating or reusing branch/PR | [delivery.md](delivery.md) |
| Writing **Next** / resolving entry context | [handoff.md](handoff.md) |
| Tracker create / transition / comment / close | [tracker-sync.md](tracker-sync.md) |
| `/ship` remaining tails or closeout | [ship.md](ship.md) |

Value-aware worker routing: [CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md)
(load before every `Task` spawn of any type, including `computerUse` and
`videoReview`). Catalog-closed — on Cursor, only Composer / Grok slugs from
[platforms/cursor.md](../concepts/platforms/cursor.md).
