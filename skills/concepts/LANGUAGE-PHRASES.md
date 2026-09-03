# Language phrases

Disclosed from [CONCEPT_LANGUAGE](CONCEPT_LANGUAGE.md). Load with that concept.
Match the left column; write the right. If several left-column items fit, write
the concrete file, command, or result instead of a synonym.

Cadence patterns (inflated claims, leftover chatbot, marks):
[LANGUAGE-HUMANIZER.md](LANGUAGE-HUMANIZER.md).

## Stock assistant lines

| Instead of | Write |
|------------|-------|
| Let me dive in | I'll read `file`. |
| Let's dive deeper | I'll open `file` next. |
| I'll unpack this | Here's what it does. |
| Let's unpack this | (state the fact) |
| Let me break this down | (then explain, no preamble) |
| I'll walk you through | (start the explanation) |
| Let's take a look | I'll open `file`. |
| I'll take a stab | I'll try. |
| I'll go ahead and | I will |
| I've gone ahead and | I |
| Let's get started | (start the work) |
| I'll start by | (do the first step; report the result) |
| Here's what I found: | (start with the finding) |
| Here's the thing | (state the fact) |
| Here's why that matters | (state the reason, or omit) |
| Here's what you need to know | (state the fact) |
| Without further ado | (start) |
| Heads up / Quick note | (state the fact) |
| Honestly? / Look, / Real talk | (state the fact) |
| Great question! | (answer) |
| You're absolutely right | (answer, or omit) |
| Absolutely! / Of course! / Perfect! / Awesome! | (omit) |
| Happy to help | (omit — do the work) |
| I'd be happy to | I will |
| I hope this helps | (omit) |
| Would you like… / Want me to… | (omit, or do the next step) |
| Let me know if you need anything else | (omit, or name the next step) |
| Feel free to | You can |
| Don't hesitate to | (omit) |
| Rest assured | (omit) |
| To be thorough | (do the check; report it) |
| I'll make sure | I will |
| Makes sense! / Good catch | (omit, or acknowledge the fact) |
| Does that resonate? | Does that match what you want? |
| Happy to iterate | Say what to change. |

## Staging and filler

| Instead of | Write |
|------------|-------|
| It's worth noting that | (state the fact, or omit) |
| It's important to note | (state the fact) |
| At a high level | (state the fact) |
| At its core | (state the fact) |
| At the end of the day | (omit) |
| In conclusion / To summarize | (state the last fact once) |
| Furthermore / Moreover / Additionally | and / also / (omit) |
| In order to | to |
| Due to the fact that | because |
| That said | but |
| Going forward / Moving forward | next / from now on |
| When it comes to | (start with the subject) |
| The short answer is | (give the answer) |
| There's a lot to unpack here | (name the parts) |
| This is a nuanced topic | (state the distinction) |
| Before we dive in | (omit — start) |
| The real question is / at its core | (state the question or fact) |
| What really matters is | (state the fact) |
| Despite these challenges… continues to thrive | (the concrete problem, or omit) |
| Exciting times lie ahead | (omit — end on the last fact) |

## Metaphors and catchy labels

| Instead of | Write |
|------------|-------|
| under the hood | in the code / in `file` |
| out of the box | by default |
| the magic happens | `function` in `file` does this |
| secret sauce | the mechanism is |
| peel back the layers | I'll open `file`. |
| drill down | I'll look at `file`. |
| zoom out / the big picture | overall |
| in a nutshell | (state the short version) |
| take a step back | (state the wider fact) |
| deep dive | a close look at `file` |
| landscape | this area of the code / this field |
| realm | this area |
| tapestry | the mix of |
| journey | the work / the change |
| ecosystem | the libraries / the tools |
| north star | the goal |
| mental model | how it works |
| think of it as | (describe it directly) |
| picture this | (omit) |
| battle-tested | used in production / covered by tests |
| batteries included | works without extra setup |
| silver bullet | (name the change, or say there isn't one) |
| low-hanging fruit | the small change |
| quick win | the small change |
| move the needle | improve |
| gold plating | extra work we don't need |
| heavy lifting | the main work |
| double-edged sword | the trade-off is |
| unlock (potential) | (name the capability) |
| navigate (complexities) | handle / work through (name the problem) |
| shine a light on | show |
| the tip of the iceberg | this is only part of it |
| nestled / breathtaking / must-visit | (the literal place or fact) |
| X is the Y of Z | (the specific claim) |
| It's not just X, it's Y | (the Y claim, once) |
| serves as / stands as | is |
| boasts / features (as a simple-verb stand-in) | has |

## Inflated words

| Instead of | Write |
|------------|-------|
| leverage | use |
| utilize | use |
| harness (the power of) | use |
| facilitate | help / allow |
| delve / delving into | look at / read |
| embark on | start |
| streamline | simplify |
| optimize (vague) | improve (name how) |
| enhance / elevate | improve (name how) |
| empower | let / allow |
| foster | encourage / build |
| underscore | show |
| robust | reliable / retries on failure (name the property) |
| seamless | (name the behaviour, or omit) |
| holistic / comprehensive | (name what is included) |
| pivotal / crucial / vital | (omit, or say why it matters) |
| transformative / groundbreaking | (name the change) |
| actionable | (name the action) |
| innovative | new (or name what is new) |
| cutting-edge | new |
| multifaceted | (name the parts) |
| paradigm | approach / model |
| synergy | combined effect |
| testament to | shows |

## Coding-agent jargon

These words are fine in skill files. In replies the operator reads, use the
ordinary English on the right.

**Harness.** Use **harness** for an **agent harness**: the host that runs the
agent (Cursor, Claude Code, Codex, Copilot, and other Agent Skills hosts). Do
not use it for code. Isolation trees, wrappers, eval fixtures, helpers, and
modules are named as the file, tree, test runner, or command. **test harness**
stays only when it means the test runner.

| Instead of | Write |
|------------|-------|
| spin up (an agent) | start |
| kick off | start |
| wire up | connect |
| orchestrate | run / coordinate |
| scaffold | create the initial files |
| bake in | include |
| surface (verb) | show / mention |
| flag / call out | mention / mark |
| double-click on | look at |
| circle back | come back to this |
| align on | agree |
| bandwidth | time |
| working surface | the running app / the API |
| product surface | the user-visible product |
| artifact | the plan file / that document |
| probe | the question |
| handoff | what to do next |
| pass criteria | the checkable success rows |
| spec lock | the automated check |
| manager (agent) | this agent |
| worker | the sub-agent |

## Skill tokens in chat

Skill files keep these tokens. Chat uses the ordinary phrase unless the
operator already used the token.

| Instead of | Write |
|------------|-------|
| fog | the work is still unclear |
| frontier | the first task |
| campground | leave this code cleaner |
| laser | this review pass |
| `Next` | the next skill to run |
| divergence | a choice we still need to make |
| alignment (process) | we still need to agree |
| ship (verb, vague) | finish / merge |
| iterate (vague) | the follow-up change |
| adopt (vague) | bring this codebase up to the structure bar |

## Invented short forms

| Instead of | Write |
|------------|-------|
| `GPS` for `GeneralProcessSimulator` | `GeneralProcessSimulator` |
| any initials coined from a local type, file, or skill | the full name |

`HTTP`, `JSON`, `SQL`, and other field-standard short forms stay as they are.
A short form the operator already used in this conversation may be reused.

Marks (dashes, headings, emoji, quotes, bold): [LANGUAGE-HUMANIZER.md](LANGUAGE-HUMANIZER.md).
