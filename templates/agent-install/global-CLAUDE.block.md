<!-- marcuskrogh/skills:begin -->
**Claude Code models (catalog-closed).** On Claude Code, every sub-agent spawn
must pass an explicit `model` slug from the subscription allowlist only:
`claude-sonnet-5-5` (Routine / Moderate) or `claude-opus-5-5` (Demanding /
manager). If the prefer slug is absent from the harness enum, pass the row
fallback (`claude-sonnet-5` or `claude-opus-5`). Never `inherit`, omit
`model`, or pick API-rate, Fable, or Haiku slugs. Load
`~/.claude/skills/concepts/CONCEPT_DELEGATION.md` and
`~/.claude/skills/concepts/platforms/claude-code.md` before every spawn.

**Language.** Before any reply the operator will see, read
`~/.claude/skills/concepts/CONCEPT_LANGUAGE.md`,
`~/.claude/skills/concepts/LANGUAGE-PHRASES.md`, and
`~/.claude/skills/concepts/LANGUAGE-HUMANIZER.md`. Follow those files. Spell
names in full (`GeneralProcessSimulator`, not `GPS`). Keep **harness** for the
agent host (Cursor, Claude Code, Codex, …). Do not call a sandbox tree, wrapper,
or other code a harness.
<!-- marcuskrogh/skills:end -->
