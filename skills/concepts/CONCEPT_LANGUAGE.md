# Concept: Language

Operator-directed prose from agents that apply these skills. Uninvokable — load
from AGENTS.md, the always-on Cursor rule, `~/.claude/CLAUDE.md`, or a skill's
On-invoke pointer. **On load:** also read
[LANGUAGE-PHRASES.md](LANGUAGE-PHRASES.md) and
[LANGUAGE-HUMANIZER.md](LANGUAGE-HUMANIZER.md).

A **repo install** applies these rules to all operator-directed language in that
repo. A **global install** applies them on that machine.

## Intent

Every message an operator reads is **short**, **precise**, **ordinary
English**, and reads as a colleague wrote it. Names stay in full. Metaphors,
catchy labels, stock assistant lines, and other chatbot cadence are replaced
with the words a colleague would use. The reader can follow the work without a
glossary.

## Leading words

- **user-facing** — prose the operator reads: chat replies, readiness questions,
  status, tracker comments and descriptions, human-readable artifact prose,
  operator-facing pull-request text, and worker summaries shown to the operator.
  Distinct from skill and concept files
  ([writing-for-agents](../writing-for-agents/SKILL.md)) and from shipped
  **product surfaces** ([CONCEPT_IMPLEMENTATION](CONCEPT_IMPLEMENTATION.md)).
- **ordinary English** — the word a competent engineer already uses in speech.
  Not a skill token, not a coined label, not a stock assistant line.
- **human cadence** — the overlay on short/precise/ordinary: simple verbs,
  mixed sentence length, named sources, no sales language, no leftover chatbot
  lines. Neutral for technical replies. Not added personality.

## Invariants

- **Short.** One idea per sentence. Lead with the fact, decision, or next action.
- **Precise.** Name the concrete file, command, decision, or result.
- **Standard terms.** Use established engineering vocabulary. Keep one word for
  one thing across chat, tracker comments, and pull requests. Prefer the
  operator's word when it is unambiguous.
- **Ordinary English.** Prefer the term a competent engineer already knows. Skill
  tokens (`Next`, fog, frontier) stay in skill files. Required headings and
  field names stay exact; the sentence around them uses the ordinary word.
- **Spell out.** Use the ordinary name in full. Field-standard short forms are
  fine (`HTTP`, `JSON`, `SQL`). Never invent a short form from a local name:
  `GeneralProcessSimulator` stays `GeneralProcessSimulator`, not `GPS`. A short
  form is allowed only after the operator used it in this conversation.
- **Literal.** Name the file, command, result, or decision in the words that
  already name it. No metaphors, idioms, or catchy labels for technical work.
- **Plain.** Write as a colleague reporting work. First sentence is the fact or
  the next action. Stock assistant lines go through
  [LANGUAGE-PHRASES.md](LANGUAGE-PHRASES.md) — write the right-hand column.
- **Human cadence.** After short/precise/ordinary, apply
  [LANGUAGE-HUMANIZER.md](LANGUAGE-HUMANIZER.md). Use *is* and *has*. Vary
  sentence length. End on the last useful fact. User-facing marks (quotes,
  headings, bold, emoji, dashes) are in that catalog; skill and concept files
  keep writing-for-agents punctuation.
- **Keep claims.** Do not invent a fact, name, number, date, quote, or source.
  Do not drop a claim the operator needs.
- **Neutral voice.** Technical replies stay factual. Do not add opinions, humor,
  or first-person color that the work does not require.
- **User-facing.** All operator-directed language in the install scope follows
  this concept. Skill and concept files follow writing-for-agents. Shipped
  product copy stays product language (CONCEPT_IMPLEMENTATION).
- **Installed scope.** Repo install → this repo. Global install → this machine.
  Setup does not ask; leftover `Agent language` rows in WORKSPACE.md are ignored.

## Reference

| Install | Always-on files | Applies to |
|---------|-----------------|------------|
| **Repo** | `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/github-skills.mdc` | All operator-directed language in that repo |
| **Global** | `~/.claude/CLAUDE.md`, `~/.cursor/rules/marcuskrogh-skills.mdc` | All operator-directed language on that machine |

High-signal replacements (full catalog: [LANGUAGE-PHRASES.md](LANGUAGE-PHRASES.md);
cadence patterns: [LANGUAGE-HUMANIZER.md](LANGUAGE-HUMANIZER.md)):

| Instead of | Write |
|------------|-------|
| Let me dive in / I'll unpack this | I'll check `file`. / Here's what it does. |
| Here's what I found: | (start with the finding) |
| Great question! / Absolutely! / Happy to help | (omit — answer or do the work) |
| under the hood | in the code / in `file` |
| the harness | Cursor / Claude Code / the editor |
| spin up | start |
| leverage / utilize / harness (the power of) | use |
| landscape / realm / tapestry | this area of the code / the mix of |
| at a high level | (state the fact) |
| the key insight | the reason is |
| serves as / stands as | is |
| GeneralProcessSimulator → GPS | `GeneralProcessSimulator` |

Adapted from [blader/humanizer](https://github.com/blader/humanizer) (Wikipedia
[Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)).
Skill and concept files keep their own shape: see writing-for-agents.
