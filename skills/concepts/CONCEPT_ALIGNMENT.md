# Concept: Alignment

Reach **fundamental agreement** with the user through relentless, adaptive
questioning. Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

Skills define *what* is aligned and *which artifact* results; this concept
defines *how*. Drive one question at a time until skill-relevant **divergences**
are resolved with the user, then present the artifact and readiness prompt.

## Invariants

- **One question per message.** Each user-facing turn asks exactly one question.
- **Start with the subject.** First message is a question on the highest-value unresolved divergence.
- **Adaptive.** After each answer, revise agreed vs unknown; ask the next highest-value question.
- **Concrete.** Short questions; acknowledgments only when needed.
- **Relentless on divergence.** Prioritise ambiguities that would change the outcome; settled points stay settled.
- **User answers only.** Agent briefs orient **probes** — they settle divergences only when the skill contract authorizes another source.
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

1. **Open** — Thin: one broad opener (skill wording). Rich (user already answered in-session or on invoke): first question on an unresolved divergence. Done when the first question is asked.
2. **Loop** — Ask → wait → revise agreed/unknown → repeat. Done when **stop condition** holds.
3. **Close** — Final clarification (if any) → present artifact → **readiness prompt**. Gap named → resume loop. Approval → alignment ends.
