# Concept: Frontend

Product-surface UI: **warm** **direction** by default, one **signature**,
named **tokens**, and a **craft** floor. Uninvokable — load only when a skill's
On-invoke pointer fires.

## Intent

Every **product surface** looks like it belongs to this brief: named **tokens**,
type that carries voice, structure that encodes the content, and copy that helps
someone act. When the brief leaves stance free, the look is **warm** — simple,
uncrowded, cream and terracotta, rounded modules. Usability comes from the craft
floor. Outcome: working UI whose visual system can be stated in a short plan and
checked against that plan.

## Leading words

- **direction** — named visual stance for this brief (palette, type, density, motion)
- **warm** — default **direction**: cream paper, terracotta accent, generous
  radius, sparse layout
- **signature** — the one element the page is remembered by
- **token** — named color, type, space, or motion value the build derives from
- **craft** — the quality floor: semantics, focus, contrast, reduced motion, small viewports
- **subject** — the product or page's world (audience + job + materials/vernacular)

## Invariants

- **Grounded.** Before visual choices: name the **subject**, the audience, and the
  page's one job. Derive **tokens** from that world's materials — seen through
  the **direction**.
- **Warm default.** When the brief leaves **direction** free, design **warm**.
  Catalog: [FRONTEND-WARM.md](FRONTEND-WARM.md). Recurring controls follow
  [FRONTEND-ELEMENTS.md](FRONTEND-ELEMENTS.md).
- **Tokens first.** A compact system exists before CSS: 4–6 named colors, two or
  more type roles (display with restraint, body, utility when data needs it), a
  layout idea, and the **signature**. Every color and face in the build traces to
  that system.
- **One signature.** Spend boldness in one place — usually one control or
  one readout. Surrounding architecture stays one family. Decoration earns its
  keep by serving the brief.
- **Simple.** One job per view. One job per module. Space between groups is
  part of the design. A control that restates a number already on screen is
  extra.
- **Structure informs.** Numbering, eyebrows, dividers, and labels encode a real
  property of the content (sequence, hierarchy, status). They do not decorate.
- **Type as voice.** Display and body are a deliberate pair for this brief. The
  scale, weight, and spacing are part of the design, not a default stack.
- **Motion serves.** One orchestrated moment, or none. Animate `transform` and
  `opacity` only. Honor `prefers-reduced-motion`.
- **Match intensity.** Execute the **direction** fully. The **warm** catalog is
  quiet and thorough: as little design as possible, every remaining part
  rounded, spaced, and finished.
- **Brief wins.** When the brief names a look, follow those words. When an axis
  is free, spend that freedom on **warm** for this **subject**.
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
| **Direction** | may | Override the **warm** default when the brief names another stance |
| **Opening** | may | Whether to show the token plan before code |

## Flow

1. **Ground** — Name **subject**, audience, job. Done when those three are stated.
2. **Plan** — Write **tokens** (color, type, layout, **signature**). Done when
   each token is named and the **signature** is one sentence.
3. **Check** — Read the plan against the brief, [FRONTEND-WARM.md](FRONTEND-WARM.md),
   and [FRONTEND-ELEMENTS.md](FRONTEND-ELEMENTS.md). Revise any part that would
   appear for any similar page, or that would read as teal/grey industrial.
   Done when the plan is specific to this **subject**.
4. **Build** — Derive CSS and markup from the plan; apply **craft**. Done when
   the UI matches the tokens and the floor checklist.
5. **Critique** — Confirm one **signature**, even surrounding architecture, and
   craft. Remove one extra. Done when a pass would not change **direction**.

## Reference

### Default clusters

Legitimate when the brief asks for them. Otherwise they are the unchosen look.
**Warm** is not the terminal cluster and not the news cluster.

| Cluster | Tells |
|---------|--------|
| Near-black, one acid-green or vermilion accent | "Terminal default" |
| Broadsheet: hairline rules, zero radius, dense newspaper columns | "News default" |

### Token plan (minimum)

Color: 4–6 named hex values. Type: display, body, utility if needed. Layout:
one-sentence idea plus a small ASCII wireframe when comparing options.
**Signature:** one memorable element that embodies the brief.
