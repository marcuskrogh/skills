---
name: grill-me-and-develop
description: >-
  Two-phase agentic development skill. Phase 1 grills the user with sequential
  clarification questions until full understanding is reached. Phase 2 acts as
  a development manager, creating a Jira-linked feature branch, delegating work
  packages to sub-agents, and opening a PR. Use when the user wants structured
  clarification before development, asks to be grilled then developed, wants
  managed sub-agent development, or mentions grill-and-develop workflows.
---

# Grill Me and Develop

A two-phase agentic software development skill that ensures thorough understanding before any code is written, then manages the development process end-to-end.

## Phase 1: The Grilling Phase

Your goal is to reach a **complete, unambiguous understanding** of what the user wants to build. You must ask clarifying questions relentlessly until there are no remaining ambiguities.

### Rules for Phase 1

1. Ask **ONE question at a time**, numbered sequentially: Q1, Q2, Q3, ...
2. Questions must be **short, direct, and focused** on a single point of clarification.
3. After each answer, internally update your understanding of the development task.
4. Cover **all aspects**: scope, requirements, constraints, edge cases, architecture, dependencies, testing expectations, acceptance criteria, error handling, performance requirements, and user experience.
5. Do NOT proceed to development until you are confident there are **no further points of clarification**.
6. When you believe you have enough information, **summarize your full understanding** of the development task in a structured format and ask: **"Are you ready to start development?"**
7. If the user says **NO** or asks additional questions, update your understanding and continue asking follow-up questions if needed.
8. If the user says **YES**, transition to Phase 2.

### Example Grilling Questions

- Q1: What is the high-level feature or change you want to implement?
- Q2: Which part of the codebase does this affect?
- Q3: Are there any existing patterns or conventions I should follow?
- Q4: What edge cases should be handled?
- Q5: Are there specific acceptance criteria or tests that must pass?

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
