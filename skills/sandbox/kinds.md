# Sandbox kinds

Disclosed from [SKILL.md](SKILL.md). Load when choosing a harness or inspectable.

## visual

Look or interaction of a UI/UX slice. Smallest runnable host that shows **only
that element** — a single page, story, isolated route, or component playground.
Stubs replace production-only wiring.

| Step | Done when |
|------|-----------|
| Host | One command opens or serves the element |
| Capture | Screenshot, exported still, or live preview the operator can see |
| Present | The inspectable is in the user-facing reply (image path or preview) |

Prefer a snapshot of the rendered element over describing it in prose.

## measure

Numeric or plotted comparison: performance, parity, or offline method choice.
Baseline is the **current** production method (copied or wrapped into the
sandbox) or a named recorded run. The candidate lives only in the sandbox until
promote.

| Step | Done when |
|------|-----------|
| Baseline | Same scenarios/fixtures as the candidate; numbers stored |
| Candidate | Runnable on those scenarios |
| Report | Table and/or plot: metric → baseline → candidate → delta → within bar? |
| Present | The report/plot is in the user-facing reply each iteration |

Suite green on production is not the bar. The sandbox report is.

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
