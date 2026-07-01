---
name: grill-me
description: >-
  Grills the user with sequential, adaptive questions to resolve development
  ambiguities, then runs a management-agent development phase that delegates
  work packages to sub-agents until a PR is ready. Use when the user invokes
  /grill-me, asks to be grilled on a feature or development, or wants
  requirements clarified through questioning before implementation.
disable-model-invocation: true
---

# Grill Me

Interactive requirements grilling before development. One question at a time, adaptive to each answer, focused on decision forks the agent would otherwise assume.

## Core rules

- **One question per message.** Never present a numbered list of questions, a questionnaire, or a planned question batch. Never preview upcoming questions.
- **Adaptive.** After each answer, update your understanding, then ask the next question you still need answered.
- **Concrete and direct.** Short questions, short acknowledgments when needed. No chit-chat, filler, or conversational padding.
- **Prioritize divergence points.** Be relentless (within reason) on ambiguities, tradeoffs, and assumptions that would change implementation — places where you would otherwise guess.

## Opening

| Invocation | First move |
|------------|------------|
| **Thin context** — e.g. `/grill-me on a new development` | One broad opener to establish what is being built. Example: "What are you trying to build?" |
| **Rich context** — user already describes the development | Use that context. Skip the broad opener. Ask the first specific grilling question immediately. |

## Grilling loop

1. Ask one short, understandable question about the current unknown.
2. Wait for the answer.
3. Revise your mental model.
4. Repeat until no other **obvious** questions remain — especially at divergence points.

### What to probe

- Scope boundaries (in / out)
- UX and behavior where multiple valid implementations exist
- Data sources, ownership, and edge cases
- Compatibility with existing code or conventions
- Non-obvious constraints the user cares about
- Any decision where a wrong assumption would waste rework
- Delivery outcome — PR vs feature branch only (see Closing)

Do not nitpick settled points. Do not re-ask what the user already answered clearly.

## Closing

When obvious questions are exhausted:

1. Ask the **final delivery clarification** (one question): when development is done, should the agent **open a PR** or **stop at a feature branch**? Default to opening a PR if the user has no preference.
2. Present a **compact summary** of agreed scope, decisions, constraints, delivery outcome, and any remaining open items.
3. Ask: **"Ready to build?"**
4. If the user wants more investigation → resume the grilling loop from the gap they name.
5. If the user approves → treat the compact summary as the **development brief** and enter the **Development phase** immediately. Do not ask a separate "shall we start?" after approval.

## Development phase

Once the user and agent agree on the development task (via the compact summary), start the development phase. In this phase, act as a **management agent** — not as the sole implementer.

### Management agent role

- Own the **overall development plan** derived from the development brief.
- Break work into **work packages** — discrete, delegable units with clear scope, expected outputs, and acceptance criteria.
- **Delegate** each work package to a sub-agent (via the Task tool or project subagents in `.cursor/agents/`).
- **Evaluate** each sub-agent report against the work package and the plan.
- **Re-evaluate the plan** when results reveal new constraints, risks, or better sequencing — then delegate the next package.
- Repeat until development is **finalised**.
- **Open a feature branch** at the start of development for the management agent and all sub-agents to work in.
- **Open a PR** once development is finalised — **only if** the development brief says to open a PR (see Closing delivery clarification).

Stay in the management role throughout. Do not absorb sub-agent work into the main thread unless a package is trivially small or delegation fails after retry.

### Work package types

Delegate packages as needed — mix and sequence them based on the plan:

| Type | Examples |
|------|----------|
| Design study | UI/UX options, API shape, data model alternatives |
| Research | State-of-the-art survey, library comparison, prior art |
| Structure exploration | Codebase mapping, dependency analysis, architecture reconnaissance |
| Implementation | Feature code, refactors, migrations |
| Testing | Unit/integration tests, test plans, coverage gaps |
| Review | Code review, security review, spec-vs-implementation check |

Choose the subagent type and prompt to match the package (e.g. `explore` for reconnaissance, `generalPurpose` for implementation, `bugbot` / `security-review` for reviews).

### Development loop

```
1. Create feature branch from base (e.g. main)
2. Draft overall development plan from the brief
3. Select next work package
4. Delegate to a sub-agent with:
   - package scope and acceptance criteria
   - relevant context from the brief and prior packages
   - branch name and any files/areas to touch or avoid
5. Receive sub-agent report
6. Evaluate: does output satisfy the package? Does the plan still hold?
7. Update plan if needed; mark package done or re-delegate with corrections
8. Repeat from step 3 until all packages are complete and integrated
9. Final verification (tests, lint, brief checklist)
10. If brief says open PR → push branch and open PR with summary and test plan; otherwise stop on the feature branch and report status to the user
```

### Work package delegation prompt

Each delegation must be self-contained. Include:

- **Objective** — what this package must achieve
- **Inputs** — decisions, files, and findings from earlier packages
- **Constraints** — from the development brief (scope, style, dependencies)
- **Deliverables** — what to return (code, findings, recommendations, test results)
- **Branch** — feature branch name; sub-agents commit to this branch

### Evaluating sub-agent results

After each report:

1. Check deliverables against the package acceptance criteria.
2. Cross-reference with the overall plan — blocked, done, or plan change needed?
3. If insufficient: re-delegate with specific gaps named; do not silently fix large gaps in the management thread.
4. If plan assumptions were wrong: revise remaining packages before continuing.

### Feature branch and PR

**Branch** — create at development start, before the first delegation:

```bash
git checkout -b <type>/<short-description>
```

Use a descriptive name tied to the brief (e.g. `feat/forecast-chart-replacement`). All sub-agents work on this branch.

**PR** — when finalised and the brief specifies opening a PR:

- Push the feature branch
- Create PR with summary (from compact summary + what was built), and a test plan
- Return the PR URL to the user

If the brief says **branch only**, push the branch if needed, summarise what was done, and return the branch name — do not open a PR.

### Management agent anti-patterns

- Implementing large chunks of work directly instead of delegating
- Delegating without acceptance criteria or branch context
- Skipping plan re-evaluation after surprising sub-agent findings
- Starting work on `main` without a feature branch
- Ending development without the delivery outcome agreed in the brief (PR vs branch only)

## Anti-patterns

- Dumping 5+ questions in one message
- "Here are the questions I plan to ask…"
- Long preamble before the first question
- Starting the development phase before the user approves building
- Implementing everything inline instead of managing via work packages and sub-agents
- Skipping divergence points to move faster
- Human-like small talk ("Great question!", "Love that idea!")

## Examples

**Thin context**

User: `/grill-me on a new development`

Agent: What are you trying to build?

User: A new price forecast chart on the integration overview page.

Agent: Should the forecast replace the existing chart or appear alongside it?

**Rich context**

User: I want to develop a new version of the price forecast visualisation on the overview page of this integration.

Agent: Should the new version replace the current chart entirely, or run in parallel during a transition?

**Closing**

Agent: When development is done, should I open a PR or stop at a feature branch?

User: Open a PR.

Agent:

```markdown
## Compact summary
- Replace existing forecast chart on integration overview
- Horizon: 7 days; refresh on page load only
- Use existing `ForecastService`; no new API
- Match current card styling; no new dependencies
- Delivery: open PR when done

Ready to build?
```

User: Yes.

Agent:

1. Creates feature branch `feat/forecast-chart-replacement`
2. Drafts plan: (1) explore current chart + `ForecastService`, (2) implement replacement, (3) tests, (4) review
3. Delegates package 1 to an `explore` sub-agent → evaluates report → updates plan
4. Delegates package 2 to a `generalPurpose` sub-agent → evaluates diff against brief
5. Delegates package 3 (tests), then package 4 (review)
6. Opens PR with summary and test plan
