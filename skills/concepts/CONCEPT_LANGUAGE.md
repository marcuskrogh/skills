# Concept: Language

User-facing prose from agents that apply these skills. Uninvokable — load from
AGENTS.md, the workflows router, or a skill's On-invoke pointer. Workspace
`Agent language` can widen the same rules to all operator-directed agent
language ([setup](../setup/SKILL.md)).

## Intent

Every message an operator reads is **short**, **precise**, and uses the same
**established technical words** throughout. Abbreviations and specialised
tokens are introduced in full on first use. The reader can follow the work
without a glossary. `/setup` can persist **general** application when the
operator wants that contract everywhere in the workspace.

## Leading words

- **user-facing** — prose the operator reads: chat replies, readiness questions,
  status, and pull-request text written for the human. Distinct from skill and
  concept files ([writing-for-agents](../writing-for-agents/SKILL.md)) and from
  shipped **product surfaces** ([CONCEPT_IMPLEMENTATION](CONCEPT_IMPLEMENTATION.md)).
- **general** — workspace-opted scope: every operator-directed agent utterance
  in this workspace (those surfaces, plus tracker comments and descriptions,
  human-readable artifact prose, and worker summaries shown to the operator).

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
- **Honor workspace.** Effective WORKSPACE `Agent language` is `user-facing`
  (default when unset) or `general`. When `general`, the other invariants apply
  to all operator-directed agent language in this workspace. Setup persists the
  field; skills do not re-ask unless the operator wants it changed.

## Reference

| `Agent language` | Applies the invariants to |
|------------------|---------------------------|
| **user-facing** | Chat, readiness questions, status, operator-facing pull request text |
| **general** | Those, plus tracker comments and descriptions, human-readable artifact prose, and worker summaries shown to the operator |
