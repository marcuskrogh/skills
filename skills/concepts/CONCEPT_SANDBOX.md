# Concept: Sandbox

Rapid, inspectable development of one **contained** unit **outside production
paths**, in a **representative** production scenario. Uninvokable — load only
when a skill's On-invoke pointer fires.

## Intent

Give later skills a **promotion-ready** element (UI, method, bench) by iterating
in an isolated **sandbox** the operator can inspect after each change — without
shipping the production codebase. The sandbox stands in for production in every
**relevant area** that would change the inspectable or a comparison; a
non-representative harness is not a sandbox. Production integration is
**implement**. Post-merge inspect-loops that would otherwise be **iterate** use
this concept when each turn needs visual, plot, or report inspection.

## Leading words

- **sandbox** — isolated vehicle for one contained unit, outside production paths
- **element** — the contained unit under development (UI slice, method, bench)
- **inspectable** — artifact the operator reviews each iteration (screenshot, plot, report)
- **promote** — copy the accepted sandbox result into production via implement
- **kind** — `visual` (look/interaction) or `measure` (metrics, plots, parity)
- **relevant area** — production condition that can change the inspectable or comparison
- **representative** — every relevant area is reproduced in the sandbox (or a named gap cannot move the verdict)

## Invariants

- **Representative.** The sandbox matches production in every **relevant area**. Comparative analysis (new vs current, non-degradation) is valid only when baseline and candidate run under that same production scenario. A missing relevant area blocks the inspect-loop until it is reproduced or the operator agrees the gap cannot move the verdict.
- **Isolation.** Sandbox tree lives outside production source paths; production stays runnable without it. Isolation is the tree's location; every relevant area still appears in the harness.
- **One element.** One sandbox per contained unit.
- **Inspect each turn.** Every iteration produces inspectables and stops for the operator before the next change.
- **Manager inspect.** The manager captures and presents inspectables each turn (harness files, RecordScreen, Read).
- **No production ship.** Sandbox does not merge, close out the Task, or open a PR.
- **Human gate.** Continue only after the operator accepts, names a delta, or ends sandbox-only.
- **Bar when measure.** Measure sandboxes record a bar and compare against current (or a named baseline) each iteration, under the representative scenario.
- **Promote via implement.** Accepted result is input to implement; production paths change there.
- **Runnable harness.** The recorded command runs the sandbox without production-only wiring that is **not** a relevant area.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Element** | must | What is isolated |
| **Kind** | must | `visual` or `measure` |
| **Harness** | must | Run command; inspectable type |
| **Isolation path** | must | Directory outside production |
| **Artifact** | must | Filename and required sections (`SANDBOX.md`) |
| **Representativeness** | must | Relevant-area map; how each is reproduced; named gaps |
| **Bar** | may | Metrics, scenarios, tolerances, baseline method (measure) |
| **Promote map** | may | Production target paths and copy notes |
| **Pipeline continuity** | may | Delivery branch; never a sandbox PR; post-merge new Task from base |
| **Handoff defaults** | may | Next after accept vs another iteration |
| **Model routing** | may | CONCEPT_DELEGATION for any Task spawn |

## Flow

1. **Resolve** — element, kind, isolation path, harness, bar when measure, post-merge lineage when the prior Task is merged. Done when a wrong assumption would not waste an iteration.
2. **Represent** — list relevant areas from production (runtime, data, layout, hot path, neighbours that move the metric or inspectable). Reproduce each in the harness, or name a gap and settle with the operator that it cannot move the verdict. Done when the representativeness map is complete and the harness demonstrates it.
3. **Isolate** — place that representative harness outside production; record the run command. Done when the command yields an inspectable **from the representative scenario**.
4. **Iterate** — change → run → present inspectable → one question (accept, delta, or sandbox-only end). Done for this turn when the inspectable is shown and the question is asked.
5. **Persist** — write the artifact + inspectables onto the delivery branch (create the branch if needed; post-merge: new Task + branch from base). **Never open a PR.** Done when the head and tracker agree.
6. **Hand off** — delta → Next remains sandbox; accept → Next implement (promote); sandbox-only end → Next none or define. Done when **Next** matches the operator's verdict.
