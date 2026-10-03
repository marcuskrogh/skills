# Examples

How the catalog is applied. Each example is a situation already named in [`workflows`](../../skills/workflows/SKILL.md), [`help`](../../skills/help/SKILL.md), or [`manage-skills`](../../skills/manage-skills/SKILL.md). They are not extra workflows.

Return to the [front page](../../README.md).

Pattern in every example: what you say or do, which workflow matches, what you should see, what happens next.

## Install into a consuming repo

You want this skills set in another project.

| | |
|-|-|
| You | Paste the prompt in [`agent-install.md`](../../skills/manage-skills/agent-install.md), or run `curl -fsSL https://raw.githubusercontent.com/marcuskrogh/skills/main/scripts/install-from-git.sh \| bash` from that project's root. |
| Workflow | `/manage-skills` (outside the delivery catalog). Not define. |
| You should see | `.agents/skills/` replaced, `.skills-version` written, `AGENTS.md` / `CLAUDE.md` / `.cursor/rules/github-skills.mdc` wired. |
| Next | Commit those paths. In the next chat, describe work or run `/setup` if there is no `WORKSPACE.md`. |

If you instead run `npx skills add marcuskrogh/skills`, the skill tree is installed but the prefer-workflow `AGENTS.md` block is **not** written unless you add it. That limitation is stated in agent-install.md.

More snippets: [Install](install.md). The [front page](../../README.md#install) has the short install only.

## You only want the map

| | |
|-|-|
| You | "Which skill should I use?" or `/help`. |
| Workflow | **help** |
| You should see | Front doors (setup, explore, define), whole-repo structure (adopt), walk/teach/map. Suggested invoke. |
| Next | Help stops. It does not start setup, explore, or define unless you then ask to begin that work. |

## Foggy destination

| | |
|-|-|
| You | A large or unclear goal. You feel the end state but not the steps. |
| Workflow | **explore** (first matching row for foggy work, after setup/continue/ship/help/explain/guide/sandbox/iterate/fix-forward/adopt checks). |
| You should see | Interview toward a destination, then `ROADMAP.md` plus a Story of sequenced route Tasks. No map-only pull request. |
| Next | Persisted Next is the frontier: often `/define` on a route Task, sometimes research, model, or sandbox first. |

## Concrete feature, bug, or docs change

| | |
|-|-|
| You | "Add X", "this test fails", "rewrite the README", or any concrete slice. You did not name `/bug` or `/refine`. |
| Workflow | **define** |
| You should see | One interview question at a time. Then a plan and "Does this plan and workflow binding look right?" A short description is not approval. After yes: `PLAN.md` with Classification and Workflow, a Task, a branch, a draft pull request. |
| Next | Bound chain, usually `/architect` then implement → test → restructure → review → ship. Docs-only refine may skip test. |

## You name `/bug` yourself

| | |
|-|-|
| You | `/bug` plus the defect. |
| Workflow | **bug** (explicit name wins). |
| You should see | The same interview style, then `BUG.md` and a fix-fast binding. |
| Next | Delivery chain. Prefer `/define` when you want the agent to classify. |

## Brownfield structure across the tree

| | |
|-|-|
| You | This codebase was not built to the structure catalog. You want that catalog applied across it. |
| Workflow | **adopt** (matches before define). |
| You should see | `ADOPT.md` with inventory and a behaviour map locked into tests (including startable frontend and backend when those surfaces exist). Then characterize → architect → implement → test → restructure → review → ship per area. |
| Next | The adopt workflow walks immediately between unit steps. It does not skip test. Hard stop if proof fails. |

## Literature before locking the approach

| | |
|-|-|
| You | "Survey the literature" or define binds `side_paths=research`. |
| Workflow | **research** (explicit, or a delivery prefix). |
| You should see | `RESEARCH.md` on the delivery branch. Claims tied to preprint, formal, web, and practitioner axes (unless you narrowed the pass). No research-only pull request. |
| Next | Frontier or architect, depending on the bound chain. Research does not answer define's product questions. |

## Math formulation

| | |
|-|-|
| You | "Write the equations" or define binds `side_paths=model`. |
| Workflow | **model** |
| You should see | LaTeX-only questions, then `MODEL.md` on the delivery branch. No model-only pull request. |
| Next | Same as research: prefix or frontier, then the rest of the chain. |

## Contained UI that needs a screenshot each turn

| | |
|-|-|
| You | A contained visual slice, or a binding with `sandbox: inject`, or post-merge work that needs inspectables. |
| Workflow | **sandbox** |
| You should see | A representative isolation tree (default `sandbox/<slug>/`), `SANDBOX.md`, and an inspectable each turn. Question: accept and promote, name a delta, or end. No sandbox pull request. |
| Next | `delta` resumes the loop. `accept` → implement promotes (and opens the PR after post-merge sandbox). `end` stops. |

Kinds `visual` and `measure` are in [`sandbox/kinds.md`](../../skills/sandbox/kinds.md). This page does not invent a third kind. If a report-style inspectable is required, the catalog currently names visual (screenshot/preview) and measure (plot/metrics). Whether a prose report fits those kinds is not spelled out in kinds.md. Treat that as unclear and stay on the named kinds.

## Walk me through install instead of doing it

| | |
|-|-|
| You | "Walk me through installing this" or `/guide`. |
| Workflow | **guide** |
| You should see | One step. Then wait for yes / okay / move on, or a block. |
| Next | Resume an in-flight Task's Next if one exists. Guide does not open a PLAN or PR. |

If you wanted the agent to install for you, that is `/manage-skills` / the agent-install prompt, not guide.

## Teach the current step

| | |
|-|-|
| You | "Explain what define just asked" or `/explain`. |
| Workflow | **explain** |
| You should see | One beat in simple terms. Longer explanations wait for advance. |
| Next | Resume persisted Next. Explain does not advance the Task. |

## Status only

| | |
|-|-|
| You | "Where am I?" or `/summarise`. |
| Workflow | **summarise** |
| You should see | Track, stage, artifacts, status, and one valid Next. |
| Next | Summarise does not run that skill. |

## Open pull request has review findings

| | |
|-|-|
| You | Review comments on the still-open delivery PR. |
| Workflow | **fix-forward** (`/review`, always fixes). |
| You should see | Findings addressed on the same PR. Not a new iterate Task. |
| Next | Review again until CLEAN, then ship. |

## Merged, still wrong, ordinary fix

| | |
|-|-|
| You | The PR merged. The bug remains. Tests and review on a new PR are enough. |
| Workflow | **iterate** |
| You should see | `ITERATE.md`, a **new** Task, branch, and pull request. No new architect step. |
| Next | implement → test → restructure → review → ship. |

## Merged, still wrong, needs inspect-each-turn

| | |
|-|-|
| You | Same as above, but each turn needs a visual, plot, or report. |
| Workflow | **sandbox** (post-merge), not iterate. |
| You should see | New Task and branch from base. Isolation tree. **No** sandbox PR. Implement opens the PR when promoted. |
| Next | After accept: implement → test → restructure → review → ship. |

## Bare next vs ship

| | |
|-|-|
| You | **next** (or continue / go) on an active Task. |
| Workflow | **continue** |
| You should see | The persisted Next skill runs **once**. |
| Contrast | **ship** / finish / close it out runs the **remaining** suffix through merge and Done. |

## Authoring a new skill in this repo

| | |
|-|-|
| You | Add `skills/<name>/SKILL.md` in marcuskrogh/skills. |
| Workflow | `/manage-skills` plus model-invoked **writing-for-agents**. |
| You should see | Skill shape from writing-for-agents. Concept if shared behaviour. `plugin.json` updated. `validate-skills.ps1` then `sync-local.ps1 -Prune`. |
| Next | Commit in this repo. Consuming installs pick it up on re-sync to that ref. |

## Related pages

- [Workflows](workflows.md)
- [Skills](skills.md)
- [Install](install.md)
