# Structure catalog

Disclosed from [CONCEPT_STRUCTURE](CONCEPT_STRUCTURE.md). Load when implementing,
hardening, adopting, or reviewing Architecture / Standards. **Repo docs win.**
Change size does not relax these rows.

Each row is a checkable bar. A breach in **changed** code with a concrete in-PR
move is `should-fix`. A documented layering/ADR breach is `blocker`. Optional
adjacent cleanup the change did not cause is `note`. Do not copy a neighbour
smell into a new hunk.

## Names and size

| Bar | Check |
|-----|--------|
| **Revealing names** | Name says what the unit is or does; no encodings, noise prefixes, or misleading abbreviations |
| **Small function** | One thing, one level of abstraction; extract when a block needs its own name |
| **Small type** | One reason to change; split when unrelated responsibilities share a type or file |
| **Short parameter lists** | Prefer two or fewer arguments; clump related values into a type rather than growing arity |
| **One level per function** | Mix of high-level orchestration and low-level detail in the same body → extract |

## Cohesion and coupling

| Bar | Check |
|-----|--------|
| **Single responsibility** | A module, type, or function has one reason to change |
| **High cohesion** | Parts of a unit belong together; unrelated work does not accumulate |
| **Low coupling** | Depend on the narrowest interface already used in this area; no new hard-wired collaborators that block a **seam** |
| **Dependency direction** | Domain / core does not depend on adapters, frameworks, or transport types |
| **No cycles** | No new or worsened import/package cycles |
| **Command-query** | Functions that change state do not also return computed answers unless that is already the repo idiom |

## Design shape

| Bar | Check |
|-----|--------|
| **DRY for real duplication** | Same logic shape in multiple hunks → extract; keep separate when concepts only rhyme |
| **No speculative generality** | No framework, hook, or extra layer without a second real use |
| **Right layer** | New logic lives where this repo already puts that kind of work |
| **Seams** | I/O, clock, network, DB, and neighbours that tests must isolate are injectable |
| **Error handling is one thing** | Happy path and error path are not tangled past readability; errors are not swallowed |
| **Comments say why** | No comments that restate the code; keep rationale, tradeoffs, and invariants |

## SOLID (when types and modules apply)

| Bar | Check |
|-----|--------|
| **SRP** | One reason to change per type/module |
| **OCP** | Extension uses existing plugin/strategy/registry when the repo already has one |
| **LSP** | Subtypes honour the parent's contract; prefer composition when inheritance is a refused bequest |
| **ISP** | Clients do not depend on methods they never call when a smaller port already exists |
| **DIP** | High-level policy depends on abstractions already used at that boundary |

## Named smells (_Refactoring_, Fowler ch.3)

Actionable in **changed** code → `should-fix`. Name the smell in the finding.

| Smell | Move |
|-------|------|
| **Mysterious Name** | Rename or rethink the design |
| **Duplicated Code** | Extract the shared shape |
| **Feature Envy** | Move the behaviour to the data |
| **Data Clumps** | Introduce a type |
| **Primitive Obsession** | Small domain type |
| **Repeated Switches** | Polymorphism or a shared map |
| **Shotgun Surgery** | Gather the scattered change |
| **Divergent Change** | Split along the change axes |
| **Speculative Generality** | Delete or inline |
| **Message Chains** | Hide behind one method |
| **Middle Man** | Remove and call the target |
| **Refused Bequest** | Prefer composition |

## vs other axes

- **Runtime contracts, auth, compatibility** → Integration ([CONCEPT_REVIEW](CONCEPT_REVIEW.md)).
- **Wrong or missing behaviour** → Spec / Correctness.
- **Local naming and smells** → Standards laser, still this catalog.
- **Module/layer/dependency shape** → Architecture laser, still this catalog.
