# Review checklists

Paste the relevant section into each sub-agent brief. Axes investigate **vertically**
(deep within changed logic) and **horizontally** (across related modules and contracts).

Axes: **Spec**, **Correctness**, **Integration**, **Architecture**, **Standards**.

## Spec

### Vertical
- [ ] Each acceptance criterion / bug expected-result / tweak desired-change / refine preserve-behaviour bar / adopt preserve-behaviour gate / rework parity bar / PLAN Classification acceptance is implemented in the changed code
- [ ] Work-package / sub-task outcomes are actually delivered (not just TODOs/comments)
- [ ] Edge cases called out in PLAN/BUG/TWEAK/REFINE/REWORK/ADOPT are handled
- [ ] Wrong algorithm or behaviour relative to the written spec
- [ ] PLAN Workflow binding (if present) was followed for verify mode (tests / non-regression / comparative evidence)

### Horizontal
- [ ] Related surfaces updated: API, UI, docs, config, migrations, feature flags, metrics
- [ ] No scope creep beyond the issue (extra behaviour that should be a new Task)
- [ ] BUG fixes include regression protection called for in acceptance (test or equivalent)
- [ ] REFINE keeps executable behaviour unchanged; verification matches Preserve behaviour
- [ ] ADOPT keeps executable behaviour unchanged; Behaviour map rows stay locked (same tests, same expected results); working surfaces still start and mapped UI/API flows still complete
- [ ] REWORK meets the parity bar; PR/evidence shows baseline vs candidate comparison (not suite-green alone)
- [ ] MODEL/PLAN/BUG/TWEAK/REFINE/REWORK/ADOPT numeric or domain constraints reflected at all touchpoints

## Correctness

### Vertical (intra-path)
- [ ] Logic errors, off-by-one, inverted conditions, wrong operators
- [ ] Null / undefined / empty / NaN / missing key handling
- [ ] Error paths: exceptions caught or propagated correctly; no swallowed errors that hide failure
- [ ] Resource lifecycle: files, connections, locks, subscriptions opened/closed; no leaks
- [ ] Concurrency / async: races, double-submit, stale reads, missing await, cancellation
- [ ] Idempotency and retries where the domain requires them
- [ ] Numeric stability, units, timezones, encoding, locale assumptions
- [ ] Validation of untrusted or external input before use

### Horizontal (tests & contracts)
- [ ] New behaviour has tests; failure paths tested, not only happy path
- [ ] Existing tests updated when contracts change
- [ ] Tooling failures (lint/type/test) from the manager run are explained or fixed as findings
- [ ] Fixtures/factories match new schema or API shapes

## Integration

### Horizontal (cross-module) — primary
- [ ] Callers and callees of changed symbols still type/behave correctly
- [ ] Public API / schema / protobuf / OpenAPI / event payload compatibility
- [ ] Authn/authz: every sensitive path checks permission server-side
- [ ] Horizontal privilege: user A cannot access user B's resources by swapping IDs
- [ ] Vertical privilege: lower roles cannot reach admin/privileged operations
- [ ] Shared mutable state, caches, and singletons remain coherent
- [ ] Config / env / secrets: no new required knobs undocumented; no secrets in code/logs
- [ ] DB migrations / backward compatibility / rollout order
- [ ] Feature flags default-safe; removal paths considered
- [ ] Observability: important failures still log/metric/trace usefully

### Vertical (at each boundary)
- [ ] Assumptions at module boundaries documented by types or checks
- [ ] Error mapping across layers (domain → HTTP/RPC) preserves meaning
- [ ] Partial failure in multi-step flows does not corrupt state

## Architecture

Deep structural analysis of the change in context of the surrounding codebase.
Applies [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md) and
[STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md). Findings must cite
evidence (paths, layers, dependency edges) and propose a **concrete refactoring**
— not vague "consider cleaning this up."

Documented ADRs / architecture docs / dependency rules override generic advice.

**vs Integration:** runtime contracts and auth fit → Integration; structural fit and
refactorings → Architecture. **vs Standards:** local smells/naming → Standards;
module/layer/design-shape problems → Architecture.

### Vertical (intra-module structure)
- [ ] New/changed logic lives in the right layer or package (not UI→DB shortcuts, not domain depending on HTTP/framework types)
- [ ] Module cohesion: changed unit has one clear responsibility; change does not turn it into a god object/service/file
- [ ] Abstraction quality: interfaces/ports hide the right details; no leaky abstractions exposing persistence/transport internals
- [ ] Complexity growth: long methods/types/files made worse without an extract/split plan
- [ ] **CRAP** as a guide: nested conditionals above the target extracted; a flat switch/case over a closed set of types may stay
- [ ] Speculative frameworks or premature generalization introduced without a second real use
- [ ] Composition vs inheritance / indirection: new layers earn their keep

### Horizontal (system structure) — primary for this axis
- [ ] Dependency direction respects the repo's intended architecture (domain ← application ← adapters, package rules, …)
- [ ] No new or worsened import/package cycles across modules
- [ ] Boundaries: feature/package seams remain clear; change does not smear one concern across many packages (shotgun surgery)
- [ ] Divergent change: one module is not accumulating unrelated reasons to change
- [ ] Duplication vs false sharing: extract a shared module only when concepts truly align; otherwise keep separate
- [ ] Consistency with existing patterns (how similar features are structured in this repo)
- [ ] ADR / architecture-doc compliance for touched areas
- [ ] Data ownership and module APIs: who owns the model; are cross-module calls going through the right façade?
- [ ] Extension points: change hard-codes a one-off where the codebase already has a plugin/strategy/registry pattern (or vice versa)
- [ ] Testability structure: hard-wired collaborators that block isolating the unit without a redesign

### Refactoring outcomes (use in finding bodies)
When flagging, name a concrete move, for example:
- Extract module / package / type for a cohesive responsibility
- Move type or function to the correct layer
- Invert dependency (introduce port + adapter; depend on abstraction)
- Split god module along change-axes
- Extract nested conditionals that drive **CRAP** above the target; leave a justified switch/case
- Collapse needless indirection / speculative generality
- Introduce a façade to hide a message chain or unstable neighbor
- Align with an existing pattern already used for a sibling feature

Severity (**fix-biased**): introduced/worsened structural problem with a concrete
in-PR refactoring → `should-fix`; hard documented constraint breach → `blocker`;
optional adjacent cleanup the PR did not cause → `note`. When unsure between
`note` and `should-fix`, choose `should-fix`.

## Standards (smell baseline)

Repo docs override. Apply [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md).
**Fix-biased:** actionable named smells in **changed** code (clear rename /
extract / move) → `should-fix`. Documented convention breaches → `should-fix`
or `blocker`. Pure taste with no named smell and no repo-doc backing → `note`.
Skip tooling-enforced style.

### Vertical / horizontal for standards
- Vertical: naming, structure, **CRAP**, and clarity inside new functions
- Horizontal: consistency with neighbouring modules and established patterns in the repo
- [ ] **Dev-surface keys** — [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md)

When a smell is really a module/layer/dependency problem, prefer an **Architecture**
finding with a structural refactoring (usually `should-fix`) over a Standards note.

### Severity (all axes)

Follow [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md) fix-biased severity.
Actionable findings earn `should-fix` (or `blocker` when ship-critical).
