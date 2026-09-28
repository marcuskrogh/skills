# Architecture: Repository guide

## Shape
- Lives: `README.md` (front page) and `docs/guide/` (linked wiki pages)
- Depends on: existing `skills/`, `scripts/`, `templates/`, and `skills/manage-skills/agent-install.md` as the source of truth
- Seams: README links into `docs/guide/*.md`; those pages link back to README and to the skill files they describe
- Will not add: new skills, workflows, install paths, product UI, or a GitHub wiki outside the repo

## Neighbourhood
- Opened modules/boundaries: repo root README; new `docs/guide/` next to existing `docs/agents/`
- Major refinement (or none): none. `docs/agents/` stays pipeline artifacts for this repo. `docs/guide/` is operator-facing only.

## Layout

```text
README.md                 overview + full install
docs/guide/structure.md   tree, what each directory is
docs/guide/how-it-works.md  skills vs concepts, routing, Next, tracker
docs/guide/workflows.md   catalog, templates, chains
docs/guide/skills.md      every skill: how, where, outputs, workflows
docs/guide/concepts.md    every concept and disclosed catalog
docs/guide/examples.md    applied situations from the catalog
docs/guide/install.md     extra install paths and first-use
```

## Tracker
- Task: MD-1
- Branch: cursor/skills-repository-guide-4766
