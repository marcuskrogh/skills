# Skills

Consistent description of each invokable folder under `skills/` as it exists on `main`. Source: each `SKILL.md` frontmatter and Output section, plus [`workflows`](../../skills/workflows/SKILL.md) and [`workflow/reference.md`](../../skills/workflow/reference.md).

Return to the [front page](../../README.md).

Every row uses the same fields:

| Field | Meaning |
|-------|---------|
| What | One-line role from the skill file |
| How to use | Slash name, or automatic via the router |
| Where | Situation the catalog or skill names |
| Output | Artifact or result, plus outcome token when the skill records one |
| Workflows | Which catalog rows load this skill |

Aliases are listed once and point at the skill they run.

If a field is not stated in the skill file, this page says so instead of guessing.

## Index

- [Routers](#routers)
- [Front doors](#front-doors)
- [Manual class overrides](#manual-class-overrides)
- [Side paths](#side-paths)
- [Delivery chain](#delivery-chain)
- [Post-merge](#post-merge)
- [Walk, teach, map, status](#walk-teach-map-status)
- [Repo maintenance](#repo-maintenance)
- [Composed references](#composed-references)

## Routers

### workflows

| Field | |
|-------|-|
| What | Model-invoked router. Foggy → explore. Concrete → define (interview, then classify and bind). |
| How to use | Automatic when you describe work to deliver. The agent discovers this skill without a slash name. |
| Where | Default entry for real work in this skills set. Also walkthroughs → guide, current-step teaching → explain. |
| Output | None of its own. It discloses and runs the selected skill. |
| Workflows | This skill *is* the catalog. It is not a row that other workflows invoke as a pipeline step. |

### help

| Field | |
|-------|-|
| What | Human-facing map of this skills set. Maps choices. Does not create issues, write specs, or advance a Task. |
| How to use | `/help`, or automatic when you ask which skill to run or for a navigation overview. |
| Where | Which skill, how workflows relate, navigation overview. Not status of an in-flight Task (`/summarise`). Not teaching the current step (`/explain`). Not a paced walkthrough (`/guide`). |
| Output | The short map or a choose-one reply. Stops. No tracker write. |
| Workflows | **help** |

### writing-for-agents

| Field | |
|-------|-|
| What | Writing skills and concepts for agents. |
| How to use | Automatic when creating or editing a `SKILL.md`, `CONCEPT_*.md`, skill reference, `AGENTS.md`, or `CLAUDE.md` in this repo. Or mention that you are authoring skills. |
| Where | This skills repository (or a clone that maintains skills). Not for ordinary product delivery in a consuming repo. |
| Output | Edits to those files. The skill file's Output heading is the *shape template* for skills being authored, not a runtime artifact this skill writes. |
| Workflows | Outside the delivery catalog. Model-invoked authoring aid. |

## Front doors

### setup

| Field | |
|-------|-|
| What | Workspace alignment at repository or global scope: tracker, artifact location, delivery conventions. |
| How to use | `/setup` |
| Where | No usable `WORKSPACE.md`, onboarding a repo, changing tracker or paths, or before first explore/define/bug/tweak/refine/rework. |
| Output | `WORKSPACE.md`. Outcome: `ready`. No bound workflow, so Next is none. |
| Workflows | **setup**. Other pipeline skills compose setup in-invocation if neither workspace layer exists. |

### explore

| Field | |
|-------|-|
| What | Exploration through foggy or oversized work. Charts a map and sequenced route Tasks. |
| How to use | `/explore`, or automatic when the destination is felt but the route is not visible. |
| Where | Vague, oversized, or still-unclear initiative. Not concrete work (that is define). |
| Output | `ROADMAP.md`. Outcome: `ready`. Story plus typed route Tasks. No map-only pull request. Research, model, and sandbox artifacts stay on the delivery branch. |
| Workflows | **explore**. After explore, Next is the frontier (research, model, sandbox, or define) or none. |

### define

| Field | |
|-------|-|
| What | Definition front door for concrete work. Interviews before classification and workflow binding. |
| How to use | `/define`, or automatic for concrete delivery asks. |
| Where | Bug, tweak, refine, rework, feature, or similar concrete work with no user-approved definition artifact yet. A chat description is not an approved plan. Prefer explore when the destination is foggy. Prefer adopt when the whole existing tree should meet the structure catalog. |
| Output | `PLAN.md` (Classification + Workflow). Outcome: `ready`. Sub-tasks, delivery branch, and pull request. |
| Workflows | **define**. Bound delivery (or adopt, if class is adopt) starts after approval. |

## Manual class overrides

Prefer `/define` unless you mean the override. Each still interviews before it writes the plan.

### bug

| Field | |
|-------|-|
| What | Lightweight definition for a clear defect. |
| How to use | `/bug` (explicit). |
| Where | Behaviour is wrong or regressing. The fix is the work. Expected correct behaviour is known or knowable. |
| Output | `BUG.md` plus the fix-fast binding. Outcome: `ready`. One Task, delivery branch and pull request. |
| Workflows | **bug** (manual). After ready, delivery chain: architect → implement → test → restructure → review → ship. |

### tweak

| Field | |
|-------|-|
| What | Lightweight definition for a small intentional change to existing behaviour. |
| How to use | `/tweak` (explicit). |
| Where | Small behaviour delta. Not a defect. Too light for a full feature slice. |
| Output | `TWEAK.md` plus the delta-fast binding. Outcome: `ready`. |
| Workflows | **tweak** (manual). Then the delivery chain. |

### refine

| Field | |
|-------|-|
| What | Lightweight definition for a limited area that needs refactoring or descriptive improvement without changing behaviour. |
| How to use | `/refine` (explicit). |
| Where | Bounded module, class, slice, or README. Structure, naming, layering, comments, docs, or refactoring only. Executable behaviour unchanged. Prefer `/adopt` for a whole tree. Prefer `/restructure` for closeout of the current delivery PR. |
| Output | `REFINE.md` plus the structure-safe binding. Outcome: `ready`. |
| Workflows | **refine** (manual). Then the delivery chain (`test.mode=skip` only when the catalog's docs-only row applies). |

### rework

| Field | |
|-------|-|
| What | Lightweight definition for an intentional implementation change that must not degrade measured outcomes. |
| How to use | `/rework` (explicit). |
| Where | Algorithm, control law, or internal path change with a parity bar. |
| Output | `REWORK.md`, parity bar, and the parity-iterative binding. Outcome: `ready`. |
| Workflows | **rework** (manual). Then delivery with comparative implement until the bar. |

### adopt

| Field | |
|-------|-|
| What | Apply the structure catalog across an existing codebase that was not built to it. |
| How to use | `/adopt`, or automatic when the whole existing tree matches the adopt catalog row. |
| Where | Brownfield whole-tree (or named subtree) structure. Executable behaviour unchanged. Prefer `/refine` for a bounded area. |
| Output | `ADOPT.md`: inventory plus frontier behaviour map (tests, including startable frontend and backend). Outcome: `mapped`, or `hard-stop` when the map cannot be locked. |
| Workflows | **adopt**. Walks inventory, then characterize → architect → implement → test → restructure → review → ship per area until Done. Proof is required. Test cannot be skipped. |

## Side paths

### research

| Field | |
|-------|-|
| What | Research across preprint, formal, web, and practitioner axes. |
| How to use | `/research`, or as define's bound `side_paths`. |
| Where | You explicitly want a multi-axis literature or evidence pass now. Surveys, state of the art, wide evidence. Does not replace define's questions with the user. |
| Output | `RESEARCH.md` on the delivery branch. Outcome: `ready`. No pull request of its own. |
| Workflows | **research**. Also a delivery prefix when `side_paths` includes research. Explore may set frontier=research. |

### model

| Field | |
|-------|-|
| What | Mathematical alignment through LaTeX-only questions. |
| How to use | `/model`, or as define's bound `side_paths`. |
| Where | You explicitly want a math formulation now: dynamical models, optimal control, estimators, or applied math. Not product scope or UX. |
| Output | `MODEL.md` on the delivery branch. Outcome: `ready`. No pull request of its own. |
| Workflows | **model**. Also a delivery prefix when `side_paths` includes model. Explore may set frontier=model. |

### sandbox

| Field | |
|-------|-|
| What | Isolated, representative inspect-loop of a contained UI, method, or bench. |
| How to use | `/sandbox`, as a bound `sandbox: inject` step, mid-implement when a package needs inspect-each-turn, or post-merge instead of iterate when each turn needs inspection. |
| Where | Contained element that needs a screenshot, plot, or report each turn, outside production paths. Isolation tree must be representative. Kinds in [`sandbox/kinds.md`](../../skills/sandbox/kinds.md): `visual` or `measure`. |
| Output | `SANDBOX.md` plus isolation tree under the WORKSPACE sandbox root (default `sandbox/<slug>/`). Outcome: `delta`, `accept`, or `end`. No pull request of its own. After accept, implement promotes and (if post-merge) opens the pull request. |
| Workflows | **sandbox**. Bound delivery step when `sandbox=inject`. Iterate may continue into sandbox when outcome is inspect-loop. |

## Delivery chain

### architect

| Field | |
|-------|-|
| What | Record where this Task's work sits (modules, layers, seams, dependency direction) in `ARCHITECTURE.md`. |
| How to use | `/architect`, or when the bound chain reaches this step. Always in the delivery chain. |
| Where | After a definition spec exists (or this skill defines one). Depth: short shape stamp for bug/tweak; full map for feature/rework/adopt and boundary-moving refine. |
| Output | `ARCHITECTURE.md` on the delivery branch. Outcome: `ready`. Does not open a pull request. |
| Workflows | Every delivery template. Adopt unit chain. Not on the iterate chain (iterate does not reopen architect). |

### implement

| Field | |
|-------|-|
| What | Implementation through managed, value-routed work packages. Reuses the Task's delivery branch and pull request. |
| How to use | `/implement` when an approved definition spec exists. Or when Next is implement. A chat description is not that spec. |
| Where | Build or resume. Also review fix-forward (outcome `fixed`). Honors Workflow binding when present. Enforces tests and structure as-you-go. |
| Output | Delivery diff on the delivery branch/PR. Outcome: `built`, or `fixed` for fix-forward. |
| Workflows | **implement**. Every delivery, iterate, and adopt unit chain. After review FAILED, Next is implement. |

### test

| Field | |
|-------|-|
| What | Testing of touched code: coverage, CRAP, spec locks, representability, adversarial coverage, and testability. Adds or tightens tests and seams only. |
| How to use | `/test`, or when the bound testing phase is current. |
| Where | After implement, when `test.mode=dedicated` (always for adopt). No new product behaviour. |
| Output | Tests on the delivery diff. Outcome: `ready`, or `skipped` when the binding skips this step. |
| Workflows | **test**. Delivery and iterate when test is not skipped. Adopt always. |

### restructure

| Field | |
|-------|-|
| What | Refactoring pass against the structure catalog (campground, names, size, cohesion, seams, named smells, CRAP). No behaviour change. |
| How to use | `/restructure` (prefer) or `/harden`. Or when the workflow's restructure step is current. |
| Where | After test (or after implement when test is skipped). Standalone on a named area, or closeout of the current delivery PR. Binding key stays `harden.mode`. |
| Output | Structural edits on the delivery diff. Outcome: `ready`, or `skipped` when the user explicitly skipped this step. Task moves to In Review when the pass completes. |
| Workflows | **restructure**. Delivery, iterate, and adopt unless `harden.mode=skip`. |

### harden

Alias. Run [`restructure`](../../skills/restructure/SKILL.md) with the same Task key. Prefer `/restructure`. `/harden` remains valid.

### review

| Field | |
|-------|-|
| What | Review of a change as sequential or bundled lasers across Spec, Correctness, Integration, Architecture, and Standards: find, fix, then publish a code review. |
| How to use | `/review` (prefer) or `/review-fix`. Or when the bound review step is current. |
| Where | Task is In Review. Open delivery PR. Also **fix-forward** when that PR has review findings. |
| Output | Published pull-request review. Outcome: `CLEAN` or `FAILED`. FAILED → Next implement. CLEAN → Next ship. |
| Workflows | **review**, **fix-forward**. Every delivery, iterate, and adopt unit chain. |

### review-fix

Alias. Run [`review`](../../skills/review/SKILL.md) with the same Task key. Prefer `/review`. `/review-fix` remains valid.

### ship

| Field | |
|-------|-|
| What | Shipping of all remaining work for a ready-to-build Task. Detects the stage, composes remaining skills, merges the delivery PR, completes Done. |
| How to use | `/ship`, or bare **ship** / finish / close it out. Prefer an explicit key (`ship MD-5`) when present. |
| Where | Bound workflow still open. Requires authenticated `gh` plus tracker auth. |
| Output | Merged delivery PR, Task Done. Outcome: `done`. Next is none. A later request that is still wrong is a new iterate or sandbox workflow. |
| Workflows | **ship**. Last step of delivery, iterate, and adopt unit chains. |

## Post-merge

### iterate

| Field | |
|-------|-|
| What | Iteration on already merged work. New Task and branch. |
| How to use | `/iterate`. |
| Where | Prior Task/PR already merged and still broken or incomplete, and tests plus review on a new PR suffice. When each turn needs visual, plot, or report inspection, the outcome is `inspect-loop` (sandbox instead). Open-PR review findings are fix-forward, not iterate. |
| Output | `ITERATE.md` plus a new Task key. Outcome: `ready`, or `inspect-loop`. The iterate workflow then continues into implement (or sandbox). This skill stops at the spec. |
| Workflows | **iterate**. Chain: implement → test → restructure → review → ship (no architect). |

## Walk, teach, map, status

### guide

| Field | |
|-------|-|
| What | Guidance through a manual task one step at a time. Present one step. Wait for advance or a block. |
| How to use | `/guide`. |
| Where | Install, setup, hardware, or coding *you* want walked. Prefer `/define` when the agent should deliver the work. Prefer `/explain` for teaching without a walkthrough. |
| Output | No PLAN, BUG, branch, or PR. Chat Next only: resume in-flight Task, or `None — walkthrough complete.` |
| Workflows | **guide**. Interrupts without replacing a bound chain. |

### explain

| Field | |
|-------|-|
| What | Explanation of the current workflow step, coding choices, interfaces, numerical points, or recent agent output, in simple terms. |
| How to use | `/explain`. |
| Where | Current step or a decision taught. Long explanations are paced (one beat per turn). Prefer `/help` for which skill. Prefer `/guide` for a walkthrough. |
| Output | No PLAN, BUG, branch, or PR. Chat Next only: resume in-flight Task, or `None — explanation complete.` |
| Workflows | **explain**. Interrupts without replacing a bound chain. |

### summarise

| Field | |
|-------|-|
| What | Read-only status for a pipeline Task or Story: purpose, track, stage, artifacts, and the next valid invoke. |
| How to use | `/summarise`. |
| Where | Status, where-am-I, or what-next, reported and not advanced. May refresh a stale mirror Next column. |
| Output | Reply shape with About, Track, Stage, Artifacts, Status, and one valid Next. Does not run that skill. |
| Workflows | **summarise**. |

## Repo maintenance

### manage-skills

| Field | |
|-------|-|
| What | Maintains the agent skills repository and install workflow. |
| How to use | `/manage-skills`, or ask how to install, sync, update, or add a skill. |
| Where | Creating a new skill, syncing locally, updating an existing project install, installing via agent-from-git or skills.sh / the optional Claude plugin, or asking how skills are distributed. |
| Output | The skill file does not name a single artifact. Install completion criteria are in [`agent-install.md`](../../skills/manage-skills/agent-install.md): `.agents/skills/workflows/SKILL.md`, `concepts/`, `.skills-version`, and the `AGENTS.md` block. |
| Workflows | Outside the delivery catalog. |

## Composed references

You do not start work by invoking these. Pipeline skills load them.

### workflow

| Field | |
|-------|-|
| What | Shared delivery contract: one branch/PR per Task, closed-loop ship, continuation keywords, pointers to delivery/handoff/tracker/ship refs. |
| How to use | Not for user invocation. Composed by pipeline skills. |
| Where | Any pipeline skill's On-invoke that points at `../workflow/SKILL.md`. |
| Output | None. It is a contract, not a producer. |
| Workflows | Composed by delivery, explore, iterate, adopt, and standalone skills. |

### tracker

| Field | |
|-------|-|
| What | Shared issue-tracker contract. Resolves provider from the effective workspace: markdown, jira, github, or linear. |
| How to use | Not for user invocation. Configure via `/setup`. |
| Where | Create, transition, comment, or close issues. Backends live under `skills/tracker/backends/`. |
| Output | Tracker operations on the configured provider. No skill-level outcome token. |
| Workflows | Composed by explore, define, implement, review, ship, setup, and the other pipeline skills that write the tracker. |

### jira

| Field | |
|-------|-|
| What | Jira REST details for the tracker jira backend. |
| How to use | Not for user invocation. Prefer tracker and `WORKSPACE.md` provider selection. |
| Where | When the effective workspace provider is `jira`. If the target repository contains `docs/agents/jira.md`, follow that file for project-specific types and transitions. |
| Output | None of its own. Backend for tracker. |
| Workflows | Composed only through tracker when provider is jira. |

## Related pages

- [Workflows](workflows.md)
- [Concepts](concepts.md)
- [Examples](examples.md)
