# Test tools

Skill-bundled runners for `/test`. They install with the skill
(`skills/test/tools/`). **Touched paths only** — never the whole tree.

Prefer the repo’s own coverage tool when one exists. The CRAP runner is the
floor when it does not. Do not list mutants as a testing pass. A repo tool
that applies mutants and runs the suite (killed vs survived) may be used on
touched paths; listing candidates without running tests is not evaluation.

| Tool | Command | Role |
|------|---------|------|
| **CRAP** | `python3 tools/crap.py <file> [<file>…]` | Per-function cyclomatic complexity and CRAP (coverage XML optional via `--coverage`). Evaluate; no hard cap. |

Discover flags via `--help`. Stdlib only.

**Representability.** A test that executes a line and ignores the result does
not count. Coverage must not drop on touched packages. Maintain tests this
change invalidated.
