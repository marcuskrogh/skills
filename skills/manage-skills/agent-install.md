# Agent install from git (canonical)

Zero-deviation procedure for installing this skills set into a **consuming**
repo. Agents follow this path only — do not invent alternate trees, partial
copies, or custom `AGENTS.md` wording.

**On invoke / when asked to install:** run the steps below; do not substitute
`npx` unless the user explicitly asks for skills.sh.

## Preferred prompt (paste to an agent)

```text
Install marcuskrogh/skills into this repository from git using the canonical
installer. Do not use another install method.

1. From the project root, run exactly:
   curl -fsSL https://raw.githubusercontent.com/marcuskrogh/skills/main/scripts/install-from-git.sh | bash
2. If curl|bash is unavailable: shallow-clone
   https://github.com/marcuskrogh/skills.git at ref main into a temp dir, then
   run: bash <clone>/scripts/install-from-git.sh
3. Commit the paths the script lists. Those paths depend on the applied harness.
   Copilot: `.agents/skills/` and `.github/copilot-instructions.md`.
   Cursor: `.agents/skills/`, `AGENTS.md`, and `.cursor/rules/github-skills.mdc`.
   Claude Code: `.claude/skills/` and `CLAUDE.md`.
   Codex: `.agents/skills/` and `AGENTS.md`.
4. Confirm .agents/skills/.skills-version exists and
   .agents/skills/workflows/SKILL.md is present.
```

## What the script does (do not reimplement)

| Step | Result |
|------|--------|
| Fetch `SKILLS_REF` (default `main`) from `SKILLS_REPO` | Cache under `/tmp/marcuskrogh-skills` (or use the clone that contains the script) |
| Replace `.agents/skills/` | Every `skills/*/SKILL.md` folder + `concepts/` |
| Write `.agents/skills/.skills-version` | `repo`, `ref`, `sha`, `synced_at`, `method=install-from-git` |
| Resolve applied harness | `SKILLS_HARNESS`, else the harness running the script. `all` is refused |
| Install skill tree | Cursor, Codex, Copilot → `.agents/skills/`. Claude Code → `.claude/skills/`. No other harness folders |
| Cursor instructions | Append block in `AGENTS.md`. Write `.cursor/rules/github-skills.mdc` |
| Claude Code instructions | Append block in `CLAUDE.md` (a real file, not a symlink) |
| Codex instructions | Append block in `AGENTS.md` |
| Copilot instructions | Append block in `.github/copilot-instructions.md` |

## Env knobs (optional)

| Variable | Default | Purpose |
|----------|---------|---------|
| `PROJECT_ROOT` | cwd | Consuming repo root |
| `SKILLS_REF` | `main` | Branch, tag, or commit |
| `SKILLS_REPO` | `https://github.com/marcuskrogh/skills.git` | Source remote |
| `SKILLS_CACHE` | `/tmp/marcuskrogh-skills` | Clone cache |
| `SKIP_POINTERS` | unset | Set `1` to skip instruction files and rules |
| `SKILLS_HARNESS` | detected | `cursor`, `claude`, `codex`, and/or `copilot`. Files are written only for these |
| `SKILLS_SOURCE` | unset | Use an existing checkout as-is (ignores `SKILLS_REF`; for local testing) |

When the script file lives inside a `marcuskrogh/skills` checkout, that checkout
is used **only if** its `HEAD` already matches `SKILLS_REF`. Otherwise the
installer fetches `SKILLS_REF` into the cache (so pins are not silently ignored).
For uncommitted / PR-branch testing, set `SKILLS_SOURCE` to that checkout.

Pin then return to latest:

```bash
SKILLS_REF=<tag-or-sha> bash /path/to/install-from-git.sh
SKILLS_REF=main bash /path/to/install-from-git.sh
```

## Also supported: skills.sh (`npx`)

When the user wants the interactive / multi-harness CLI instead of agent-from-git:

```bash
npx skills add marcuskrogh/skills
```

Non-interactive (CI / agent with explicit npx request):

```bash
npx skills add marcuskrogh/skills --all -y
```

`npx` does **not** write the routing instruction. After an npx-only install, run
`install-from-git.sh` with `SKILLS_HARNESS` set to the harness in use, or copy
that harness's block from `templates/agent-install/` into its instruction file.
Do not copy a Claude or Cursor file into a project that is not using that harness.

## Update an agent-from-git install

Re-run the same script (same prompt, same `SKILLS_HARNESS`). It replaces that
harness's skill folder and refreshes its marked instruction block. Then commit.

## Completion criteria

- [ ] The applied harness's skill folder contains `workflows/SKILL.md`, `concepts/`, and `.skills-version` with `method=install-from-git`
- [ ] That harness's instruction file contains the `marcuskrogh/skills` begin/end block, including the language extract (`CONCEPT_LANGUAGE.md`, `LANGUAGE-PHRASES.md`, `LANGUAGE-HUMANIZER.md`)
- [ ] No skill folder, instruction file, or rule was written for a harness that was not applied
- [ ] Changes committed (unless the user asked not to)
