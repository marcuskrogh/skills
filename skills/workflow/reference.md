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
- **One open delivery branch + PR** per **delivery** Task from the first
  repo-writing skill through ship.
- **First writer starts** the branch/PR on a delivery Task (research / model /
  define / bug / tweak / refine / rework when committing); later skills **reuse**
  the recorded head.
- **Explore** charts the map; it does not open a map-only PR. Prefer one
  define-typed delivery Task for research/model/define that share a build;
  supportive-only route Tasks leave no hanging PR ([delivery.md](delivery.md#charting-vs-delivery)).
- **Iterate** (post-merge only) opens a **new** Task + branch + PR.

Lookup, reuse, and first-writer rules: [delivery.md](delivery.md).

## Stage ownership

| Skill | Entry | Produces | Default Next |
|-------|-------|----------|--------------|
| **explore** | Foggy initiative | `ROADMAP.md` + Story + typed route Tasks | Frontier skill by Order |
| **bug** | Defect; fix is the work | `BUG.md` + Task + delivery branch/PR | `/implement` |
| **tweak** | Small intentional change to existing behaviour | `TWEAK.md` + Task + delivery branch/PR | `/implement` |
| **refine** | Bounded structural/descriptive improvement; behaviour unchanged | `REFINE.md` + Task + delivery branch/PR | `/implement` |
| **rework** | Intentional implementation change; no measured degradation | `REWORK.md` + Task + delivery branch/PR | `/implement` (comparative) |
| **research** | Multi-axis question | `RESEARCH.md` (supportive) + continuity; no hanging supportive-only PR | `/model` or `/define` |
| **model** | Math alignment with user | `MODEL.md` + continuity; no hanging supportive-only PR | `/define` |
| **define** | Route or standalone Task (front door for concrete work) | `PLAN.md` + Classification + Workflow binding + Sub-tasks + branch/PR | First skill in bound Chain (usually `/implement`) |
| **implement** | PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE ready | Code on **same** PR; Task → In Review | `/review-fix` |
| **iterate** | Shipped work still wrong | `ITERATE.md` + **new** Task/PR; In Review | `/review-fix` |
| **review** | Task In Review | Findings on the **same** PR | `/review-fix` or `/ship` |
| **review-fix** | Task In Review | One review → fix-forward → CLEAN | `/ship` |
| **ship** | After ready-to-build | Remaining work + merge + Done | Done (or `/iterate`) |
| **summarise** | Anytime | Status only (About / Stage / Next) | *(reports; does not advance)* |

Side paths **research** / **model** enrich the **same** Task; they do not replace
user answers in **define**.

## Continuation keywords

Bare (or near-bare) cues resolve the active Task the same way
[summarise](../summarise/SKILL.md) does (explicit key → active ISSUES row → ask once).

| Cue | Meaning | Action |
|-----|---------|--------|
| **next**, continue, go | Advance **one** step | Run the persisted `## Next` skill for that Task |
| **ship**, finish, close it out | Finish **remaining** through Done | Run [ship](../ship/SKILL.md) |

Prefer an explicit key when present (`ship MD-5`). When both could apply, follow
the user’s word. Full Next table and persistence targets: [handoff.md](handoff.md).

## Artifacts

| Artifact | Owner | Role |
|----------|-------|------|
| `WORKSPACE.md` | setup | Tracker + path + delivery decisions |
| `ROADMAP.md` | explore | Map + route + **Next** |
| `PLAN.md` | define | Spec + Classification + Workflow binding + keys + **Next** |
| `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` | bug / tweak / refine / rework / iterate (manual override) | Spec + keys + **Next** |
| `RESEARCH.md` / `MODEL.md` | research / model | Supportive / math alignment + **Next** |
| Branch + PR | First writer → ship | One delivery vehicle per Task |
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
(load only when spawning workers). Catalog-closed — on Cursor, only Composer /
Grok slugs from [platforms/cursor.md](../concepts/platforms/cursor.md).
