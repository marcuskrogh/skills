# Architecture: Front-end design skill

## Shape
- Lives: `skills/frontend-design/` (invokable skill) plus `skills/concepts/CONCEPT_FRONTEND.md` and disclosed catalogs `FRONTEND-WARM.md`, `FRONTEND-ELEMENTS.md`, `FRONTEND-CRAFT.md`
- Depends on: `CONCEPT_IMPLEMENTATION` (product surfaces), `CONCEPT_LANGUAGE` (operator replies), `CONCEPT_SKILL` (function shape)
- Seams: skill On-invoke pointers; implement loads the skill when a package changes product-surface UI
- Will not add: a pipeline catalog row, a Heating Assistant production restyle, new layers in consuming apps

## Neighbourhood
- Opened modules/boundaries: `skills/` siblings (`help`, `workflows` out-of-catalog, `implement` On-invoke, `plugin.json`, README tree)
- Major refinement (or none): none — new skill beside `writing-for-agents`

## Tracker
- Task: MD-1
- Branch: cursor/frontend-design-skill-f322
