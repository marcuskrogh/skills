# Sandbox kinds

Disclosed from [SKILL.md](SKILL.md). Load when choosing a harness, inspectable,
or **relevant area** map. [CONCEPT_SANDBOX](../concepts/CONCEPT_SANDBOX.md) owns
**representative**; this file lists how each kind demonstrates it.

## Relevant areas (every kind)

A relevant area is a production condition that can change the inspectable or the
comparison. Map before the first inspect-loop turn:

| Source | Ask |
|--------|-----|
| Runtime | Same class of load, concurrency, hardware, or timing that moves the verdict? |
| Data | Same shapes, sizes, missingness, and edge states production sees? |
| Neighbours | Layout, theme, parent constraints, callers, or downstream that change look or metrics? |
| Path | Same hot path / API boundary / algorithm seam as production? |
| Baseline | For measure: is the current production method the baseline, not a toy stand-in? |

Stubs replace only wiring that **cannot** move the verdict. Each stub is a named
gap until the operator agrees.

Done when every row is either reproduced in the harness or a named gap.

## visual

Look or interaction of a UI/UX slice. Smallest runnable host that shows the
element **as production presents it** in the relevant areas — not a stripped
demo that would look or behave differently in product.

| Step | Done when |
|------|-----------|
| Host | One command opens or serves the element in the representative layout, theme, density, and data/states |
| Capture | Screenshot, exported still, or live preview the operator can see — per **Manager inspect** |
| Present | The inspectable is in the user-facing reply (image path or preview) |

Prefer a snapshot of the rendered element over describing it in prose.

## measure

Numeric or plotted comparison: performance, parity, or offline method choice.
Baseline is the **current production method** (copied or wrapped) under the
**same representative scenario** as the candidate. A simplified fixture that
omits a production load, data shape, or hot path that moves the metric is not
a comparison.

| Step | Done when |
|------|-----------|
| Scenario | Relevant areas from the table above are reproduced for **both** baseline and candidate |
| Baseline | Current production method on those scenarios; numbers stored |
| Candidate | Runnable on **those same** scenarios |
| Report | Table and/or plot: metric → baseline → candidate → delta → within bar? |
| Present | The report/plot is in the user-facing reply each iteration — per **Manager inspect** |

Suite green on production is not the bar. The sandbox report under the
representative scenario is.

## Isolation defaults

| Field | Default |
|-------|---------|
| Root | WORKSPACE **Sandbox root** (else `sandbox/`) |
| Tree | `<root>/<slug>/` |
| Inspectables | `<tree>/inspect/` |
| Artifact | WORKSPACE **Sandbox** path (else `SANDBOX.md`) |

`<slug>` is a short filesystem name for the element. Production source paths
stay untouched until implement promotes. Leave the isolation tree on the
delivery branch unless the Promote map says to delete it after copy.
