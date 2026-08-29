# Review — axis investigator briefs

Disclosed reference for [review](SKILL.md) under **depth** `full` (one worker per
axis). For `focused` bundling, use [depth.md](depth.md#focused-briefs). Paste the
matching brief into each axis `Task` along with the manager's context pack and
[checklist.md](checklist.md) section. Severity is **fix-biased** per
[CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md).

Each worker returns structured findings only:

```text
axis: Spec | Correctness | Integration | Architecture | Standards
severity: blocker | should-fix | note
kind: inline | general
path: <repo-relative>     # inline
line: <RIGHT-side line>   # inline
vertical_or_horizontal: vertical | horizontal
body: <markdown: problem → evidence → suggested fix; prefix with **Axis**>
```

**Budgets:** max **20** findings per axis, **≤800 words** per axis. Prefer accurate
severity over a soft review — do not demote actionable findings to `note`. If the
cap binds, drop weakest-evidence items first. Every finding needs evidence and a
concrete fix hint. Actionable → `should-fix` or `blocker`; reserve `note` for
optional polish, out-of-scope follow-ups, or speculative cleanup outside blast radius.

## Spec

Include: context pack + Spec checklist from [checklist.md](checklist.md#spec).

Trace **each** acceptance criterion / work package / bug repro expectation /
tweak desired-change / refine preserve-behaviour / rework parity bar through
the diff and neighbors. Vertical: is this requirement fully implemented inside the
changed paths? Horizontal: are related UI/API/docs/migrations/flags updated? Flag
missing, partial, wrong, or scope-creep behaviour. Quote the spec line in `body`.
Missing/wrong required behaviour → `blocker`; incomplete related surfaces →
`should-fix`; optional extras beyond the issue → `note`. For REWORK, missing
baseline-vs-candidate evidence against the parity bar → `blocker`.

## Correctness

Include: context pack + Correctness checklist + any tooling failures.

Vertical deep-dive — logic bugs, edges, error handling, null/empty, off-by-one,
resource lifecycle, concurrency, idempotency. Horizontal: tests cover new behaviour
and failure paths; existing tests still match contracts? Prefer `blocker`/`should-fix`
for real failure modes. Missing/outdated tests for new behaviour → `should-fix`.
The dedicated **testing phase** having run is **not** a reason to skip coverage
findings. Unexplained tooling failures from the manager run → `blocker`. Micro-optimizations
with no correctness impact → `note`.

## Integration

Include: context pack + Integration checklist + neighbor map.

Horizontal first — call graph, API/schema compatibility, authz, shared state,
config/env, feature flags, migrations, event contracts, error propagation. Vertical:
at each boundary the change crosses, validate assumptions. Read neighbor files.
Do **not** turn this into a redesign review (that is Architecture). Contract/auth/
compat/migration hazards → `blocker` or `should-fix`; undocumented required
config/secrets risks → `should-fix`; nice-to-have observability with no failure
risk → `note`.

## Architecture

Include: context pack + Architecture checklist + architecture pack + neighbor map
+ package/module tree around changed paths + [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md).

**Vertical:** cohesion, responsibility creep, wrong-layer logic, god types growing,
abstraction leaks, premature frameworks, **CRAP** at or above 8 on changed functions.

**Horizontal:** dependency direction/cycles introduced or worsened, shotgun surgery,
divergent change, eroded boundaries, duplication vs false sharing, consistency with
ADRs/patterns.

For each finding: name the structural problem, cite evidence (paths, edges, layer
violations), propose a **concrete refactoring** grounded in this repo. Structural
problems this PR introduced/worsened with an in-PR refactoring → `should-fix`; hard
ADR/layering breach → `blocker`; optional adjacent redesign the PR did not cause →
`note`. When unsure between `note` and `should-fix`, choose `should-fix`.

Do not restate Integration contract breaks or Standards smells unless they are
symptoms of a larger structural problem — then frame as Architecture with the
structural fix.

## Standards

Include: standards pack + [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md).

Documented standard breaches → `blocker` / `should-fix`. Actionable named smells in
changed code (clear rename/extract/move) → `should-fix`. Name the smell. **CRAP**
at or above 8 on a changed function (or above the repo threshold) → `should-fix`.
Repo overrides catalog. Skip tooling-enforced style. Leave structural redesign to
Architecture. Pure taste without named smell or repo-doc backing → `note`.
Harden having already run is **not** a reason to demote a remaining smell.
