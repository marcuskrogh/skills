# Concept: Alignment

Reach **fundamental agreement** with the user through relentless, adaptive
questioning. Uninvokable — load only when a skill's On-invoke pointer fires.

Skills define *what* is aligned and *which artifact* results; this concept
defines *how*.

## Leading words

- **divergence** — choice where multiple valid paths exist and a wrong
  assumption wastes rework or yields the wrong artifact
- **alignment** — one-question loop until skill-relevant divergences are
  resolved with the user
- **probe** — domain question area; selection still prefers highest-value
  unresolved divergence

## Invariants

- **One question per message.** No batches, questionnaires, or upcoming-question previews.
- **Start with the subject.** First message is a question — no preamble or plan lecture.
- **Adaptive.** After each answer, revise agreed vs unknown; ask the next highest-value question.
- **Concrete.** Short questions; acknowledgments only when needed.
- **Relentless on divergence.** Prioritise ambiguities that would change the outcome; do not re-ask settled points.
- **User answers only.** Agent briefs (research, roadmaps, models) orient probes — they do not settle divergences unless the skill's contract says otherwise.
- **Format overrides change presentation only** — never one-question-per-message or adaptive sequencing.

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

1. **Open** — Thin: one broad opener (skill wording). Rich (user already answered in-session or on invoke): skip broad opener; first question on an unresolved divergence. Done when the first question is asked.
2. **Loop** — Ask → wait → revise agreed/unknown → repeat. Done when **stop condition** holds.
3. **Close** — Final clarification (if any) → present artifact → **readiness prompt**. Gap named → resume loop. Approval → alignment ends.
