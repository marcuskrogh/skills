# Architecture: Presentation front page

## Shape

- Lives: `README.md` (operator front page) and `docs/guide/` (chapters and the images the front page embeds).
- Depends on: existing skill, workflow, help, guide, and install files as the source of truth. No new module, script, or public interface.
- Seams: none. This change has no executable behaviour and no test seam.
- Will not add: a new skill, a new workflow, a new install path, or any edit to the parked front-end design skill.

## Neighbourhood

- Opened modules/boundaries: the front page and the guide pages it links (`docs/guide/README.md`, `install.md`, `structure.md`, `examples.md`).
- Major refinement (or none): none. The guide tree stays where it is. Long install detail moves into `docs/guide/install.md` so the front page can stay short.

## Tracker

- Task: MD-1
- Branch: cursor/readme-presentation-ac69
