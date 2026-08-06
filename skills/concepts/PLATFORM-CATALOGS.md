# Platform catalogs (delegation)

Disclosed reference for [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md). Load when
scoring difficulty and picking a worker model. Ranks are preference order for
**this skills repo**; WORKSPACE or skill overrides win when present.

**Progressive disclosure:** after detecting the harness, read **only** that
platform file below (use General when unknown or incomplete).

## Catalog rules

1. **Cost first** — for each harness, prefer the cheapest model that can do the
   work. In practice this usually means one **cost workhorse** for both
   **low** and **mid**, and a single **premium** model for **high**. Do not
   introduce extra mid-tier brands when the workhorse already covers Moderate.
2. **One model per provider** per category — prefer the current cost-efficient
   pick; put prior generations only as that row's fallback slug.
3. **Never Fable 5** — do not select Claude Fable 5 (`fable`, `claude-fable-5`,
   thinking variants, or aliases like `best` that resolve to Fable).
4. **Never Haiku** — do not select Claude Haiku (any version) for workers or
   managers.
5. Fast / mini / prior-gen variants are **fallbacks for the same row**, not
   separate ranked picks.
6. **Same slug for low and mid** is allowed (and preferred when cost-optimal).
   If low and mid resolve to the same model, an insufficient report escalates
   **directly to high**.

## Platforms

| Harness | File |
|---------|------|
| Cursor | [platforms/cursor.md](platforms/cursor.md) |
| Claude Code | [platforms/claude-code.md](platforms/claude-code.md) |
| Codex (OpenAI) | [platforms/codex.md](platforms/codex.md) |
| GitHub Copilot | [platforms/github-copilot.md](platforms/github-copilot.md) |
| General / unknown | [platforms/general.md](platforms/general.md) |
