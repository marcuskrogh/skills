# Concept: Architecture

Choose where this Task’s work sits in the system before production code.
Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

After definition alignment, record the **shape** of the solution: modules,
layers, dependency direction, seams, and what this Task will not invent.
Everyday work also considers the **architecture neighbourhood** already opened
and refines it when the benefit is major. Implement treats the artifact as spec.
Review checks the code against it and the structure catalog.

## Leading words

- **shape stamp** — short record of where this change lives and what we will
  not add (bugs and tweaks)
- **architecture neighbourhood** — the module or boundary this Task already
  opens, plus its ports
- **ARCHITECTURE.md** — finding/design docs on the delivery branch; never its
  own pull request

## Invariants

- **Always in the chain.** Every bound delivery Task runs architect after
  define (or after side paths / sandbox) and before implement. Depth follows
  the change; the step is not skipped.
- **Shape, not behaviour.** Behaviour stays on the definition artifact.
  Architect owns where types live, which module is deep, which seams exist,
  which dependencies point inward, and what we refuse to invent.
- **Repo docs first.** Read ADRs and neighbour patterns. Ask the operator only
  when the shape itself diverges (new module, new public API, new layer).
- **Neighbourhood when major.** If this Task already opens a module or crosses
  a boundary and a better interface, depth, or dependency direction is a
  **major** benefit, record it as in-scope work. Not a ritual. Not a system
  rewrite. No follow-up ticket.
- **Spec for implement.** Implement may not ignore `ARCHITECTURE.md`. Review
  Architecture checks the diff against it.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Artifact** | must | Path and sections of `ARCHITECTURE.md` |
| **Depth** | may | Shape stamp vs full map |
| **Handoff** | must | Next after the artifact is on the delivery branch |

## Flow

1. **Load definition + repo docs** — PLAN/BUG/… plus ADRs and neighbour
   patterns. Done when the behaviour spec and existing shape are known.
2. **Record shape** — where new types live, seams, dependency direction, what
   we will not add; neighbourhood refinements only when major. Done when
   `ARCHITECTURE.md` answers those for this Task.
3. **Prove the record is implementable** — no speculative layer without a
   second real use; neighbourhood work still “a little larger.” Done when
   implement can place code without guessing shape.
