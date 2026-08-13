# Concept: Frontend

Product-surface UI: **retro-futuristic** **direction** by default, one
**signature**, and a **craft** floor. Uninvokable — load only when a skill's
On-invoke pointer fires.

## Intent

Every **product surface** looks like it belongs to this brief: named **tokens**,
type that carries voice, structure that encodes the content, and copy that helps
someone act. When the brief leaves stance free, the look is **retro-futuristic**
— this **subject's** future as an earlier decade imagined it. Usability comes
from the craft floor. Outcome: working UI whose visual system can be stated in a
short plan and checked against that plan.

## Leading words

- **direction** — named visual stance for this brief (palette, type, density, motion)
- **retro-futuristic** — default **direction**: the past’s imagined future, through this **subject's** instruments
- **signature** — the one element the page is remembered by
- **token** — named color, type, space, or motion value the build derives from
- **craft** — the quality floor: semantics, focus, contrast, reduced motion, small viewports
- **subject** — the product or page's world (audience + job + materials/vernacular)

## Invariants

- **Grounded.** Before visual choices: name the **subject**, the audience, and the
  page's one job. Derive **tokens** from that world's materials, instruments, and
  vernacular — seen through the **direction**.
- **Retro-futuristic default.** When the brief leaves **direction** free, design
  **retro-futuristic**. Name one era in the token plan. Catalog:
  [FRONTEND-RETRO.md](FRONTEND-RETRO.md).
- **Tokens first.** A compact system exists before CSS: 4–6 named colors, two or
  more type roles (display with restraint, body, utility when data needs it), a
  layout idea, and the **signature**. Every color and face in the build traces to
  that system.
- **One signature.** Spend boldness in one place — usually one analog or CRT
  device. Surrounding chrome stays one family. Decoration earns its keep by
  serving the brief.
- **Structure informs.** Numbering, eyebrows, dividers, and labels encode a real
  property of the content (sequence, hierarchy, status). They do not decorate.
- **Type as voice.** Display and body are a deliberate pair for this brief. The
  scale, weight, and spacing are part of the design, not a default stack.
- **Motion serves.** One orchestrated moment, or none. Animate `transform` and
  `opacity` only. Honor `prefers-reduced-motion`.
- **Match intensity.** This default **direction** is maximal: execute the console
  fully. When the brief names a quieter look, precision in space and type is the
  equivalent of elaboration.
- **Brief wins.** When the brief names a look, follow those words — including a
  **default cluster** or a non-retro stance. When an axis is free, spend that
  freedom on **retro-futuristic** for this **subject**.
- **Craft floor.** Semantic HTML, visible `:focus-visible`, operable keyboard
  paths, contrast that holds, labels on controls, layout that holds down to a
  small viewport. Details: [FRONTEND-CRAFT.md](FRONTEND-CRAFT.md).
- **Copy is UI.** Words on **product surfaces** follow product language
  ([CONCEPT_IMPLEMENTATION](CONCEPT_IMPLEMENTATION.md)): name what people
  control, active voice, specific actions, empty and error states that say the
  next step. Interface copy is design material.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Subject** | must | Product or page being designed |
| **Artifact** | must | Where the UI lives (app routes, HTML, components) |
| **Stop condition** | must | When the **direction** is executed and **craft** holds |
| **Direction** | may | Override the **retro-futuristic** default when the brief names another stance |
| **Opening** | may | Whether to show the token plan before code |

## Flow

1. **Ground** — Name **subject**, audience, job. Done when those three are stated.
2. **Plan** — Write **tokens** (color, type, layout, **signature**) and the era
   when **direction** is **retro-futuristic**. Done when each token is named and
   the **signature** is one sentence.
3. **Check** — Read the plan against the brief, [FRONTEND-RETRO.md](FRONTEND-RETRO.md),
   and the **default clusters**. Revise any part that would appear for any
   similar page. Done when the plan is specific to this **subject** (or the brief
   named a cluster).
4. **Build** — Derive CSS and markup from the plan; apply **craft**. Done when
   the UI matches the tokens and the floor checklist.
5. **Critique** — Confirm one **signature**, even surrounding chrome, and craft.
   Remove one extra. Done when a pass would not change **direction**.

## Reference

### Default clusters

Legitimate when the brief asks for them. Otherwise they are the unchosen look.
**Retro-futuristic** is not the terminal cluster — see [FRONTEND-RETRO.md](FRONTEND-RETRO.md).

| Cluster | Tells |
|---------|--------|
| Warm cream (~`#F4F1EA`), high-contrast serif display, terracotta accent | "Editorial default" |
| Near-black, one acid-green or vermilion accent | "Terminal default" |
| Broadsheet: hairline rules, zero radius, dense newspaper columns | "News default" |

### Token plan (minimum)

Color: 4–6 named hex values. Type: display, body, utility if needed. Layout:
one-sentence idea plus a small ASCII wireframe when comparing options. Era: one
sentence when **retro-futuristic**. **Signature:** one memorable element that
embodies the brief.
