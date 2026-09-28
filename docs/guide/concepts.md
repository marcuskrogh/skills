# Concepts

Shared invariants. Concepts are never invoked. Skills fill extensions and produce outputs. Source: files under `skills/concepts/` on `main`.

Return to the [front page](../../README.md).

A skill never restates a concept invariant. It points at the concept, fills the extension table, and writes skill-only steps. That split is [`writing-for-agents`](../../skills/writing-for-agents/SKILL.md).

## How to use a concept

You do not run `/CONCEPT_ALIGNMENT`. The applying skill's **On invoke** line names which concept files to read. Always-on extracts name language files so operator replies follow them without a slash.

## Concept files

Each row: what it owns, which skills apply it (from those skills' On-invoke or body), and what a later step should expect. Skills listed are the ones that name the concept on `main`. If a skill applies a concept only through a composed skill, that is noted.

### CONCEPT_SKILL

| Field | |
|-------|-|
| Owns | A skill is a function: concepts in, one output out. No successor. Required inputs are defined in-invocation when missing. |
| Applied by | Pipeline skills that produce artifacts (define, implement, architect, and others that load it on invoke). |
| Expect | Outcome token (`ready`, `built`, `CLEAN`, …). Workflow writes Next. |

### CONCEPT_ALIGNMENT

| Field | |
|-------|-|
| Owns | One question per turn until skill-relevant divergences are resolved with the user, then the artifact and readiness prompt. |
| Applied by | define, setup, bug, tweak, refine, rework, sandbox (when a representativeness gap needs agreement), and other alignment skills. |
| Expect | An open alignment turn has no `## Next` block. Approval of the readiness prompt is required before persist. The opening description is not approval. |

### CONCEPT_DEFINITION

| Field | |
|-------|-|
| Owns | Concrete, implementable definition: specification vs pass criteria. Docs-only pass criteria are `none — no executable behaviour`. |
| Applied by | define and the class skills when they write PLAN/BUG/TWEAK/REFINE/REWORK. |
| Expect | Scope, behaviour or parity, constraints, and pass criteria stated or deferred. |

### CONCEPT_CLASSIFICATION

| Field | |
|-------|-|
| Owns | Closed class plus workflow binding after the user approved the definition. |
| Applied by | define (required sections on `PLAN.md`). Manual class skills record the class default binding. |
| Expect | `## Classification` and `## Workflow` on the definition artifact. Discriminators in order. First match wins. Catalog: [`CLASSIFICATION-CATALOG.md`](../../skills/concepts/CLASSIFICATION-CATALOG.md). |

### CONCEPT_ARCHITECTURE

| Field | |
|-------|-|
| Owns | Shape of this Task: modules, layers, seams, dependency direction, what not to invent. Always in the delivery chain. |
| Applied by | architect. |
| Expect | `ARCHITECTURE.md` on the delivery branch. Implement may not ignore it. |

### CONCEPT_IMPLEMENTATION

| Field | |
|-------|-|
| Owns | Execute an agreed specification via a manager that plans, delegates, evaluates, and tracks. |
| Applied by | implement (and adopt/iterate when they compose implement). |
| Expect | Isolated work packages. Touched areas stay at least as testable, covered, and structured as before. |

### CONCEPT_STRUCTURE

| Field | |
|-------|-|
| Owns | Structure bar: names, size, cohesion, dependency direction, named smells, CRAP, campground, refactoring, module depth. |
| Applied by | implement (as-you-go), restructure, adopt, refine. Catalog: [`STRUCTURE-CATALOG.md`](../../skills/concepts/STRUCTURE-CATALOG.md). |
| Expect | Behaviour-preserving structure edits. Campground on opened units. |

### CONCEPT_REVIEW

| Field | |
|-------|-|
| Owns | Multi-axis review that finds and fixes, then publishes a code review. |
| Applied by | review. Depth and lasers: [`review/depth.md`](../../skills/review/depth.md), [`review/lasers.md`](../../skills/review/lasers.md). |
| Expect | Outcome `CLEAN` or `FAILED`. Actionable findings fixed on this pull request. |

### CONCEPT_RESEARCH

| Field | |
|-------|-|
| Owns | Citable research brief across multiple axes. Supportive context only. Does not settle product, UX, scope, or acceptance. |
| Applied by | research. |
| Expect | `RESEARCH.md` with claims tied to retrieved evidence. |

### CONCEPT_SANDBOX

| Field | |
|-------|-|
| Owns | Rapid, inspectable development of one contained unit outside production paths, in a representative production scenario. |
| Applied by | sandbox. Kinds: [`sandbox/kinds.md`](../../skills/sandbox/kinds.md). |
| Expect | Isolation tree plus `SANDBOX.md`. Promote via implement. Non-representative isolation is not a sandbox. |

### CONCEPT_ITERATION

| Field | |
|-------|-|
| Owns | Post-delivery work: short delta, new branch and new PR. Open-PR review findings are fix-forward, not this concept. |
| Applied by | iterate. |
| Expect | New Task. Closeout stays on the iterate workflow. |

### CONCEPT_GUIDANCE

| Field | |
|-------|-|
| Owns | Paced walkthrough: one step per turn, wait for advance or block. |
| Applied by | guide. |
| Expect | No delivery artifacts. |

### CONCEPT_EXPLANATION

| Field | |
|-------|-|
| Owns | Paced teaching of the current step and its decisions. |
| Applied by | explain. |
| Expect | One beat per turn when the explanation is long. |

### CONCEPT_LANGUAGE

| Field | |
|-------|-|
| Owns | Operator-directed prose: short, precise, ordinary English. Spell names in full. Keep **harness** for the agent host. |
| Applied by | Always-on extracts (`AGENTS.md`, Cursor rule, `~/.claude/CLAUDE.md`). Load also [`LANGUAGE-PHRASES.md`](../../skills/concepts/LANGUAGE-PHRASES.md) and [`LANGUAGE-HUMANIZER.md`](../../skills/concepts/LANGUAGE-HUMANIZER.md). |
| Expect | User-facing chat, tracker comments, and operator PR text follow this. Skill files do not. Product copy follows CONCEPT_IMPLEMENTATION. |

### CONCEPT_DELEGATION

| Field | |
|-------|-|
| Owns | Before every sub-agent spawn, score task difficulty and assign a worker model. Detect harness, load the matching platform catalog. |
| Applied by | Any skill that spawns Task / sub-agents (implement, review, research, sandbox, adopt, …). |
| Expect | Catalog-closed model slugs on Cursor, as in [`platforms/cursor.md`](../../skills/concepts/platforms/cursor.md). |

## Disclosed catalogs (not concepts)

These are sibling files. Skills and concepts point at them. They are not invokable.

| File | Role |
|------|------|
| [`CLASSIFICATION-CATALOG.md`](../../skills/concepts/CLASSIFICATION-CATALOG.md) | Classes, templates, default params, override rules |
| [`STRUCTURE-CATALOG.md`](../../skills/concepts/STRUCTURE-CATALOG.md) | Structure bar details |
| [`PLATFORM-CATALOGS.md`](../../skills/concepts/PLATFORM-CATALOGS.md) | Which platform file to load for delegation |
| [`LANGUAGE-PHRASES.md`](../../skills/concepts/LANGUAGE-PHRASES.md) | Stock-line replacements for operator prose |
| [`LANGUAGE-HUMANIZER.md`](../../skills/concepts/LANGUAGE-HUMANIZER.md) | Cadence overlay |
| [`platforms/cursor.md`](../../skills/concepts/platforms/cursor.md) | Cursor Task model catalog |
| [`platforms/claude-code.md`](../../skills/concepts/platforms/claude-code.md) | Claude Code catalog |
| [`platforms/codex.md`](../../skills/concepts/platforms/codex.md) | Codex catalog |
| [`platforms/github-copilot.md`](../../skills/concepts/platforms/github-copilot.md) | GitHub Copilot catalog |
| [`platforms/general.md`](../../skills/concepts/platforms/general.md) | Fallback when the harness is not one of the named files |

## Related pages

- [How it works](how-it-works.md)
- [Skills](skills.md)
