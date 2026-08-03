---
name: review
description: >-
  Thorough multi-axis GitHub PR review (Spec, Correctness, Integration,
  Architecture, Standards) with vertical and horizontal investigation. Scores
  each axis for difficulty and defaults investigators to the platform
  low-capability tier (elevates to high-capability only when Demanding); manager
  stays high-capability. Tied to a pipeline issue in In Review; posts findings on
  the PR and tracker; hands off to review-fix or ship.
---

# Review

Applies [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md) as a deep review posted
**on the GitHub pull request** and summarized on the **pipeline issue** (tracker
from WORKSPACE) — not as repo files or long chat transcripts.

**On invoke:** read [../concepts/CONCEPT_REVIEW.md](../concepts/CONCEPT_REVIEW.md),
[../concepts/CONCEPT_DELEGATION.md](../concepts/CONCEPT_DELEGATION.md),
[../workflow/reference.md](../workflow/reference.md), [checklist.md](checklist.md),
and [../tracker/SKILL.md](../tracker/SKILL.md).

Requires authenticated `gh` and tracker auth per WORKSPACE. If either is missing,
stop and tell the user.

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Change source** | GitHub PR linked to the pipeline Task (or current branch) |
| **Spec source** | Tracker issue + `PLAN.md` / `BUG.md` / `ITERATE.md` / `MODEL.md` |
| **Publish target** | GitHub PR review via `gh api` + tracker comment |
| **Checklist** | [checklist.md](checklist.md) — paste into each sub-agent brief |
| **Model routing** | [CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) — per-axis difficulty; default low-capability; elevate high-capability only for Demanding signals |

## Axes (this skill)

Five axes run as **parallel sub-agents**. Each axis investigates both **vertically**
and **horizontally** per CONCEPT_REVIEW:

| Axis | Focus |
|------|--------|
| **Spec** | Does the change fulfill `PLAN.md` / `BUG.md` / `ITERATE.md` / the tracker issue — no missing or wrong behaviour? |
| **Correctness** | Will it work under real inputs and failures — logic, edges, errors, races, tests? |
| **Integration** | Does it fit the rest of the system — callers, contracts, auth, data flow, config? |
| **Architecture** | Does it fit and improve system structure — layers, module boundaries, coupling, dependency direction, and concrete refactorings? |
| **Standards** | Repo conventions + smell baseline (judgement calls; repo docs win). |

## Process

### 0. Resolve the pipeline issue

1. User provides key or URL (e.g. `/review MD-2`).
2. If missing, ask: "Which issue is in review?"
3. `fetch` via the tracker backend.
4. Confirm status is **In Review** (or equivalent). If not, stop and tell the user to transition first.
5. Capture: key, URL, summary, description, sub-tasks, links, artifact paths (`PLAN.md`, `BUG.md`, `ITERATE.md`, `MODEL.md`).

The tracker issue (+ linked PLAN/BUG/ITERATE) is the **primary spec source**.

### 1. Resolve the pull request

Order: issue-linked PR → user-named PR → current branch PR → create draft PR if commits exist.

Confirm non-empty diff. Capture:

- PR number, URL, base branch, head SHA
- Full `gh pr diff` (or `git diff origin/<base>...HEAD` if too large)
- Commit list: `gh pr view <n> --json commits`

### 2. Build investigation context (mandatory — do not skip)

Sub-agents must not review hunks in isolation. The manager prepares:

1. **Changed paths** — `gh pr diff <n> --name-only`.
2. **Full file snapshots** for each changed source file at `HEAD` (cap: skip generated/vendor/minified; for huge files, provide ±100 lines around each hunk plus signatures/imports).
3. **Neighbor map** — for each changed symbol/module, list likely callers/callees/tests (ripgrep for symbol names, same-package imports, `*_test.*` / `__tests__` / neighbouring files). Include those file excerpts when they clarify contracts.
4. **Spec pack** — issue body, sub-tasks, `PLAN.md` / `BUG.md` / `ITERATE.md` / `MODEL.md` as applicable.
5. **Architecture pack** — ADRs (`docs/adr`, `adr/`, `ARCHITECTURE.md`, …), architecture/README sections, package/module tree for touched areas, dependency or layering rules (`dependency-cruiser`, `archunit`, `eslint-plugin-boundaries`, module boundaries docs) if present. Sketch the intended layers/packages around the change.
6. **Standards pack** — `CODING_STANDARDS.md`, `CONTRIBUTING.md`, linters config names if present.
7. **Evidence from tooling** (when cheap and available in-repo): run the project's usual lint/typecheck/test for the touched area (or full suite if that is the norm). Capture failing command output as **Correctness** inputs — do not invent CI results.

Pass this context into every sub-agent brief. Architecture needs the architecture pack plus the neighbor map and package tree — not hunks alone.

### 3. Identify axes sources

**Spec:** tracker issue → PR body → commit refs → PLAN/BUG/ITERATE/MODEL → user path.

**Standards:** repo docs + smell baseline in [checklist.md](checklist.md#standards-smell-baseline). Repo docs override smells; skip tooling-enforced nits.

**Architecture:** architecture pack + Architecture checklist in [checklist.md](checklist.md#architecture). Documented ADRs / layering rules override generic advice.

**Correctness / Integration:** checklists in [checklist.md](checklist.md).

### 4. Spawn five sub-agents in parallel

Score **each axis** with [CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md)
before spawning. **Manager** (context pack, merge, severity promotion, publish)
stays on the parent / high-capability model. Workers default to the platform’s
top available **low-capability** model; elevate an axis only when that axis has
a Demanding signal (or when re-running an insufficient value-tier pass).

| Axis | Default category | Elevate to high-capability when |
|------|------------------|---------------------------------|
| **Spec** | Low-capability | Large/ambiguous PLAN with many interdependent packages; conflicting acceptance |
| **Correctness** | Low-capability | Concurrency/races, security, subtle algorithms, unexplained tooling failures |
| **Integration** | Low-capability | Authz, migrations, public API/schema breaks, multi-service contracts |
| **Architecture** | Low-capability | New layers/modules, dependency cycles, ADR conflicts, large structural shift |
| **Standards** | Low-capability | Almost never — elevate only after a failed value-tier standards pass |

Bias: when unsure, keep low-capability. Axes in the same batch may use different
models. Pick concrete slugs from the platform catalog (or General).

One message, five `Task` calls (`subagent_type: "generalPurpose"`, each with its
assigned `model` when the harness supports it).

Each returns **structured findings only**:

```text
axis: Spec | Correctness | Integration | Architecture | Standards
severity: blocker | should-fix | note
kind: inline | general
path: <repo-relative>     # inline
line: <RIGHT-side line>   # inline
vertical_or_horizontal: vertical | horizontal
body: <markdown: problem → evidence → suggested fix; prefix with **Axis**>
```

Use CONCEPT_REVIEW **fix-biased** severity meanings. **Budgets:** max **20** findings
per axis, **≤800 words** per axis. Prefer **accurate severity** over a soft review —
do not demote actionable findings to `note` to avoid `REQUEST_CHANGES`. If the cap
binds, drop weakest-evidence / lowest-value items first, not severity. Every finding
needs **evidence** and a **concrete fix hint**.

**Default elevation:** actionable findings (evidence + concrete in-PR fix + in blast
radius) → `should-fix` or `blocker`. Reserve `note` for optional polish, out-of-scope
follow-ups, or speculative cleanup outside the change's blast radius.

For **Architecture**, bodies must name the structural problem, cite evidence
(paths, dependency edges, layer violations), and propose a **concrete refactoring**
(extract module, invert dependency, split package, introduce port/adapter, move
type to domain layer, collapse leaky abstraction, …) — not vague "consider
refactoring."

#### Spec sub-agent

Include: context pack + Spec checklist from [checklist.md](checklist.md#spec).

Brief: Trace **each** acceptance criterion / work package / bug repro expectation through the diff and neighbors. Vertical: is this requirement fully implemented inside the changed paths? Horizontal: are related UI/API/docs/migrations/flags updated? Flag missing, partial, wrong, or scope-creep behaviour. Quote the spec line in `body`. Severity: missing/wrong required behaviour → `blocker`; incomplete related surfaces or partial delivery → `should-fix`; optional extras beyond the issue → `note`.

#### Correctness sub-agent

Include: context pack + Correctness checklist + any tooling failures.

Brief: Vertical deep-dive into changed functions/paths — logic bugs, edges, error handling, null/empty, off-by-one, resource lifecycle, concurrency, idempotency. Horizontal: do tests cover new behaviour and failure paths; do existing tests still match contracts? Prefer `blocker`/`should-fix` for real failure modes. Missing or outdated tests for new behaviour → `should-fix` (not `note`). Unexplained tooling failures from the manager run → `blocker`. Micro-optimizations with no correctness impact → `note`.

#### Integration sub-agent

Include: context pack + Integration checklist + neighbor map.

Brief: Horizontal first — call graph, API/schema compatibility, authz (vertical *and* horizontal privilege), shared state, config/env, feature flags, data migrations, event contracts, error propagation across boundaries. Vertical: at each boundary crossed by the change, validate assumptions. Read neighbor files; do not stop at the hunk. Do **not** turn this into a redesign review — that is Architecture. Severity: contract/auth/compat/migration hazards → `blocker` or `should-fix`; undocumented required config/secrets risks → `should-fix`; nice-to-have observability with no failure risk → `note`.

#### Architecture sub-agent

Include: context pack + Architecture checklist + architecture pack + neighbor map + package/module tree around changed paths.

Brief: Deep structural analysis of how the change sits in the codebase.

**Vertical:** Inside changed modules — cohesion, responsibility creep, wrong-layer logic (UI talking to DB, domain depending on framework details), god types/functions growing further, abstraction leaks, premature or speculative frameworks.

**Horizontal:** Across packages/layers — dependency direction and cycles introduced or worsened, shotgun surgery patterns (one concern scattered), divergent change (one module serving unrelated reasons), missing or eroded boundaries, duplication that should be a shared module vs false sharing that should stay separate, consistency with existing architectural patterns and ADRs.

**Refactorings:** For each finding, propose a specific structural move grounded in this repo (not a textbook lecture). Prefer improvements the PR could make now. Severity (**fix-biased**): structural problems this PR **introduced or worsened**, with a concrete in-PR refactoring → `should-fix`; hard ADR / documented layering breach → `blocker`; optional adjacent redesign the PR did not cause → `note`. When unsure between `note` and `should-fix`, choose `should-fix`.

Do not restate Integration contract breaks or Standards naming/duplication smells unless they are symptoms of a larger structural problem — then frame them as Architecture with the structural fix.

#### Standards sub-agent

Include: standards pack + smell baseline.

Brief: Documented standard breaches (`blocker` / `should-fix`) and baseline smells. **Actionable named smells in changed code** (clear rename / extract / move) → `should-fix`, not `note`. Name the smell. Repo overrides baseline. Skip tooling-enforced style. Leave structural redesign to Architecture; Standards owns local clarity and documented conventions. Pure taste without a named smell or repo-doc backing → `note`.

If the spec pack is empty, skip Spec but still run the other four; ask the user once if everything is empty of intent.

### 5. Publish on the PR

Do **not** write review output into the repo or paste the full review in chat.

#### 5a. Build the review

1. Merge findings; keep axes separate — do not drop an axis because another is clean.
2. Deduplicate near-identical findings (keep the higher severity / better evidence). Prefer Architecture over Standards when both describe the same structural issue; prefer Integration when the issue is a runtime contract break.
3. Inline comments for `kind: inline` at RIGHT-side lines on `headRefOid`.
4. Review body:

```markdown
## Summary
- Blockers: <n> | Should-fix: <n> | Notes: <n>
- Vertical themes: <one line>
- Horizontal themes: <one line>
- Architecture themes: <one line>
- Worst: <one line or "none">

## Spec
…

## Correctness
…

## Integration
…

## Architecture
…

## Standards
…
```

Under each axis: general findings (or "None."), then counts by severity.

5. Review event:
   - `REQUEST_CHANGES` — any `blocker` or `should-fix` (expect this often under fix-biased severity)
   - `COMMENT` — only non-actionable `note`s, or no findings
   - `APPROVE` — zero findings on all axes (rare)

After merge, before submit: scan for actionable findings labeled `note`. If they meet
CONCEPT_REVIEW's actionable test, **promote** them to `should-fix` (manager duty —
do not leave fix-worthy items as soft notes).

#### 5b. Submit via gh

One PR review via `gh api` (same pattern as before: `commit_id`, `event`, `body`, `comments[]`). Build JSON in the shell; never commit it. Unanchorable inlines → PR conversation comment with axis prefix.

#### 5c. Tracker + mirror

Comment on the pipeline issue:

```markdown
## Code review posted
PR: <url>
Review event: …
Blockers: <n> | Should-fix: <n> | Notes: <n>
Spec / Correctness / Integration / Architecture / Standards: <counts>
Worst: …

## Next
<handoff>
```

Keep Task **In Review**. Upsert ISSUES mirror. Do not mark Done or close Sub-tasks.

#### 5d. Tell the user

Only: issue key/URL, PR URL, one-line counts + event, **Next**. No full review dump.

## Handoff

| Outcome | Next |
|---------|------|
| Any `blocker` or `should-fix` | `/review-fix <KEY>` (preferred) or `/implement <KEY>` fix-forward |
| Only actionable `note`s | `/review-fix <KEY>` (preferred) — review-fix still fixes actionable notes |
| Only non-actionable `note`s or zero findings | `/ship <KEY>` |

```markdown
## Next
`/review-fix <KEY>` — Auto-fix blockers, should-fix, and actionable notes; re-review
```

or

```markdown
## Next
`/ship <KEY>` — Merge PR and close the Task
```