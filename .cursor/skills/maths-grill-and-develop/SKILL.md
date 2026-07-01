---
name: maths-grill-and-develop
description: >-
    Two-phase applied mathematics development skill. Phase 1 asks one short question per message as a
    single LaTeX display block (entire question in math mode) — no lectures, no code — until foundations
    are complete. Phase 2 creates DOCUMENTATION.md as the mathematical contract, then manages development
    via sub-agents and opens a PR. Use when the user wants structured mathematical clarification before
    development, or wants managed sub-agent development of mathematical software with a Jira-linked branch.
---

# Maths Grill and Develop

A two-phase agentic development skill for **applied mathematical software**. Phase 1 ensures a rigorous (but practical) mathematical foundation is established before any code is written. Phase 2 manages development end-to-end, anchored by a `DOCUMENTATION.md` that serves as the mathematical contract.

## Phase 1: Mathematical Grilling

Establish **mathematical foundations only** — not implementation. Phase 1 ends when the maths is fully specified.

### Start immediately

1. **Accept the user's premise.** No overviews, lectures, notation summaries, topic lists, or "here is how we will proceed."
2. **First reply = one LaTeX display question only.** No preamble unless the user explicitly asked for something else.
3. Use [reference.md](reference.md) internally for notation when phrasing questions. **Never** present or dump that reference to the user during Phase 1.

### Question style

- **One question per message**, numbered Q1, Q2, Q3, ...
- **Short, precise** — sacrifice grammatical completeness if needed.
- **No code** — no snippets, file paths, APIs, libraries, languages, or implementation choices unless mathematically essential. Implementation is Phase 2 and sub-agent concern.

### LaTeX-only questions (mandatory)

Each Phase 1 message to the user contains **exactly one** display-math block and **nothing else** (except when the user explicitly asked for something else).

Use `aligned` so content fits the chat width, equations sit on their own lines, and **relation symbols align in columns**:

$$
\begin{aligned}
\textbf{Q$n$:} \quad & \text{Short prose line.} \\
\frac{dx}{dt} &= f(x,u) \\
\text{Closing question?} &
\end{aligned}
$$

**Structure:**

1. Entire question — label, words, symbols, equations — inside a single `$$ ... $$` block.
2. Wrap body in `\begin{aligned} ... \end{aligned}`; use `\\` between lines.
3. Question label on the first line: `\textbf{Q1:} \quad & \text{...}`.
4. **Every equation on its own line** — never inline with prose on the same line.
5. Prose in short `\text{...}` chunks (roughly one clause per line); avoid one long horizontal line.
6. **No markdown** outside the block.
7. **No backticks or code fences** anywhere in the message.

**Relation alignment (mandatory):**

Use extra `&` columns so **all parallel structure lines up vertically**.

*Primary relation* — align `=`, `\le`, `\ge`, `:=` across stacked equations:

1. Pattern: `lhs &= rhs` — ampersand **immediately before** the relation.
2. **Wrong:** `& x_{k+1} = A x_k`. **Right:** `x_{k+1} &= A x_k`.

*Distribution clauses* — when a line has dynamics **and** a noise/law (e.g. SDE, state-space), put the distribution in a **second aligned block** on the same line:

3. Pattern: `lhs &= rhs, & \eta &\sim \mathcal{D}(\cdot)` — align all `\sim` (or `\mid`) in one column and noise symbols (`w_k`, `v_k`, `dw`) in the column before it.
4. Stack lines so dynamics `=` **and** distributions `\sim` both align:

$$
\begin{aligned}
x_{k+1} &= A x_k + w_k, & w_k &\sim \mathcal{N}(0,Q) \\
y_k^{m} &= C x_k + v_k, & v_k &\sim \mathcal{N}(0,R)
\end{aligned}
$$

*Index / iterator clauses* — when a line has a relation **and** an index set (e.g. $t_a \le t_k \le t_b$, $k \in \{0,\ldots,N\}$), use a **second aligned block**:

5. Pattern: `t_a &\le t_k \le t_b, & k &\in \{0,1,\ldots,N\}` — align primary `\le`/`\ge`/`\in` across lines; align index symbols ($k$, $m$, …) and their sets in the next columns.
6. Stack lines so both the time/spatial relation **and** the iterator spec align:

$$
\begin{aligned}
t_a &\le t_k \le t_b, & k &\in \{0,1,\ldots,N\} \\
\Delta t_k &= t_{k+1}-t_k, & k &\in \{0,1,\ldots,N-1\}
\end{aligned}
$$

*Combined* — SDE with aligned distribution on one line:

7. Pattern: `dx &= f(x,u)\,dt + \sigma(x,u)\,dw, & dw &\sim \mathcal{N}(0,\,dt\,I)`.

8. Prose-only lines and single-equation questions without side clauses: primary alignment only.

**Layout rules (fit chat window):**

1. Use `aligned` with `\\` between **logical** lines — not every clause.
2. **Prose:** one `\text{...}` line per sentence or question (do not split mid-sentence unless overflow).
3. **Equations:** each displayed relation on its **own** line; keep the full relation on **one** line (e.g. full Itô SDE on one line).
4. Typical shape: label + intro text → aligned equation line(s) → closing question text.
5. Target 3–4 lines for most questions; add breaks only when a line would overflow.

**Definition hierarchy (mandatory):**

When a question embeds a **model**, **optimiser**, **estimator**, or any object with layered definitions, present it **top-down** — never flatten or jump ahead to explicit functions.

1. **Level 0 — problem class shell:** state the full top-level structure with abstract function slots only (e.g. $f$, $\sigma$, $h$, $g^{m}$, $l$, $l_{f}$) — **do not** expand any of them yet.
2. **Level 1 — symbols:** $x$, $u$, $p$, dimensions, index sets ($k \in \{\ldots\}$) if not already in the shell.
3. **Level 2+ — expand one block at a time**, in dependency order, each under an italic section header:
   - drift / dynamics $f(\cdot)$, then any **sub-definitions** it needs (e.g. $\mu(S)$ before $f$ uses it);
   - diffusion $\sigma(\cdot)$;
   - output $h(\cdot)$, measurement $g^{m}(\cdot)$;
   - for OCP: stage cost $l(\cdot)$, terminal $l_{f}(\cdot)$, constraints $c(\cdot)$ — each with sub-definitions as needed.
4. Separate hierarchy levels with `\\[6pt]`; keep relation alignment within each level.
5. **One closing question** targeting the single open choice — not a survey of the whole model.
6. Short grilling questions without a proposed formulation: still respect hierarchy when the user asks to see structure (shell first, expand in later questions).

**Hierarchy anti-patterns:**

- Defining $\mu(S)$ or $f_1,f_2,f_3$ before the top-level SDE/OCP shell is shown
- Mixing shell, symbols, and expanded functions in one undifferentiated list
- Expanding all functions when only one block is under discussion

**Hard rules:**

1. Mixed markdown + inline `$...$` questions are **forbidden**.
2. Never duplicate a quantity as plain text and as math.
3. Non-mathematical clarifications use the same aligned LaTeX block.
4. Phase 1 closing summary: one or more aligned `$$ ... $$` blocks; equations on separate lines.
5. Closing readiness check:

$$
\begin{aligned}
\textbf{Q$n$:} \quad & \text{Ready to start development?}
\end{aligned}
$$

### Scope

- Applied mathematics: models, governing equations, algorithmic choices (solvers, integration, estimation, OCP), convergence where relevant, high-level numerical structure.
- Not pure-math rigour for its own sake.
- Not tuning or implementation unless of direct mathematical importance.

### Rules

1. After each answer, update the internal mathematical specification silently.
2. Cover model type, state/input/output structure, constraints, objectives, numerical schemes, estimation/control/optimization — via targeted questions, not monologues.
3. Do not proceed to Phase 2 until foundations are unambiguous.
4. When complete: structured summary in LaTeX display blocks only — use the **definition hierarchy** (shell → symbols → expanded blocks); then the readiness question.
5. If **NO** → more single questions.
6. If **YES** → Phase 2.

### Phase 1 anti-patterns

Do **not**:

- Multi-paragraph explanations before or after a question
- Multiple questions in one message
- Walk through notation templates or equation families upfront
- Discuss code structure, language choice, or packages
- Bullet lists of topics still to clarify
- Any plain-text or markdown outside `$$ ... $$` in a grilling message
- Mixed markdown + inline math questions

- Aggressive line breaks (splitting one equation or one sentence across multiple lines)
- Multiple equations with unaligned relation symbols (never use `& lhs = rhs`; use `lhs &= rhs`)
- Distribution or iterator side clauses run together without column alignment (never `\quad dw \sim` when a stacked block uses `& dw &\sim`)

### Example questions

Copy these patterns (agent output = one block only):

$$
\begin{aligned}
\textbf{Q1:} \quad & \text{ODE, SDE, DAE, or SDAE?} \\
& \text{Linear or nonlinear } f\text{?}
\end{aligned}
$$

$$
\begin{aligned}
\textbf{Q2:} \quad & \text{State } x\text{, input } u\text{, disturbance } d \\
& \text{Symbols and dimensions?}
\end{aligned}
$$

$$
\begin{aligned}
\textbf{Q3:} \quad & \text{Dynamics:} \\
\frac{dx}{dt} &= f(x,u,d,p) \\
& \text{Specify } f \text{ or reference known model?}
\end{aligned}
$$

$$
\begin{aligned}
\textbf{Q4:} \quad & \text{Well-mixed lumped CSTR in volume } V\text{?} \\
& \text{ODE model or spatial PDE?}
\end{aligned}
$$

$$
\begin{aligned}
\textbf{Q5:} \quad & \text{State } x \text{ — which species?} \\
x &= [S,\,X,\,P]^{T} \\
& \text{Symbols and units?}
\end{aligned}
$$

$$
\begin{aligned}
\textbf{Q6:} \quad & \text{Stochastic extension (Itô):} \\
dx &= f(x,u)\,dt + \sigma(x,u)\,dw, & dw &\sim \mathcal{N}(0,\,dt\,I) \\
& \text{Constant } G\text{, diagonal }\sigma_{ii}(x)\text{, or full }\sigma_{ij}(x,u)\text{?}
\end{aligned}
$$

$$
\begin{aligned}
\textbf{Q7:} \quad & \text{Linear-Gaussian state estimation:} \\
x_{k+1} &= A x_k + B u_k + w_k, & w_k &\sim \mathcal{N}(0,Q) \\
y_k^{m} &= C x_k + v_k, & v_k &\sim \mathcal{N}(0,R) \\
& \text{Kalman filter, EKF, UKF, or particle filter?}
\end{aligned}
$$

$$
\begin{aligned}
\textbf{Q8:} \quad & \text{Constraints:} \\
c_{\mathrm{eq}}(\cdot) &= 0 \\
c_{l} &\le c(\cdot) \le c_{u} \\
& \text{Or none?}
\end{aligned}
$$

$$
\begin{aligned}
\textbf{Q9:} \quad & \text{Sampling grid:} \\
t_a &\le t_k \le t_b, & k &\in \{0,1,\ldots,N\} \\
\Delta t_k &= t_{k+1}-t_k, & k &\in \{0,1,\ldots,N-1\} \\
& \text{Uniform } \Delta t \text{ or adaptive steps?}
\end{aligned}
$$

*Hierarchical proposed formulation — SDE (shell first, then expand):*

$$
\begin{aligned}
\textbf{Q10:} \quad & \text{Proposed Itô CSTR model — confirm diffusion } \sigma(x,u)\text{.} \\[6pt]
& \textit{Model class — Itô SDE} \\
dx &= f(x,u)\,dt + \sigma(x,u)\,dw, & dw &\sim \mathcal{N}(0,\,dt\,I) \\
z &= h(x,u) \\
y^{m}_k &= g^{m}(x(t_k),u(t_k)) + v_k, & v_k &\sim \mathcal{N}(0,\,R), & k &\in \{0,\ldots,N\} \\[6pt]
& \textit{Symbols} \\
x &= [S,\,X,\,P]^{T}, \quad u = [F,\,S_{\mathrm{in}}]^{T}, \quad D = F/V \\[6pt]
& \textit{Drift } f(x,u) \\
\mu(S) &= \mu_{\max}\,\frac{S}{K_s + S} \\
f(x,u) &= \begin{bmatrix} D(S_{\mathrm{in}} - S) - \mu(S)\,X / Y_{X/S} \\ \mu(S)\,X - D X \\ -D P + \nu_P\,\mu(S)\,X \end{bmatrix} \\[6pt]
& \textit{Diffusion } \sigma(x,u) \\
\sigma(x,u) &= \mathrm{diag}\!\left(\sigma_S\sqrt{|S|},\,\sigma_X\sqrt{|X|},\,\sigma_P\sqrt{|P|}\right) \\[6pt]
& \textit{Output and measurement} \\
z &= [S,\,X]^{T}, \quad g^{m}(x,u) = C\,x \\[6pt]
& \text{Keep diagonal } \sigma\text{, constant } G\text{, or full } \sigma_{ij}(x,u)\text{?}
\end{aligned}
$$

*Hierarchical proposed formulation — discrete-time OCP:*

$$
\begin{aligned}
\textbf{Q11:} \quad & \text{Proposed MPC — confirm terminal cost } l_{f}(x_{N})\text{.} \\[6pt]
& \textit{Problem class — discrete-time OCP} \\
\min_{\{u_k\}} \; & \sum_{k=0}^{N-1} l(x_k,u_k) + l_{f}(x_{N}) \\
\text{s.t.} \quad & x_{k+1} = f(x_k,u_k), & k &\in \{0,\ldots,N-1\} \\
& c_{l} \le c_{\mathrm{ineq}}(x_k,u_k) \le c_{u}, & c_{\mathrm{eq}}(x_k,u_k) &= 0 \\
& u_{\min} \le u_k \le u_{\max}, & k &\in \{0,\ldots,N-1\} \\[6pt]
& \textit{Symbols} \\
x_k &\in \mathbb{R}^{n}, \quad u_k \in \mathbb{R}^{m} \\[6pt]
& \textit{Stage cost } l(x_k,u_k) \\
z_k &= C_z x_k + D_z u_k \\
l(x_k,u_k) &= \|z_k - z_k^{\mathrm{ref}}\|_{Q_z}^{2} + \|u_k\|_{Q_u}^{2} \\[6pt]
& \textit{Terminal cost } l_{f}(x_{N}) \\
l_{f}(x_{N}) &= \|x_{N} - x_{\mathrm{ref}}\|_{P}^{2} \\[6pt]
& \text{Terminal cost } l_{f} \text{ as above, } l_{f} \equiv 0\text{, or steady-state Mayer term?}
\end{aligned}
$$

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
