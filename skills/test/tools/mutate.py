#!/usr/bin/env python3
"""Touched-file source-level mutation. Stdlib only.

Applies simple mutants (flip ==/!=, and/or, drop not) one at a time and
reports each mutant. Running the repo test command is the caller's job.

Prefer the repo's mutator when one exists. Touched files only.

Usage:
  python3 mutate.py path/to/file.py [more.py]
  python3 mutate.py --json file.js file.ts
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

PY_EXTS = {".py"}
JS_EXTS = {".js", ".jsx", ".ts", ".tsx", ".mjs", ".cjs"}

# Order matters: longer tokens first.
SWAPS: list[tuple[str, str]] = [
    ("===", "!=="),
    ("!==", "==="),
    ("==", "!="),
    ("!=", "=="),
    ("&&", "||"),
    ("||", "&&"),
]


def python_mutants(src: str) -> list[dict]:
    mutants = []
    # Equality
    for i, m in enumerate(re.finditer(r"(?<![=!])==(?!=)|!=", src)):
        token = m.group(0)
        repl = "!=" if token == "==" else "=="
        mutants.append(
            {
                "id": f"eq-{i}",
                "kind": "equality",
                "offset": m.start(),
                "from": token,
                "to": repl,
            }
        )
    for i, m in enumerate(re.finditer(r"\band\b|\bor\b", src)):
        token = m.group(0)
        repl = "or" if token == "and" else "and"
        mutants.append(
            {
                "id": f"bool-{i}",
                "kind": "boolop",
                "offset": m.start(),
                "from": token,
                "to": repl,
            }
        )
    for i, m in enumerate(re.finditer(r"\bnot\b", src)):
        mutants.append(
            {
                "id": f"not-{i}",
                "kind": "not",
                "offset": m.start(),
                "from": "not ",
                "to": "",
            }
        )
    return mutants


def js_mutants(src: str) -> list[dict]:
    mutants = []
    i = 0
    # Scan without replacing inside the original index space
    pos = 0
    while pos < len(src):
        hit = None
        for a, b in SWAPS:
            if src.startswith(a, pos):
                hit = (a, b)
                break
        if hit:
            a, b = hit
            mutants.append(
                {
                    "id": f"js-{i}",
                    "kind": "swap",
                    "offset": pos,
                    "from": a,
                    "to": b,
                }
            )
            i += 1
            pos += len(a)
            continue
        pos += 1
    return mutants


def analyse(path: Path) -> dict:
    if not path.is_file():
        return {"file": str(path), "error": "missing"}
    src = path.read_text(encoding="utf-8")
    ext = path.suffix.lower()
    if ext in PY_EXTS:
        mutants = python_mutants(src)
        lang = "python"
    elif ext in JS_EXTS:
        mutants = js_mutants(src)
        lang = "javascript"
    else:
        return {"file": str(path), "error": f"unsupported extension {ext}"}
    return {
        "file": str(path),
        "language": lang,
        "mutant_count": len(mutants),
        "mutants": mutants[:50],  # cap noise
        "truncated": len(mutants) > 50,
    }


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description="List source-level mutants on touched files")
    p.add_argument("files", nargs="+", type=Path)
    args = p.parse_args(argv)
    rows = [analyse(f) for f in args.files]
    print(json.dumps(rows, indent=2))
    return 0


if __name__ == "__main__":
    sys.exit(main())
