# Concept: Alignment

Reach **fundamental agreement** with the user through relentless, adaptive
questioning. Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

Skills define *what* is aligned and *which artifact* results; this concept
defines *how*. Drive one question at a time until skill-relevant **divergences**
are resolved with the user, then present the artifact and readiness prompt.

## Invariants

- **One question per message.** Each user-facing turn asks exactly one question.
- **Start with the subject.** The first alignment message asks one question on the highest-value unresolved divergence. A single route line may sit above it. No scope lecture and no preview of later questions.
- **Opening names the subject.** The invoke message selects the topic. A probe is settled only when the user's own words state that decision (in the invoke or in a later answer). A paraphrase or a likely default is not that statement.
- **Shallow stays open.** An unstated skill probe is an open divergence. A short description names the subject. Naming the goal, the symptom, or a location does not by itself state the skill's probes.
- **Assumptions stay questions.** An unstated probe is asked before it appears as a decision in the artifact.
- **First turn waits.** That turn asks the one question, or — only when every in-play probe is already stated in the user's words and the skill sets a readiness prompt — presents the artifact and asks the readiness prompt. It stops there. Persistence of an approved artifact, final classify-and-bind, and later skills wait until the user answers.
- **Adaptive.** After each answer, revise agreed vs unknown; ask the next highest-value question.
- **Concrete.** Short questions; acknowledgments only when needed.
- **Relentless on divergence.** Prioritise ambiguities that would change the outcome; settled points stay settled.
- **User answers only.** Agent briefs orient **probes** — they settle divergences only when the skill contract authorizes another source.
- **Close with the user.** When the skill sets a readiness prompt, alignment ends when the user answers it in the affirmative. The opening message is not that answer.
- **Format overrides** change presentation only — adaptive single-question sequencing stays intact.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Subject** | must | What agent and user align on |
| **Probes** | must | Domain areas to cover |
| **Stop condition** | must | When alignment completes (default: no obvious skill-relevant divergences remain) |
| **Alignment artifact** | must | Format and filename when persisted |
| **Readiness prompt** | must | How to close after presenting the artifact |
| **Opening** | may | Thin vs rich first move |
| **Final clarification** | may | Last question(s) before the artifact |
| **Format override** | may | Labels, LaTeX-only blocks, etc. |
| **Scope guard** | may | Topics excluded during alignment |

## Flow

1. **Open** — Thin (any in-play probe unstated): one question on the highest-value gap. Use the skill opener when the subject itself is missing. Rich (every in-play probe already stated in the user's words): present the artifact and ask the readiness prompt, or ask the one remaining divergence. Done when that question is asked and the turn has stopped.
2. **Loop** — Ask → wait → revise agreed/unknown → repeat. Done when every in-play probe is stated by the user or explicitly deferred by the user.
3. **Close** — Final clarification (if any) → present artifact → **readiness prompt** (when the skill sets one). Gap named → resume loop. Approval → alignment ends. The opening message is not approval.
