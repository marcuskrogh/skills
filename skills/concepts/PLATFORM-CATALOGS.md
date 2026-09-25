# Platform catalogs (delegation)

Disclosed reference for [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md). Load when
scoring difficulty and picking a worker model. Ranks are preference order for
**this skills repo**; WORKSPACE or skill overrides win when present.

**Progressive disclosure:** after detecting the harness, read **only** that
platform file below. Use General only when the harness is unknown (not Cursor /
Claude Code / Codex / Copilot). An incomplete Task `model` enum is not unknown
— stay on the detected file and remap.

## Catalog rules

1. **Efficiency first** — rank by capability per cost, not peak score. A higher
   benchmark at several times the price is a worse rank. **Grok 4.7**, **GPT-6
   Sol** (`gpt-6-sol`), and **Terra** (`gpt-5.6-terra`) are the efficient picks.
   **GPT-6 Astra** and **Claude Opus** are capability ceilings: use one only
   after the efficient pick for that tier is insufficient. One workhorse may
   cover both **low** and **mid**. Do not add a brand that costs more for a
   small score gain.
2. **One prefer slug per provider** per category. Sol and Terra may share a
   category only as prefer plus the slug used when that prefer is absent.
   Prior generations stay on that row's fallback slug.
3. **Catalog-closed** — pick only prefer/fallback slugs from the loaded platform
   file. Do not invent, family-resolve, or “upgrade” to a model the harness
   lists but the platform file does not.
4. **Never Fable 5** — do not select Claude Fable 5 (`fable`, `claude-fable-5`,
   thinking variants, or aliases like `best` that resolve to Fable).
5. **Never Haiku** — do not select Claude Haiku (any version) for workers or
   managers.
6. Fast / mini / prior-gen variants are **fallbacks for the same row**, not
   separate ranked picks — **except on Cursor**, which forbids `*-fast` entirely
   (see rule 8).
7. **Same slug for low and mid** is allowed (and preferred when cost-optimal).
   If low and mid resolve to the same model, an insufficient report escalates
   **directly to high**.
8. **Cursor first-party** — on Cursor (Desktop, Cloud, CLI, Mobile), the platform file
   is a closed allowlist of **Composer** and **Grok** standard slugs only
   (`composer-2.5`, `grok-4.7-high`, prior-gen `cursor-grok-4.6-high`). No
   `*-fast` variants. The allowlist covers every `Task` type (`computerUse`,
   `videoReview`, …). Third-party models in the Cursor picker (Claude, GPT,
   Gemini, Kimi, …) bill the **API budget**; Composer and Grok bill the
   **internal** budget. Never pass a third-party or fast slug on Cursor —
   remap to the category's catalog slug. If `grok-4.7-high` is absent from
   the Task enum, pass `cursor-grok-4.6-high` when present, else `composer-2.5`.
   Never omit `model` or pass `inherit`. When a type would still run a
   third-party default, keep the work on the manager.

## Platforms

| Harness | File |
|---------|------|
| Cursor | [platforms/cursor.md](platforms/cursor.md) |
| Claude Code | [platforms/claude-code.md](platforms/claude-code.md) |
| Codex (OpenAI) | [platforms/codex.md](platforms/codex.md) |
| GitHub Copilot | [platforms/github-copilot.md](platforms/github-copilot.md) |
| General / unknown | [platforms/general.md](platforms/general.md) |
