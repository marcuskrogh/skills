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
3. Commit the paths the script lists (.agents/skills/, AGENTS.md, CLAUDE.md,
   .cursor/rules/github-skills.mdc).
4. Confirm .agents/skills/.skills-version exists and
   .agents/skills/workflows/SKILL.md is present.
```

## What the script does (do not reimplement)

| Step | Result |
|------|--------|
| Fetch `SKILLS_REF` (default `main`) from `SKILLS_REPO` | Cache under `/tmp/marcuskrogh-skills` (or use the clone that contains the script) |
| Replace `.agents/skills/` | Every `skills/*/SKILL.md` folder + `concepts/` |
| Write `.agents/skills/.skills-version` | `repo`, `ref`, `sha`, `synced_at`, `method=install-from-git` |
| Upsert marked block in `AGENTS.md` | `<!-- marcuskrogh/skills:begin -->` … `end` |
| Wire `CLAUDE.md` | Symlink → `AGENTS.md` when absent; else same block |
| Write `.cursor/rules/github-skills.mdc` | Prefer-workflow Cursor rule |

## Env knobs (optional)

| Variable | Default | Purpose |
|----------|---------|---------|
| `PROJECT_ROOT` | cwd | Consuming repo root |
| `SKILLS_REF` | `main` | Branch, tag, or commit |
| `SKILLS_REPO` | `https://github.com/marcuskrogh/skills.git` | Source remote |
| `SKILLS_CACHE` | `/tmp/marcuskrogh-skills` | Clone cache |
| `SKIP_POINTERS` | unset | Set `1` to skip `AGENTS.md` / Cursor wiring |
| `SKILLS_SOURCE` | unset | Use an existing checkout instead of cloning |

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

`npx` does **not** write the prefer-workflow `AGENTS.md` block or Cursor rule.
After an npx-only install, either run `install-from-git.sh` (replaces the skill
tree and wires pointers) or copy the marked block from
`templates/agent-install/AGENTS.block.md` into `AGENTS.md` manually.

## Update an agent-from-git install

Re-run the same script (same prompt). It replaces `.agents/skills/` and refreshes
the marked pointer block. Then commit.

## Completion criteria

- [ ] `.agents/skills/workflows/SKILL.md` exists
- [ ] `.agents/skills/concepts/` exists
- [ ] `.agents/skills/.skills-version` records `method=install-from-git`
- [ ] `AGENTS.md` contains the `marcuskrogh/skills` begin/end block pointing at
      `.agents/skills/workflows/SKILL.md`
- [ ] Changes committed (unless the user asked not to)
