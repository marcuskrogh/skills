# Concept: Sandbox

Rapid, inspectable development of one **contained** unit **outside production
paths**. Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

Give later skills a **promotion-ready** element (UI, method, bench) by iterating
in an isolated **sandbox** the operator can inspect after each change — without
shipping the production codebase. Production integration is **implement**.

## Leading words

- **sandbox** — isolated vehicle for one contained unit, outside production paths
- **element** — the contained unit under development (UI slice, method, bench)
- **inspectable** — artifact the operator reviews each iteration (screenshot, plot, report)
- **promote** — copy the accepted sandbox result into production via implement
- **kind** — `visual` (look/interaction) or `measure` (metrics, plots, parity)

## Invariants

- **Isolation.** Sandbox tree lives outside production source paths; production stays runnable without it.
- **One element.** One sandbox per contained unit.
- **Inspect each turn.** Every iteration produces inspectables and stops for the operator before the next change.
- **No production ship.** Sandbox does not merge, close out the Task, or open a PR.
- **Human gate.** Continue only after the operator accepts, names a delta, or ends sandbox-only.
- **Bar when measure.** Measure sandboxes record a bar and compare against current (or a named baseline) each iteration.
- **Promote via implement.** Accepted result is input to implement; production paths change there.
- **Runnable harness.** The recorded command runs the sandbox without production-only wiring.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Element** | must | What is isolated |
| **Kind** | must | `visual` or `measure` |
| **Harness** | must | Run command; inspectable type |
| **Isolation path** | must | Directory outside production |
| **Artifact** | must | Filename and required sections (`SANDBOX.md`) |
| **Bar** | may | Metrics, scenarios, tolerances, baseline method (measure) |
| **Promote map** | may | Production target paths and copy notes |
| **Pipeline continuity** | may | Delivery branch; never a sandbox PR |
| **Handoff defaults** | may | Next after accept vs another iteration |
| **Model routing** | may | Workers for sandbox packages — CONCEPT_DELEGATION |

## Flow

1. **Resolve** — element, kind, isolation path, harness, bar when measure. Done when a wrong assumption would not waste an iteration.
2. **Isolate** — create or extract the harness outside production; record the run command. Done when the harness runs and produces an inspectable.
3. **Iterate** — change → run → present inspectable → one question (accept, delta, or sandbox-only end). Done for this turn when the inspectable is shown and the question is asked.
4. **Persist** — write the artifact + inspectables onto the delivery branch (create the branch if needed). **Never open a PR.** Done when the head and tracker agree.
5. **Hand off** — delta → Next remains sandbox; accept → Next implement (promote); sandbox-only end → Next none or define. Done when **Next** matches the operator's verdict.
