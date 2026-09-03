# Language humanizer

Disclosed from [CONCEPT_LANGUAGE](CONCEPT_LANGUAGE.md). Load with that concept
and from [writing-for-agents](../writing-for-agents/SKILL.md) when editing skill
or concept prose.

Rewrite chatbot cadence so the text reads as a colleague wrote it. Do not
change what it says. Do not invent details.

Adapted from [blader/humanizer](https://github.com/blader/humanizer) and
Wikipedia [Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing).

## Scope

| Surface | Apply | Leave alone |
|---------|-------|-------------|
| **User-facing** (chat, tracker comments, operator PR text) | All rows below | Code, YAML, link targets, required field names |
| **Skill / concept files** | Content patterns, filler, leftover chatbot, simple verbs | Bold leading words, tables, required headings, em dashes used as skill punctuation |

Technical replies stay **neutral**. Do not add personality, humor, or opinions
to make the text feel human.

## Content

| Pattern | Instead of | Write |
|---------|------------|-------|
| Inflated importance | marking a pivotal moment; a vital/crucial role; testament to; evolving landscape | the fact, with no legacy claim |
| Shallow *-ing* clause | highlighting / underscoring / ensuring / reflecting / showcasing (as a tacked-on clause) | drop the clause; keep the fact |
| Sales language | boasts, vibrant, nestled, groundbreaking, stunning, must-visit | the literal description |
| Unnamed experts | Experts argue; Observers have cited; Industry reports (unnamed) | name the source, or drop the claim |
| Formulaic outlook | Despite these challenges… continues to thrive; Future Outlook | the concrete problem or plan, or omit |
| Formulaic saying | X is the Y of Z; X is not a tool but a mirror | the specific claim |
| Pretending to reveal | The real question is; at its core; what really matters | the actual question or fact |
| Answering unraised objections | I'm not saying…; This isn't mainly about…; Don't get me wrong | the claim the sentence was defending |
| Rejecting a fake alternative | A tempting approach would be… but | the real constraint only |
| Generic positive ending | Exciting times lie ahead; a major step in the right direction | (end on the last useful fact) |

## Grammar and rhythm

| Pattern | Instead of | Write |
|---------|------------|-------|
| Avoiding *is* / *are* | serves as; stands as; marks; represents; boasts; features; offers | is / are / has |
| Not X but Y | It's not just X, it's Y; Not only… but… | the Y claim, once |
| Forced group of three | innovation, inspiration, and industry insights (padded) | the items that exist |
| Synonym cycling | the protagonist / the main character / the hero | one name |
| False from-X-to-Y | from the Big Bang to dark matter (not a range) | the list of topics |
| Passive with no actor | The results are preserved automatically | Who preserves them |
| Too many qualifiers | could potentially possibly be argued | the claim, with one real hedge if needed |
| Hyphen only where grammar needs it | the report is high-quality | the report is high quality |

## Chatbot leftover

| Pattern | Instead of | Write |
|---------|------------|-------|
| Greeting / closer | I hope this helps; Let me know if…; Would you like… | (omit) |
| Agreeable opener | Great question!; You're absolutely right | (answer) |
| Knowledge-cutoff filler | as of my last update; based on available information; it is believed that | what the source shows, or that it does not show it |
| Announcing the next point | Let's dive in; Here's what you need to know; Without further ado | (state the point) |
| Fake-candid hook | Honestly?; Look,; Here's the thing; Real talk | (state the point) |
| Heading restated | `## Performance` then "Speed matters." | the first useful sentence under the heading |
| Writing about the old version | This was added to replace the previous approach of… | current behaviour (unless the doc is a changelog) |

## Marks (user-facing only)

| Pattern | Instead of | Write |
|---------|------------|-------|
| Em / en dash | ` — ` ` – ` `--` | comma, period, colon, or parentheses |
| Decorative bold | bold on ordinary phrases | bold only a file, command, or result |
| Bold mini-headings in a list | `- **Performance:** …` | a sentence, or a list without the bold label |
| Title-case heading | `## Strategic Negotiations` | `## Strategic negotiations` |
| Decorative emoji | 🚀 Launch Phase | the words |
| Curly quotes | “the project” | "the project" |

Skill and concept files may keep bold leading words, labeled tables, and em
dashes. Product surfaces follow [CONCEPT_IMPLEMENTATION](CONCEPT_IMPLEMENTATION.md).

## Keep

Do not treat polish, one *however*, one short sentence, or a real disclaimer as
proof of chatbot cadence. Keep mixed feelings the operator stated, named
objections, legal and safety notices, and quotations. One em dash in a pasted
quote is not a rewrite target.

When unsure, look for several patterns together.

## Check

Before sending user-facing prose:

1. What still sounds like a chatbot?
2. Did this add or drop a fact, name, number, date, quote, or source?

Treat an unsupported addition or a lost claim as an error. If a sentence stays
awkward, rewrite the paragraph around its main point.
