# Structure catalog

Disclosed from [CONCEPT_STRUCTURE](CONCEPT_STRUCTURE.md). Load when implementing,
restructuring, adopting, architecting, or reviewing Architecture / Standards.
**Repo docs win.** Change size does not relax these rows.

Each row is a checkable bar. A breach in a **touched unit** with a concrete
in-PR move is `should-fix`. A documented layering/ADR breach is `blocker`.
Cleanup outside the touched unit or architecture neighbourhood is not a
finding (do not park a ticket). Do not copy a neighbour smell into a new hunk.

## Campground and depth

| Bar | Check |
|-----|--------|
| **Campground** | The opened function, method, type, or interface meets this catalog after the change; helpers extracted from it do too; the rest of the file is unchanged unless a hunk made a neighbour worse |
| **Prove before tidy** | Honest tests lock the unit (or characterization tests are added) before structural cleanup |
| **God-unit sprout** | Far-from-bar units extract the path this Task needs; remainder is no worse |
| **One thing** | One reason to change; one level of abstraction in the body |
| **Depth** | Simple interface; implementation hides the rest; a deep module does one thing; a quiet 20–40 line function with one job is a win |
| **Architecture neighbourhood** | When this Task already opens a module or boundary, refine interface / depth / dependency direction if the benefit is major; not a ritual; not a system rewrite |

## Names and size

| Bar | Check |
|-----|--------|
| **Revealing names** | Name says what the unit is or does; no encodings, noise prefixes, or misleading abbreviations |
| **Small function** | One thing, one level of abstraction; extract when a block needs its own name |
| **Small type** | One reason to change; split when unrelated responsibilities share a type or file |
| **Short parameter lists** | Prefer two or fewer arguments; clump related values into a type rather than growing arity |
| **One level per function** | Mix of high-level orchestration and low-level detail in the same body → extract |

## Change risk

Per **function** (the unit Change Risk Anti-Patterns (**CRAP**) score is
computed on). **Guide, not a package fail.** Target **below 8** (Uncle Bob's
recent Clean Code recommendation) unless repo docs set another threshold. A
score at or above the target is a prompt to inspect the shape of the
complexity. Prefer the repo's CRAP or complexity+coverage report; otherwise
compute from cyclomatic complexity `C` and coverage fraction `cov` (0–1):

`CRAP = C² × (1 − cov)³ + C`

| Bar | Check |
|-----|--------|
| **CRAP as guide** | Always evaluate on touched functions. Nested conditionals (long if/else chains, nested ifs) lean toward extract (about 4–8). A flat switch/case, match, or lookup over a closed set of types may stay even when the score is high. The score alone is not `should-fix` and does not fail a package. Coverage counts only tests that assert the executed paths. A low score does not skip lock tests or behaviour coverage |

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
