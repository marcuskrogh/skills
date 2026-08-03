# Concept: Review

**Uninvokable concept.** Skills that need this behaviour must instruct the agent to
read this file on invoke. Do not surface this concept unless a skill references it.

## Purpose

Evaluate a change set against an agreed specification and the surrounding system
using **multiple axes** and **two investigation directions**, producing actionable
findings with evidence — not a vague opinion dump.

Skills specialise where findings are posted (e.g. GitHub PR), how the change set is
resolved, and tracker handoffs.

## What this is not

- Not a user-invokable workflow by itself
- Not implementation or fix-forward (those use implementation concepts/skills)
- Not a substitute for a missing specification — call out empty intent
- Not a full paste of findings into chat when a durable review surface exists
- Not a free-floating redesign proposal — Architecture findings must be tied to the
  change set and nearby structure, with concrete refactorings

## Axes

Every applicable axis must investigate both **vertically** (deep within a change)
and **horizontally** (across related code and contracts):

| Axis | Focus |
|------|--------|
| **Spec** | Does the change fulfill the agreed spec — no missing or wrong behaviour? |
| **Correctness** | Will it work under real inputs and failures — logic, edges, errors, races, tests? |
| **Integration** | Does it fit the rest of the system — callers, contracts, auth, data flow, config? |
| **Architecture** | Does the change fit and improve the system's structure — layers, boundaries, coupling, dependency direction, and concrete refactorings? |
| **Standards** | Repo conventions + smell baseline (judgement calls; repo docs win). |

A change can look fine on one cut and fail on another:

- Spec-correct but crashes on empty input → **Correctness**
- Locally correct but breaks callers / auth → **Integration**
- Works and integrates but puts logic in the wrong layer or deepens a god module → **Architecture**
- Works and integrates but ignores repo standards / local smells → **Standards**
- Clean code that solves the wrong problem → **Spec**

**Architecture vs Integration vs Standards**

| Cut | Question |
|-----|----------|
| **Integration** | Will this break contracts, callers, auth, or runtime data flow? |
| **Architecture** | Is the *structure* sound — right boundaries, dependency direction, cohesion — and what refactorings would improve it? |
| **Standards** | Does local style match repo docs and the smell baseline (naming, duplication, envy, …)? |

Architecture findings must be **grounded in the change and nearby structure** — not a free-floating redesign of the whole codebase. Prefer concrete refactorings (extract module, invert dependency, split package, introduce a port/adapter, collapse a leaky abstraction) with evidence from the neighbor map and architecture pack.

**Severity guidance for Architecture (fix-biased):** if this PR **introduces or
worsens** a structural problem and a **concrete in-PR refactoring** exists (wrong
layer, new/worsened cycle, boundary leak, cohesion damage, shotgun surgery), use
`should-fix`. Hard documented constraints (ADR / architecture doc / dependency
rules) → `blocker`. Reserve `note` only for optional adjacent improvements **outside**
the change's blast radius or speculative cleanups the PR did not cause.

**Vertical** catches bugs and design faults inside a path; **horizontal** catches
breaks and structural drift across the system. Both are required on every axis
that applies.

## Extension contract

Skills that apply this concept **must** define:

| Extension | Purpose |
|-----------|---------|
| **Change source** | How to obtain the diff / commits under review |
| **Spec source** | Where acceptance criteria live (issue, PLAN, BUG, …) |
| **Publish target** | Where findings are posted (PR review, chat, …) |
| **Checklist** | Axis checklists to paste into investigator briefs |

Skills **may** define:

| Extension | Purpose |
|-----------|---------|
| **Parallelism** | Sub-agent mapping (e.g. one agent per axis) |
| **Model routing** | Per-axis defaults for [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md) (must stay value-biased: low/mid before high) |
| **Severity model** | blocker / should-fix / note and ship impact |
| **Tooling evidence** | Whether to run lint/type/test and feed failures in |
| **Handoff** | Next skill when blocking vs clean |

## Model routing (mandatory when using investigator sub-agents)

Apply [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md) before spawning axis workers:

- **Manager** builds context, merges findings, promotes severity, publishes the
  review, and owns tracker handoff — stays on the parent / high-capability model.
- **Each axis worker** maps Routine → **low**, Moderate → **mid**, Demanding →
  **high**. Elevate an axis to **high-capability** only when that axis has a
  Demanding signal (e.g. concurrency / security for Correctness;
  auth/migration/public API for Integration; new layers / ADR conflict / cycles
  for Architecture), or when climbing the ladder after an insufficient lower-tier
  pass.
- Axes in one parallel batch may use **different** models. Bias remains:
  prefer the lower adequate tier when unsure. Use the platform catalog (or General).

## Severity (fix-biased default model)

**Bias:** when choosing between `note` and `should-fix`, prefer **`should-fix`** if
the finding is evidenced, actionable in this change set (or immediate neighbors),
and has a concrete fix hint. Do **not** demote actionable findings to `note` to keep
the review soft or to avoid `REQUEST_CHANGES`.

| Level | Meaning | Ship / fix-loop impact |
|-------|---------|------------------------|
| `blocker` | Wrong/missing required behaviour, likely prod bug, security hole, broken tooling proof, hard standard / ADR / layering breach, missing acceptance-critical behaviour | Must fix before ship; always blocking for fix loops |
| `should-fix` | Clear defect or gap that should not ship: logic/edge bugs, missing tests for new behaviour, incomplete horizontal updates, auth/contract risks, documented convention breaches, **actionable** smells in changed code, structural problems this PR introduced or worsened with a concrete in-PR refactoring | Treat as blocking for fix loops; triggers `REQUEST_CHANGES` |
| `note` | Truly optional polish, preference without a clear defect, out-of-scope follow-up, or speculative cleanup **outside** the PR blast radius | Soft for plain `/review` → ship; **still must-fix when actionable** under `/review-fix` |

### What counts as actionable (for elevation and fix loops)

A finding is **actionable** when **all** of the following hold:

1. Evidence cites the change or an immediate neighbor / caller / test
2. Body names a **concrete fix** (not "consider improving")
3. The fix fits this PR's scope (touched paths + necessary neighbors) — not a
   multi-week redesign

Actionable findings default to **`should-fix`** (or `blocker` if ship-critical).
Use `note` only when the item fails the actionable test **or** is explicitly
deferred as out-of-scope follow-up.

### Axis calibration shortcuts

| Axis | Prefer `should-fix` / `blocker` for | Prefer `note` only for |
|------|--------------------------------------|-------------------------|
| **Spec** | Missing, partial, wrong acceptance behaviour; incomplete related surfaces called for by the plan | Clarifying questions; optional extras beyond the issue |
| **Correctness** | Real failure modes, bad error handling, races, missing/outdated tests for new behaviour, unexplained tooling failures | Micro-optimizations with no correctness impact |
| **Integration** | Caller/contract/auth/config/migration/flag hazards | Nice-to-have observability polish with no failure risk |
| **Architecture** | Introduced/worsened wrong-layer, cycles, boundary leaks, god-module growth with a concrete refactoring | Adjacent redesign the PR did not cause |
| **Standards** | Named smells in changed code with a clear rename/extract/move; documented convention breaches | Pure taste not backed by repo docs or a named smell |

## Investigation context (mandatory)

Do not review hunks in isolation. Before axis work, prepare:

1. **Changed paths**
2. **Full file snapshots** (or ±context around hunks for huge/generated files)
3. **Neighbor map** — likely callers/callees/tests for changed symbols
4. **Spec pack** — issue body, acceptance, plan/bug/model as applicable
5. **Architecture pack** — ADRs, architecture/docs folders, README architecture sections, package/module map of touched areas, dependency or layering rules if present
6. **Standards pack** — repo docs + smell baseline
7. **Tooling evidence** when cheap and available in-repo

Pass this context into every investigator brief. Architecture investigators need the
architecture pack and a slightly wider structural view (package tree / module
boundaries around changed paths), not only the hunks.

## Finding shape

Each finding should be structured enough for fix-forward:

- Axis name
- Severity
- Inline vs general
- Path / line when inline
- Vertical or horizontal
- Body: problem → evidence → suggested fix

**Budgets (defaults):** cap volume per axis; require evidence and a concrete fix
hint. Prefer **accurate severity** over a soft review — do not collapse actionable
items into `note` to stay under budget; drop lowest-value / weakest-evidence items
first if the cap binds.

## Process (conceptual)

1. Resolve the subject under review and confirm it is ready for review.
2. Resolve the change set; confirm a non-empty diff.
3. Build investigation context.
4. Score difficulty per axis → assign worker models (CONCEPT_DELEGATION; bias low/mid before high).
5. Run all applicable axes (prefer parallel investigators with explicit `model` when supported).
6. Merge, deduplicate, keep axes separate in the published review (manager duty).
7. Publish to the skill's target; summarise counts to the user — not the full dump.
8. Hand off: fix loop if blocking / actionable findings remain; ship path only when
   clean (or plain `/review` with non-actionable notes only).

## Anti-patterns

- Reviewing hunks without neighbors or spec
- Collapsing all axes into one undifferentiated list
- **Demoting** actionable findings to `note` so the PR looks ship-ready
- Many soft notes that should have been `should-fix` / `blocker`
- Inventing CI results
- Dumping the full review into chat when a PR (or other durable surface) is the publish target
- Approving when blockers or should-fix remain
- Architecture as vague "consider refactoring" without naming the structure problem,
  evidence, and a concrete refactoring
- Mixing Integration (runtime fit) with Architecture (structural fit) or Standards
  (local smells) into one undifferentiated pile
- Leaving actionable inline notes unfixed in `/review-fix` because they were labeled `note`
- Running all five axis workers on high-capability by default (violates CONCEPT_DELEGATION)
- Skipping per-axis difficulty scoring when investigators are sub-agents
- Ignoring the platform catalog and always using one fixed brand pair

## Authoring skills that use this concept

1. Instruct the agent to **read this file** on invoke.
2. Also require [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md) when the skill spawns
   investigators.
3. Fill in the **extension contract**.
4. Link: `[CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md)`.
