<!-- marcuskrogh/skills:begin -->
**Route to a workflow.** When these skills are installed, route every request through the catalog workflow unless the user explicitly says to skip that routing, or the request is obviously outside what these skills apply to. Invoke [`__SKILLS__/workflows/SKILL.md`](__SKILLS__/workflows/SKILL.md). **Front doors:** foggy → explore; concrete → define. Define interviews for alignment, then classifies and binds a workflow. A short description starts that interview; it does not approve the plan. Skills do not name the next skill; the bound workflow writes persisted **Next**. Follow that cue. A reply that finishes a skill ends with the exact `## Next` block (`/<skill> <KEY>` — why). An open alignment question does not include that block. Do not freestyle coding or ad-hoc planning when a catalog workflow fits.

Continuation cues: bare **next** / **ship** still apply (see `__SKILLS__/workflow/reference.md`). Explicit `/skill` names win over re-routing. Lost on which skill to use → [`__SKILLS__/help/SKILL.md`](__SKILLS__/help/SKILL.md).

**Codex models (catalog-closed).** On Codex, every spawn that takes a `model` must pass an explicit catalog slug. Never omit `model` and never pass `inherit`. Prefer `gpt-6-luna` for routine work, `gpt-5.6-terra` for moderate work, and `gpt-6.1-sol` for demanding work. Pass `gpt-6-astra` only after `gpt-6.1-sol` is insufficient on the same package. Load `__SKILLS__/concepts/CONCEPT_DELEGATION.md` and `__SKILLS__/concepts/platforms/codex.md` before every spawn.

**Language.** Before any reply the operator will see, read `__SKILLS__/concepts/CONCEPT_LANGUAGE.md`, `__SKILLS__/concepts/LANGUAGE-PHRASES.md`, and `__SKILLS__/concepts/LANGUAGE-HUMANIZER.md`. Follow those files. Spell names in full (`GeneralProcessSimulator`, not `GPS`). Keep **harness** for the agent host (Cursor, Claude Code, Codex, …). Do not call a sandbox tree, wrapper, or other code a harness.

Authoring skills or concepts → [`__SKILLS__/writing-for-agents/SKILL.md`](__SKILLS__/writing-for-agents/SKILL.md).
<!-- marcuskrogh/skills:end -->
