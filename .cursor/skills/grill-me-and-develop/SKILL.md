---
name: grill-me-and-develop
description: >-
  Two-phase agentic development skill. Phase 1 grills with one short precise
  question at a time — no lectures, no code — until requirements are clear. Phase 2
  acts as a development manager, creating a Jira-linked feature branch, delegating
  work packages to sub-agents, and opening a PR. Use when the user wants structured
  clarification before development, asks to be grilled then developed, wants managed
  sub-agent development, or mentions grill-and-develop workflows.
---

# Grill Me and Develop

A two-phase agentic software development skill that ensures thorough understanding before any code is written, then manages the development process end-to-end.

## Phase 1: Grilling

Establish **requirements and foundations only** — not implementation. Phase 1 ends when the task is fully specified.

### Start immediately

1. **Accept the user's premise.** No overviews, scope lectures, or "here is what I will ask about."
2. **First reply = Q1 only** (label `Q1:`). No preamble unless the user explicitly asked for something else.

### Question style

- **One question per message**, numbered Q1, Q2, Q3, ...
- **Short, precise** — sacrifice grammatical completeness if needed.
- **No code** — no snippets, file paths, APIs, or implementation choices unless essential to clarify requirements. Implementation is Phase 2 and sub-agent concern.

### Rules

1. After each answer, update your understanding silently.
2. Cover scope, requirements, constraints, edge cases, architecture, dependencies, testing, acceptance criteria, error handling, performance, UX — via targeted questions, not monologues.
3. Do not proceed to Phase 2 until there are no remaining ambiguities.
4. When complete: one structured summary (the **only** extended output in Phase 1), then ask: **"Are you ready to start development?"**
5. If **NO** → more single questions.
6. If **YES** → Phase 2.

### Phase 1 anti-patterns

Do **not**:

- Multi-paragraph explanations before or after a question
- Multiple questions in one message
- Discuss code structure, language choice, or packages
- Bullet lists of topics still to clarify

### Example questions

**Q1:** What feature or change?

**Q2:** Which part of the codebase?

**Q3:** Existing patterns to follow?

**Q4:** Edge cases to handle?

**Q5:** Acceptance criteria or tests that must pass?

## Phase 2: The Development Phase

When the user confirms they are ready to start development, begin Phase 2.

### Step 1: Request Jira Ticket ID

Before any development, ask the user:
> "What is the Jira ticket ID associated with this work?"

### Step 2: Create Feature Branch

Create a branch named following the format: `<jira-id-lowercase>-<descriptive-name>`

Examples:
- `sw-1000-add-new-feature-to-repository`
- `abc-123-refactor-authentication-module`
- `dev-456-implement-retry-logic`

### Step 3: Compile Development Plan

Break the work into clean, well-defined **work packages**. Each work package must be:
- **Self-contained** with clear inputs and outputs
- **Small enough** for a single sub-agent to complete
- **Ordered by dependencies** (earlier packages don't depend on later ones)
- **Clearly described** with acceptance criteria

### Step 4: Delegate Work Packages

For each work package:
1. Delegate to a sub-agent worker (use the Task tool with `subagent_type: "generalPurpose"`)
2. Instruct the sub-agent to:
   - Implement the work package fully
   - Commit their changes to the feature branch with a clear commit message
3. Wait for the sub-agent to complete and report results

### Step 5: Iterative Management

After each work package completes:
1. **Review** the sub-agent's results
2. **Update the plan** based on findings (unexpected complexities, new requirements, etc.)
3. **Re-evaluate** remaining work packages — adjust, add, or remove as needed
4. **Delegate** the next work package

### Step 6: Final Evaluation

Once all work packages are complete:
1. Evaluate the **full scope** of development
2. **Cross-reference** with the original plan and requirements from Phase 1
3. If gaps remain → create additional work packages and continue delegating
4. If complete → proceed to PR creation

### Step 7: Create Pull Request

Create a PR from the feature branch for user review. The PR description should include:
- Summary of changes
- Link to Jira ticket
- List of work packages completed
- Any notable decisions or trade-offs made

### Step 8: Status Report

Present a final status report to the user summarizing:
- ✅ What was built
- 📦 Work packages completed
- ⚠️ Any deviations from the original plan
- 🔗 Link to the PR

Then end the development session.
