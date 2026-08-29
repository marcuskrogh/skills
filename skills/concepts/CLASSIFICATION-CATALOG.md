# Classification catalog

Disclosed from [CONCEPT_CLASSIFICATION](CONCEPT_CLASSIFICATION.md). Load when
classifying or binding a workflow.

## Classes (closed)

Apply **discriminators in order**; **first match wins**.

| Order | Class | Discriminator (all that apply) |
|------:|-------|--------------------------------|
| 1 | **bug** | Behaviour is wrong / regressing; fix is the work; expected correct behaviour is known or knowable |
| 2 | **rework** | Intentional **implementation** change (algorithm, control law, internal path) **and** measured outcomes must not degrade (parity bar needed or implied) |
| 3 | **refine** | Structure, naming, layering, comments, or docs only; **executable behaviour unchanged** |
| 4 | **tweak** | Small intentional behaviour delta; not a defect; too light for a full feature slice |
| 5 | **feature** | Buildable product/system slice that needs scope/behaviour/acceptance as a unit |
| 6 | **iterate** | Prior Task already **merged**; shipped work still wrong or incomplete (post-ship only); straightforward production fix — inspect-each-turn post-merge is sandbox |

If nothing matches cleanly → ask one discriminator question (usually: defect vs
intentional change vs structure-only vs measured swap).

## Templates

| Template | Intent | Default chain |
|----------|--------|---------------|
| **fix-fast** | Clear defect, contained blast radius | implement → test → review-fix → ship |
| **delta-fast** | Small intentional behaviour change | implement → test → review-fix → ship |
| **structure-safe** | Behaviour-preserving structural/docs work | implement → test → harden → review-fix → ship |
| **parity-iterative** | Impl swap with non-degradation bar | implement (comparative loop) → test → harden → review-fix → ship |
| **feature-standard** | Ordinary feature slice | implement → test → harden → review-fix → ship |
| **feature-heavy** | Cross-cutting / high-risk feature | implement (multiagent OK) → test → harden → review-fix (full sequential) → ship |

Optional prefix steps (only when bound): `/research`, `/model` before
implement — recorded in `side_paths`. Optional `/sandbox` before implement —
recorded in `sandbox` (`none` \| `inject`). Closeout after implement is
**test** → **harden** (when bound) → **review-fix** (lasers ending in
**code review**).

## Default binding (class → template)

| Class | Default template |
|-------|------------------|
| bug | fix-fast |
| tweak | delta-fast |
| refine | structure-safe |
| rework | parity-iterative |
| feature | feature-standard |
| iterate | fix-fast (on the **new** iterate Task) |

## Parameters

Every binding records these keys (use exactly these names):

| Param | Values | Meaning |
|-------|--------|---------|
| `implement.mode` | `single` \| `multiagent` | Manager-only packages vs delegated multiagent packages |
| `implement.verify` | `tests` \| `non-regression` \| `comparative` | Suite/acceptance; behaviour-unchanged checks; baseline vs candidate ([../implement/rework.md](../implement/rework.md)) |
| `implement.iteration` | `one-shot` \| `until-bar` | Stop after one verify vs reiterate until parity/acceptance bar |
| `test.mode` | `skip` \| `dedicated` | Skip the testing phase vs run `/test` after implement |
| `harden.mode` | `skip` \| `dedicated` | Skip the structure phase vs run `/harden` after test |
| `review.mode` | `single` \| `multiagent` | Focused worker set vs full multi-axis workers |
| `review.depth` | `focused` \| `full` | See [../review/depth.md](../review/depth.md) |
| `review.lasers` | `bundled` \| `sequential` | One worker set then code review vs axis lasers then code review ([../review/lasers.md](../review/lasers.md)) |
| `side_paths` | `none` \| `research` \| `model` \| `research+model` | Supportive passes before implement |
| `sandbox` | `none` \| `inject` | Isolated inspect-loop for a contained element before (or instead of jumping into) production implement |

### Default params by template

**Implement**

| Template | implement.mode | implement.verify | implement.iteration |
|----------|----------------|------------------|---------------------|
| fix-fast | single | tests | one-shot |
| delta-fast | single | tests | one-shot |
| structure-safe | single | non-regression | one-shot |
| parity-iterative | single | comparative | until-bar |
| feature-standard | single | tests | one-shot |
| feature-heavy | multiagent | tests | one-shot |

**Closeout**

| Template | test.mode | harden.mode | review.mode | review.depth | review.lasers |
|----------|-----------|-------------|-------------|--------------|---------------|
| fix-fast | dedicated | skip | single | focused | bundled |
| delta-fast | dedicated | skip | single | focused | bundled |
| structure-safe | dedicated | dedicated | single | focused | bundled |
| parity-iterative | dedicated | dedicated | single | focused | sequential |
| feature-standard | dedicated | dedicated | single | focused | sequential |
| feature-heavy | dedicated | dedicated | multiagent | full | sequential |

`side_paths` and `sandbox` default to `none` on every template.

### Override rules (apply after defaults; efficiency-first)

| When | Change |
|------|--------|
| Blast radius wide, new layers/modules, public API/schema/migration, authz, or ADR risk | `review.depth=full`, `review.mode=multiagent`, `review.lasers=sequential`, `harden.mode=dedicated`; feature → prefer **feature-heavy** |
| Localized one-concern diff, no new layers | keep `focused` / `single` / `bundled`; `harden.mode=skip` even on feature-standard |
| Purely non-behavioural docs/comments (no executable change) | `test.mode=skip` |
| Math/formulation unclear and blocks acceptance | `side_paths=model` (and/or research) before implement |
| Literature/evidence needed before locking approach | `side_paths=research` |
| Contained UI/UX slice or isolated method/perf comparison that needs inspect-each-turn before production wiring | `sandbox=inject` |
| Rework / comparative verify | force `implement.verify=comparative`, `implement.iteration=until-bar` |
| User asks for thorough/full review | `review.depth=full`, `review.mode=multiagent`, `review.lasers=sequential`, `harden.mode=dedicated` |
| User asks to skip multiagent / save tokens | prefer `single` + `focused` + `bundled` unless override risk rows apply |

**Cheapest binding that still covers risk wins.** Do not escalate to
feature-heavy or full multiagent review without a matching override row.

## Artifact sections (required on PLAN.md from define)

```markdown
## Classification
- Class: bug | tweak | refine | rework | feature | iterate
- Confidence: high | medium
- Why: <one line>

## Workflow
- Template: fix-fast | delta-fast | structure-safe | parity-iterative | feature-standard | feature-heavy
- Parameters:
  - implement.mode: single | multiagent
  - implement.verify: tests | non-regression | comparative
  - implement.iteration: one-shot | until-bar
  - test.mode: skip | dedicated
  - harden.mode: skip | dedicated
  - review.mode: single | multiagent
  - review.depth: focused | full
  - review.lasers: bundled | sequential
  - side_paths: none | research | model | research+model
  - sandbox: none | inject
- Chain: implement → test → harden → review-fix → ship
- Rationale: <one line efficiency + risk>
```

Adjust **Chain** when `side_paths` ≠ none (e.g. `research → implement → …`) or
`sandbox=inject` (e.g. `sandbox → implement → test → harden → review-fix → ship`).
Drop `test` when `test.mode=skip`; drop `harden` when `harden.mode=skip`. Prefix
order: side_paths, then sandbox, then implement.

## Legacy fallback

When the Task has no `## Workflow` section:

| Artifact | Treat as class | verify | test.mode | harden.mode | review.depth | review.lasers |
|----------|----------------|--------|-----------|-------------|--------------|---------------|
| `BUG.md` / `ITERATE.md` | bug / iterate | tests | dedicated | skip | focused | bundled |
| `TWEAK.md` | tweak | tests | dedicated | skip | focused | bundled |
| `REFINE.md` | refine | non-regression | dedicated | dedicated | focused | bundled |
| `REWORK.md` | rework | comparative | dedicated | dedicated | focused | sequential |
| `SANDBOX.md` without PLAN | feature / post-merge sandbox | measure kind → comparative; else tests | dedicated | dedicated | focused | sequential |
| `PLAN.md` without Classification | feature | tests | dedicated | dedicated | per [../review/depth.md](../review/depth.md) | sequential when full; else bundled |
