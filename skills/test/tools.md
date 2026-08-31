# Test tools

Skill-bundled runners for `/test`. They install with the skill
(`skills/test/tools/`). **Touched paths only** — never the whole tree.

Prefer the repo’s own coverage or mutation tool when one exists. These runners
are the floor when it does not.

| Tool | Command | Role |
|------|---------|------|
| **CRAP** | `python3 tools/crap.py <file> [<file>…]` | Per-function cyclomatic complexity and CRAP (coverage XML optional via `--coverage`). Evaluate; no hard cap. |
| **Mutation** | `python3 tools/mutate.py <file> [<file>…]` | Source-level mutants on touched Python / JavaScript / TypeScript. Prefer a repo mutator when present. Surviving mutants on this change are representability gaps. |

Discover flags via `--help`. Stdlib only.

**Representability.** A test that executes a line and ignores the result does
not count. Coverage must not drop on touched packages. Maintain tests this
change invalidated.
