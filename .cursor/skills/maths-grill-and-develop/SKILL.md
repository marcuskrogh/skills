---
name: maths-grill-and-develop
description: >-
    Two-phase applied mathematics development skill. Phase 1 grills the user on mathematical foundations
    (models, notation, algorithms) until full understanding. Phase 2 creates DOCUMENTATION.md as the
    mathematical contract, then manages development via sub-agents and opens a PR. Use when the user wants
    structured mathematical clarification before development, or wants managed sub-agent development of
    mathematical software with a Jira-linked branch.
---

# Maths Grill and Develop

A two-phase agentic development skill for **applied mathematical software**. Phase 1 ensures a rigorous (but practical) mathematical foundation is established before any code is written. Phase 2 manages development end-to-end, anchored by a `DOCUMENTATION.md` that serves as the mathematical contract.

## Phase 1: The Mathematical Grilling Phase

Your goal is to reach a **complete, unambiguous understanding** of the applied mathematics underpinning what the user wants to build. You must ask clarifying questions relentlessly until there are no remaining mathematical ambiguities.

### Guiding Principles

- Focus on **applied mathematics**. Do not get lost in pure-math rigour — stay engineering-oriented.
- Prefer **concise notation and precision** over grammatical completeness.
- Cover: model formulation, governing equations, algorithmic choices (solvers, integration schemes, estimation methods, OCP formulations), convergence criteria (when mathematically relevant), and high-level numerical considerations.
- Do NOT dig into tuning or implementation details unless they are of particular mathematical importance.
- Use the **Default Notation Reference** below as the shared baseline. Only clarify deviations or domain-specific additions during the grilling.

### Rules for Phase 1

1. Ask **ONE question at a time**, numbered sequentially: Q1, Q2, Q3, ...
2. Questions must be **short, direct, and focused** on a single mathematical point.
3. After each answer, internally update your mathematical specification.
4. Cover **all relevant aspects**: model type (ODE/SDE/DAE/SDAE), state/input/output structure, constraints, objective functions, numerical schemes, estimation architecture, control formulation.
5. Do NOT proceed to development until you are confident the mathematical foundations are **fully specified**.
6. When you believe you have enough information, **summarize the full mathematical specification** in a structured format using correct notation and ask: **"Are you ready to start development?"**
7. If the user says **NO**, update and continue clarifying.
8. If the user says **YES**, transition to Phase 2.

### Example Grilling Questions

- Q1: What type of mathematical model are we working with? (ODE, SDE, DAE, SDAE, linear, nonlinear?)
- Q2: What are the state variables, inputs, disturbances, and outputs?
- Q3: What is the objective — simulation, estimation, control, optimization?
- Q4: What numerical integration scheme should we use?
- Q5: Are there constraints? How should they be formulated?

---

## Default Notation Reference

This is the agreed-upon notation baseline. Deviations should be clarified during the grilling phase.

### General

- Scalars: lowercase or Greek letters (e.g. $a$, $\alpha$)
- Vectors: lowercase (e.g. $x$, $u$)
- Matrices: uppercase (e.g. $A$, $Q$) — not bold, not italic
- Transpose: $A^{T}$
- Inverse: $A^{-1}$
- 2-norm (weighted): $\|x\|_{Q} = x^{T} Q x$
- 1-norm: $|x|$
- Inner product: $x^{T} y$
- Outer product: $x y^{T}$

### Calculus & Differential Equations

- Ordinary derivative: $\frac{dx}{dt}$
- Partial derivative: $\frac{\partial f}{\partial x}$
- Gradient: $\nabla f$
- Divergence: $\nabla \cdot$
- Curl: $\nabla \times$
- Integral: $\int_{a}^{b} f(x) \, dx$
- Continuous-time variables: $x(t)$, $u(t)$, $d(t)$
- Discrete-time variables: $x_{k}$, $u_{k}$, $d_{k}$
- Parameters: $p$

### ODE Models

**Continuous-time:**

$$\frac{dx(t)}{dt} = f(x(t), u(t), d(t), p)$$

$$z(t) = h(x(t), u(t), d(t), p)$$

$$y^{m}(t_{k}) = g^{m}(x(t_{k}), u(t_{k}), d(t_{k}), p)$$

**Discrete-time:**

$$x_{k+1} = f(x_{k}, u_{k}, d_{k}, p)$$

$$z_{k} = h(x_{k}, u_{k}, d_{k}, p)$$

$$y^{m}_{k} = g^{m}(x_{k}, u_{k}, d_{k}, p)$$

### SDE Models (Itô)

**Continuous-time:**

$$dx(t) = f(x(t), u(t), d(t), p) \, dt + \sigma(x(t), u(t), d(t), p) \, dw(t), \quad dw(t) \sim \mathcal{N}(0, dt \, I)$$

$$z(t) = h(x(t), u(t), d(t), p)$$

$$y^{m}(t_{k}) = g^{m}(x(t_{k}), u(t_{k}), d(t_{k}), p) + v(t_{k}), \quad v(t_{k}) \sim \mathcal{N}(0, R)$$

**Discrete-time:**

$$x_{k+1} = f(x_{k}, u_{k}, d_{k}, p) + \sigma(x_{k}, u_{k}, d_{k}, p) \, w_{k}, \quad w_{k} \sim \mathcal{N}(0, Q)$$

$$z_{k} = h(x_{k}, u_{k}, d_{k}, p)$$

$$y^{m}_{k} = g^{m}(x_{k}, u_{k}, d_{k}, p) + v_{k}, \quad v_{k} \sim \mathcal{N}(0, R)$$

### DAE Models

**Continuous-time (ODE + algebraic constraint):**

$$\frac{dx(t)}{dt} = f(x(t), y(t), u(t), d(t), p)$$

$$0 = g(x(t), y(t), u(t), d(t), p)$$

$$z(t) = h(x(t), y(t), u(t), d(t), p)$$

$$y^{m}(t_{k}) = g^{m}(x(t_{k}), y(t_{k}), u(t_{k}), d(t_{k}), p) + v(t_{k}), \quad v(t_{k}) \sim \mathcal{N}(0, R)$$

Where $y(t)$ denotes algebraic variables.

### SDAE Models (Itô)

**Continuous-time:**

$$dx(t) = f(x(t), y(t), u(t), d(t), p) \, dt + \sigma(x(t), y(t), u(t), d(t), p) \, dw(t), \quad dw(t) \sim \mathcal{N}(0, dt \, I)$$

$$0 = g(x(t), y(t), u(t), d(t), p)$$

$$z(t) = h(x(t), y(t), u(t), d(t), p)$$

$$y^{m}(t_{k}) = g^{m}(x(t_{k}), y(t_{k}), u(t_{k}), d(t_{k}), p) + v(t_{k}), \quad v(t_{k}) \sim \mathcal{N}(0, R)$$

### Linear Systems

**Continuous-time ODE:**

$$\frac{dx(t)}{dt} = A_{c} x(t) + B_{c} u(t) + E_{c} d(t)$$

**Continuous-time SDE:**

$$dx(t) = (A_{c} x(t) + B_{c} u(t) + E_{c} d(t)) \, dt + G_{c} \, dw(t), \quad dw(t) \sim \mathcal{N}(0, dt \, I)$$

**Discrete-time ODE:**

$$x_{k+1} = A x_{k} + B u_{k} + E d_{k}$$

**Discrete-time SDE:**

$$x_{k+1} = A x_{k} + B u_{k} + E d_{k} + G w_{k}, \quad w_{k} \sim \mathcal{N}(0, Q)$$

**Output (controlled):**

$$z(t) = C_{z} x(t) + D_{z} u(t)$$

**Measurement:**

$$y^{m}(t_{k}) = C x(t_{k}) + D u(t_{k}) + F d(t_{k}) + v(t_{k}), \quad v(t_{k}) \sim \mathcal{N}(0, R)$$

When using both continuous and discrete-time, continuous-time matrices carry subscript $c$ (e.g. $A_{c}$), discrete-time are unsubscripted (e.g. $A$).

### State Estimation

- True state: $x$
- State estimate: $\hat{x}$
- One-step prediction: $\hat{x}_{k+1|k}$
- Filtered estimate: $\hat{x}_{k|k}$
- Covariance (filtered): $P_{k|k}$
- Covariance (predicted): $P_{k+1|k}$
- Kalman gain: $K_{k}$
- Process noise: $w(t)$ (CT), $w_{k}$ (DT)
- Measurement noise: $v(t_{k})$ (CT), $v_{k}$ (DT)

Same conditional notation applies to outputs, measurements, and other estimated quantities (e.g. $z_{k|k}$, $y^{m}_{k|k-1}$).

### Optimization (Nocedal & Wright conventions)

- Objective: $\varphi = f(x)$
- Optimal value: $x^{*}$
- Constraints (combined): $c_{l} \leq c(\cdot) \leq c_{u}$
- Constraints (separate): $c_{l} \leq c_{\text{ineq}}(\cdot) \leq c_{u}$, $c_{\text{eq}}(\cdot) = 0$
- Lagrangian: $L(x, \lambda)$
- Equality multipliers: $\lambda$
- Inequality multipliers: $\mu$

### Optimal Control (Bolza Form)

- Lagrange term: $l(\cdot)$
- Mayer term: $\hat{l}(\cdot)$

### Model Predictive Control (MPC)

- Prediction horizon: $N_{z}$
- Control horizon: $N_{u}$
- When equal: $N = N_{z} = N_{u}$
- Quadratic weights: $Q_{z}$ (tracking), $Q_{s}$ (slack), $Q_{\Delta u}$ (input rate-of-move)
- Linear weights (vectors): $q_{u}$, $q_{\text{eco}}$, etc.
  - e.g. $q_{u}^{T} u_{k}$ for price-scaled input cost

### Discretization & Numerical Methods

- Simulation time step: $\Delta t$
- Control sample time: $T_{s}$
- Discrete time grid: $k \in \{0, 1, \ldots, N\}$
- ODE/DAE: explicit or implicit Euler with substepping
- SDE/SDAE: explicit or implicit-explicit Euler-Maruyama with substepping

---

## Phase 2: The Development Phase

When the user confirms they are ready to start development, begin Phase 2.

### Step 1: Request Jira Ticket ID

Before any development, ask the user:
> "What is the Jira ticket ID associated with this work?"

### Step 2: Create Feature Branch

Create a branch named following the format: `<jira-id-lowercase>-<descriptive-name>`

Examples:
- `sw-1000-implement-ekf-estimator`
- `abc-123-mpc-controller-with-soft-constraints`
- `dev-456-sdae-simulation-module`

### Step 3: Create and Commit DOCUMENTATION.md

Before any development work packages, create a `DOCUMENTATION.md` file in the repository root. This file captures the **complete mathematical specification** from Phase 1, including:

- Problem statement
- Model formulation (with full equations)
- Notation used (referencing the default, noting any deviations)
- Assumptions and constraints
- Algorithmic choices (solvers, integration schemes, estimation methods)
- Numerical considerations

Commit this as the **first commit** on the feature branch. This serves as the mathematical contract — all sub-agents must reference and adhere to it.

### Step 4: Compile Development Plan

Break the work into clean, well-defined **work packages**. Each work package must be:
- **Self-contained** with clear inputs and outputs
- **Small enough** for a single sub-agent to complete
- **Ordered by dependencies** (earlier packages don't depend on later ones)
- **Clearly described** with acceptance criteria
- **Anchored** to specific sections of `DOCUMENTATION.md`

### Step 5: Delegate Work Packages

For each work package:
1. Delegate to a sub-agent worker (use the `task` tool with `agent_type: "general-purpose"`)
2. Instruct the sub-agent to:
   - Read and reference `DOCUMENTATION.md` for mathematical foundations
   - Implement the work package fully, adhering to the mathematical specification
   - Commit their changes to the feature branch with a clear commit message
3. Wait for the sub-agent to complete and report results

### Step 6: Iterative Management

After each work package completes:
1. **Review** the sub-agent's results against `DOCUMENTATION.md`
2. **Verify** mathematical correctness of the implementation
3. **Update the plan** based on findings (unexpected complexities, new requirements, etc.)
4. **Re-evaluate** remaining work packages — adjust, add, or remove as needed
5. **Delegate** the next work package

### Step 7: Final Evaluation

Once all work packages are complete:
1. Evaluate the **full scope** of development
2. **Cross-reference** with `DOCUMENTATION.md` and the original mathematical specification from Phase 1
3. If gaps remain → create additional work packages and continue delegating
4. If complete → proceed to PR creation

### Step 8: Create Pull Request

Create a PR from the feature branch for user review. The PR description should include:
- Summary of changes
- Link to Jira ticket
- Reference to `DOCUMENTATION.md` for mathematical foundations
- List of work packages completed
- Any notable decisions or trade-offs made

### Step 9: Status Report

Present a final status report to the user summarizing:
- ✅ What was built
- 📐 Mathematical specification adherence
- 📦 Work packages completed
- ⚠️ Any deviations from the original mathematical specification
- 🔗 Link to the PR

Then end the development session.
