# Concept: Classification

Infer a closed **class** for the work and bind an efficient **workflow**
template so later skills execute without re-guessing. Uninvokable — load only
when a skill's On-invoke pointer fires.

## Intent

After (or with) lightweight definition alignment, turn the agreed description
into a **deterministic** class + workflow **binding**. Downstream skills honor
the binding; they do not reclassify unless the user overturns it.

Catalogs (classes, templates, discriminators, default params):
[CLASSIFICATION-CATALOG.md](CLASSIFICATION-CATALOG.md).

## Leading words

- **class** — closed label for the kind of work (`bug`, `tweak`, `refine`,
  `rework`, `feature`, …)
- **binding** — selected workflow **template** plus **parameters**
- **discriminator** — ordered, checkable signal that separates classes
- **template** — named delivery bundle (implement/review/verify shape)

## Invariants

- **Closed classes.** Only labels in the class catalog; no free-text types.
- **Discriminators first.** Apply the catalog’s ordered checks; first match wins.
- **Efficiency default.** Choose the cheapest binding that still covers risk
  (tokens, review breadth, multiagent cost). **`test.mode=dedicated` and
  `harden.mode=dedicated` are the floor** — they are not efficiency knobs.
  Skip them only when the catalog's skip rows apply (explicit user ask, or
  docs-only for test).
- **Ask on costly ambiguity.** Question the user only when two viable classes
  or bindings diverge on expensive params (e.g. comparative vs not, `full` vs
  `focused`, multiagent vs single) — or confidence is not high.
- **Bind once.** After the binding is persisted on the artifact + tracker,
  implement / review / ship read it; they do not re-infer class from vibes.
- **Explicit override wins.** User-named `/bug`, `/tweak`, … or an explicit
  class correction replaces the inferred class for that Task.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Class catalog** | must | Labels + discriminators ([CLASSIFICATION-CATALOG.md](CLASSIFICATION-CATALOG.md)) |
| **Template catalog** | must | Templates + default parameters (same file) |
| **Binding rules** | must | class → default template; override conditions |
| **Artifact sections** | must | Where `## Classification` and `## Workflow` are written |
| **Tracker mirror** | may | How binding is copied onto the issue |

## Flow

1. **Gather signals** — From the aligned description (and supportive RESEARCH /
   MODEL / SANDBOX / ROADMAP). Done when discriminators can be applied.
2. **Classify** — Ordered discriminators → **class** + confidence + one-line
   why. Done when exactly one class is selected or a costly ambiguity is named.
3. **Bind** — Map class → template; apply override rules for blast radius /
   risk → parameters. Done when template + params are complete.
4. **Confirm if required** — High confidence and no costly fork → proceed; else
   one short confirmation (or one discriminator question). Done when the user
   accepts or corrects the binding.
5. **Persist** — Write Classification + Workflow on the definition artifact and
   tracker; set **Next** to the first step of the bound chain. Done when durable
   surfaces agree.

## Reference

Fallback when no `## Workflow` section exists (legacy BUG/TWEAK/REFINE/REWORK
artifacts or older PLAN): infer verify/review defaults from the artifact kind
per [CLASSIFICATION-CATALOG.md](CLASSIFICATION-CATALOG.md#legacy-fallback).
