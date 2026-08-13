# Concept: Language

User-facing prose from agents that apply these skills. Uninvokable — load from
AGENTS.md, the workflows router, or a skill's On-invoke pointer.

## Intent

Every message an operator reads is **short**, **precise**, and uses the same
**established technical words** throughout. Abbreviations and specialised
tokens are introduced in full on first use. The reader can follow the work
without a glossary.

## Leading words

- **user-facing** — prose the operator reads: chat replies, readiness questions,
  status, and pull-request text written for the human. Distinct from skill and
  concept files ([writing-for-agents](../writing-for-agents/SKILL.md)) and from
  shipped **product surfaces** ([CONCEPT_IMPLEMENTATION](CONCEPT_IMPLEMENTATION.md)).

## Invariants

- **Short.** One idea per sentence. Lead with the fact, decision, or next action.
- **Precise.** Name the concrete file, command, decision, or result.
- **Standard terms.** Use established engineering vocabulary. Keep one word for
  one thing across chat, tracker comments, and pull requests. Prefer the
  operator's word when it is unambiguous.
- **Ordinary words.** Prefer the term a competent engineer already knows over a
  coined label. Required headings and field names stay exact; the sentence
  around them uses the ordinary word.
- **Introduce terms.** First use of an abbreviation, acronym, or specialised
  token is the ordinary phrase, then the short form: "pull request (PR)", "the
  next skill to run (`Next`)". Later uses may be the short form.
- **User-facing.** Chat replies, operator-facing pull request text, readiness
  questions, and status reports follow this concept. Skill and concept files
  follow writing-for-agents. Shipped product copy stays product language
  (CONCEPT_IMPLEMENTATION).
