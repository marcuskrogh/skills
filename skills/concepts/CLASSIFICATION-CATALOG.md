# Classification catalog

Disclosed from [CONCEPT_CLASSIFICATION](CONCEPT_CLASSIFICATION.md). Load when
classifying or binding a workflow.

## Classes (closed)

Apply **discriminators in order**; **first match wins**.

| Order | Class | Discriminator (all that apply) |
|------:|-------|--------------------------------|
| 1 | **bug** | Behaviour is wrong / regressing; fix is the work; expected correct behaviour is known or knowable |
| 2 | **rework** | Intentional **implementation** change (algorithm, control law, internal path) **and** measured outcomes must not degrade (parity bar needed or implied) |
| 3 | **adopt** | Entire existing codebase (or the named tree) was **not built** to the structure bar; apply the catalog across it; **executable behaviour unchanged** |
| 4 | **refine** | **Bounded** area (module, class, slice, README); structure, naming, layering, comments, or docs only; **executable behaviour unchanged** |
| 5 | **tweak** | Small intentional behaviour delta; not a defect; too light for a full feature slice |
| 6 | **feature** | Buildable product/system slice that needs scope/behaviour/acceptance as a unit |
| 7 | **iterate** | Prior Task already **merged**; shipped work still wrong or incomplete (post-ship only); straightforward production fix — inspect-each-turn post-merge is sandbox |

If nothing matches cleanly → ask one discriminator question (usually: defect vs
intentional change vs whole-tree structure vs bounded structure-only vs measured
swap).

## Templates

| Template | Intent | Default chain |
|----------|--------|---------------|
| **fix-fast** | Clear defect, contained blast radius | implement → test → harden → review-fix → ship |
| **delta-fast** | Small intentional behaviour change | implement → test → harden → review-fix → ship |
| **structure-safe** | Behaviour-preserving structural/docs work | implement → test → harden → review-fix → ship |
| **parity-iterative** | Impl swap with non-degradation bar | implement (comparative loop) → test → harden → review-fix → ship |
| **feature-standard** | Ordinary feature slice | implement → test → harden → review-fix → ship |
| **feature-heavy** | Cross-cutting / high-risk feature | implement (multiagent OK) → test → harden → review-fix (full sequential) → ship |

Optional prefix steps (only when bound): `/research`, `/model` before
implement — recorded in `side_paths`. Optional `/sandbox` before implement —
recorded in `sandbox` (`none` \| `inject`). Closeout after implement is always
**test** → **harden** → **review-fix** (lasers ending in **code review**).
`test.mode=skip` / `harden.mode=skip` are explicit exceptions, not defaults.

## Default binding (class → template)

| Class | Default template |
|-------|------------------|
| bug | fix-fast |
| tweak | delta-fast |
| adopt | structure-safe |
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
| fix-fast | dedicated | dedicated | single | focused | sequential |
| delta-fast | dedicated | dedicated | single | focused | sequential |
| structure-safe | dedicated | dedicated | single | focused | sequential |
| parity-iterative | dedicated | dedicated | single | focused | sequential |
| feature-standard | dedicated | dedicated | single | focused | sequential |
| feature-heavy | dedicated | dedicated | multiagent | full | sequential |

`side_paths` and `sandbox` default to `none` on every template.

### Override rules (apply after defaults)

Structure and testing are the **floor**. Efficiency applies to `review.mode`,
`review.depth`, and `implement.mode` only.

| When | Change |
|------|--------|
| Blast radius wide, new layers/modules, public API/schema/migration, authz, or ADR risk | `review.depth=full`, `review.mode=multiagent`; feature → prefer **feature-heavy** |
| Localized one-concern diff, no new layers | keep `focused` / `single`; keep `test.mode=dedicated`, `harden.mode=dedicated`, `review.lasers=sequential` |
| Purely non-behavioural docs/comments (no executable change) | `test.mode=skip` only; **harden stays dedicated** |
| Math/formulation unclear and blocks acceptance | `side_paths=model` (and/or research) before implement |
| Literature/evidence needed before locking approach | `side_paths=research` |
| Contained UI/UX slice or isolated method/perf comparison that needs inspect-each-turn before production wiring | `sandbox=inject` |
| Rework / comparative verify | force `implement.verify=comparative`, `implement.iteration=until-bar` |
| User asks for thorough/full review | `review.depth=full`, `review.mode=multiagent` |
| User asks to skip multiagent / save tokens | prefer `single` + `focused`; **do not** skip test, harden, sequential lasers, or Architecture |
| User explicitly asks to skip test or harden | that phase only; record the skip on the binding |
| Class is **adopt** | Walk the route autonomously: inventory (delegated), then each area runs characterize → implement → test → harden → review-fix → ship, then the next area, until the route is Done. Characterize maps current observable behaviour **and every working surface** (startable backend, startable frontend, composed client-server path) and implements lock tests that fail if those surfaces stop working; structure work does not start until that baseline is green on current code. Force `implement.verify=non-regression` and `test.mode=dedicated`. Refuse `test.mode=skip` even if the user asked — proof is required. `implement.mode=multiagent` when the unit has more than one package or any Moderate/Demanding package. Do not wait for user Next between steps or areas. Do not ship or start the next area until the preserve-behaviour gate holds (lock suite **and** working surfaces). Hard stop on a composed skill's hard stop or a failed proof. Closeout params stay on **structure-safe** except `implement.mode` / forced verify+test as above |

**Cheapest review breadth that still covers risk wins.** Do not escalate to
feature-heavy or full multiagent review without a matching override row. Do not
drop test, harden, or the Architecture/Standards lasers to save tokens.

## Artifact sections (required on PLAN.md from define)

```markdown
## Classification
- Class: bug | tweak | adopt | refine | rework | feature | iterate
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
- Chain: implement → test → harden → review-fix → ship   # adopt: characterize → implement → test → harden → review-fix → ship per area
- Rationale: <one line efficiency + risk; test/harden are the floor>
```

Adjust **Chain** when `side_paths` ≠ none (e.g. `research → implement → …`) or
`sandbox=inject` (e.g. `sandbox → implement → test → harden → review-fix → ship`).
Class **adopt** is an orchestrator: inventory, then `characterize → implement → test → harden → review-fix → ship` per area until the route is Done.
Adopt does **not** drop characterize or `test` (proof is required). Drop `test` on other classes only when `test.mode=skip` (docs-only or explicit user ask). Drop
`harden` only when the user explicitly asked to skip it. Prefix order:
side_paths, then sandbox, then implement (or adopt's unit chain).

## Legacy fallback

When the Task has no `## Workflow` section:

| Artifact | Treat as class | verify | test.mode | harden.mode | review.depth | review.lasers |
|----------|----------------|--------|-----------|-------------|--------------|---------------|
| `BUG.md` / `ITERATE.md` | bug / iterate | tests | dedicated | dedicated | focused | sequential |
| `TWEAK.md` | tweak | tests | dedicated | dedicated | focused | sequential |
| `ADOPT.md` | adopt | non-regression | dedicated | dedicated | focused | sequential |
| `REFINE.md` | refine | non-regression | dedicated | dedicated | focused | sequential |
| `REWORK.md` | rework | comparative | dedicated | dedicated | focused | sequential |
| `SANDBOX.md` without PLAN | feature / post-merge sandbox | measure kind → comparative; else tests | dedicated | dedicated | focused | sequential |
| `PLAN.md` without Classification | feature | tests | dedicated | dedicated | per [../review/depth.md](../review/depth.md) | sequential |
