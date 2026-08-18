# Concept: Iteration

Continue **post-delivery** work with minimal friction: a short delta, brief
alignment when needed, then a **new branch + new PR**. Uninvokable — load only
when a skill's On-invoke pointer fires.

## Intent

Composes brief [CONCEPT_ALIGNMENT](CONCEPT_ALIGNMENT.md) +
[CONCEPT_IMPLEMENTATION](CONCEPT_IMPLEMENTATION.md) for work that already
shipped but still needs a fix. Review stays a separate skill (`/review-fix`)
so the loop can repeat after ship. Open-PR review findings route to
**fix-forward**, not this concept.

## Invariants

- **Post-merge entry.** Enter this loop after the prior delivery merges.
- **New branch from base.** From WORKSPACE base (usually `main`).
- **New PR every iteration.**
- **Delta, not reboot.** Spec is the reported problem + acceptance; prior PLAN/BUG/TWEAK/REFINE/REWORK are context.
- **Brief alignment.** Prefer zero questions when the invoke suffices; at most a short clarifying loop (one question per message).
- **Session continuity.** Load prior Task, merged PR, and artifacts before guessing.
- **Chainable.** After this PR ships, another iterate on the same lineage is valid.
- **Ends at In Review.** Merge/Done remain `/ship`.
- **Straightforward delta.** This loop implements a production fix on a new PR. Inspect-each-turn development of a contained element (visuals, plots, representative comparative reports) is [CONCEPT_SANDBOX](CONCEPT_SANDBOX.md).

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Prior context** | must | How to resolve shipped Task / PR / artifacts |
| **Alignment depth** | must | When to skip vs clarify; stop condition for the delta |
| **Iteration artifact** | must | Format/filename (`ITERATE.md`) |
| **Branch + delivery** | must | Always new branch from base; new PR |
| **Tracker** | must | New Task linked to prior; status through In Review |
| **Handoff** | must | Default Next (usually `/review-fix`) |
| **Chain policy** | may | How a later iterate relates to a previous iterate Task |
| **Spec for review** | may | How review discovers the delta |
| **Inspect-loop fork** | may | When to compose sandbox instead of implement |

## Flow

1. **Resolve prior context** — Task, merged PR, artifacts. Done when lineage is identified.
2. **Capture delta** — wrong/missing behaviour, acceptance, explicit out of scope. Done when implementable (after brief alignment if needed) **or** the work is an inspect-loop (sandbox owns it).
3. **Persist + track** — write artifact; create linked Task. Done when Task exists and artifact is attached — skipped when sandbox takes the post-merge path.
4. **Implement** — CONCEPT_IMPLEMENTATION on new branch; new PR; Task → In Review. Done when PR is ready for review.
5. **Hand off** — **Next** → `/review-fix` on the new Task/PR.
