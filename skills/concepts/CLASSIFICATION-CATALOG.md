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
| **fix-fast** | Clear defect, contained blast radius | implement → review-fix → ship |
| **delta-fast** | Small intentional behaviour change | implement → review-fix → ship |
| **structure-safe** | Behaviour-preserving structural/docs work | implement → review-fix → ship |
| **parity-iterative** | Impl swap with non-degradation bar | implement (comparative loop) → review-fix → ship |
| **feature-standard** | Ordinary feature slice | implement → review-fix → ship |
| **feature-heavy** | Cross-cutting / high-risk feature | implement (multiagent OK) → review-fix (full) → ship |

Optional prefix steps (only when bound): `/research`, `/model` before
implement — recorded in `side_paths`. Optional `/sandbox` before implement —
recorded in `sandbox` (`none` \| `inject`).

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
| `review.mode` | `single` \| `multiagent` | Focused worker set vs full multi-axis workers |
| `review.depth` | `focused` \| `full` | See [../review/depth.md](../review/depth.md) |
| `side_paths` | `none` \| `research` \| `model` \| `research+model` | Supportive passes before implement |
| `sandbox` | `none` \| `inject` | Isolated inspect-loop for a contained element before (or instead of jumping into) production implement |

### Default params by template

| Template | implement.mode | implement.verify | implement.iteration | review.mode | review.depth | side_paths | sandbox |
|----------|----------------|------------------|---------------------|-------------|--------------|------------|---------|
| fix-fast | single | tests | one-shot | single | focused | none | none |
| delta-fast | single | tests | one-shot | single | focused | none | none |
| structure-safe | single | non-regression | one-shot | single | focused | none | none |
| parity-iterative | single | comparative | until-bar | single | focused | none | none |
| feature-standard | single | tests | one-shot | single | focused | none | none |
| feature-heavy | multiagent | tests | one-shot | multiagent | full | none | none |

### Override rules (apply after defaults; efficiency-first)

| When | Change |
|------|--------|
| Blast radius wide, new layers/modules, public API/schema/migration, authz, or ADR risk | `review.depth=full`, `review.mode=multiagent`; feature → prefer **feature-heavy** |
| Localized one-concern diff, no new layers | keep `focused` / `single` even on feature-standard |
| Math/formulation unclear and blocks acceptance | `side_paths=model` (and/or research) before implement |
| Literature/evidence needed before locking approach | `side_paths=research` |
| Contained UI/UX slice or isolated method/perf comparison that needs inspect-each-turn before production wiring | `sandbox=inject` |
| Rework / comparative verify | force `implement.verify=comparative`, `implement.iteration=until-bar` |
| User asks for thorough/full review | `review.depth=full`, `review.mode=multiagent` |
| User asks to skip multiagent / save tokens | prefer `single` + `focused` unless override risk rows apply |

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
  - review.mode: single | multiagent
  - review.depth: focused | full
  - side_paths: none | research | model | research+model
  - sandbox: none | inject
- Chain: implement → review-fix → ship
- Rationale: <one line efficiency + risk>
```

Adjust **Chain** when `side_paths` ≠ none (e.g. `research → implement → …`) or
`sandbox=inject` (e.g. `sandbox → implement → review-fix → ship`). Prefix
order: side_paths, then sandbox, then implement.

## Legacy fallback

When the Task has no `## Workflow` section:

| Artifact | Treat as class | verify | review.depth |
|----------|----------------|--------|--------------|
| `BUG.md` / `ITERATE.md` | bug / iterate | tests | focused |
| `TWEAK.md` | tweak | tests | focused |
| `REFINE.md` | refine | non-regression | focused |
| `REWORK.md` | rework | comparative | focused |
| `PLAN.md` without Classification | feature | tests | per [../review/depth.md](../review/depth.md) |
