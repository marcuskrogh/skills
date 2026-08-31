#!/usr/bin/env python3
"""CRAP (Change Risk Anti-Patterns) on touched files. Stdlib only.

CRAP = C^2 * (1 - cov)^3 + C
C = cyclomatic complexity of a function (decision points + 1).
cov = coverage fraction 0–1 when --coverage XML is given; else 0 (worst).

Always evaluate; the score is a guide, not a fail.

Usage:
  python3 crap.py path/to/file.py [more.py]
  python3 crap.py --coverage coverage.xml src/mod.py
"""
from __future__ import annotations

import argparse
import ast
import json
import sys
import xml.etree.ElementTree as ET
from pathlib import Path


def cyclomatic(node: ast.AST) -> int:
    decisions = 0
    for child in ast.walk(node):
        if isinstance(
            child,
            (
                ast.If,
                ast.For,
                ast.AsyncFor,
                ast.While,
                ast.ExceptHandler,
                ast.With,
                ast.AsyncWith,
                ast.comprehension,
            ),
        ):
            decisions += 1
        elif isinstance(child, ast.BoolOp):
            decisions += max(0, len(child.values) - 1)
        elif isinstance(child, ast.IfExp):
            decisions += 1
    return decisions + 1


def nested_control(node: ast.AST) -> bool:
    """True when an If/For/While contains another If/For/While (accidental shape)."""

    class_nested = (ast.If, ast.For, ast.AsyncFor, ast.While)

    def depth(n: ast.AST, inside: bool) -> bool:
        if isinstance(n, class_nested):
            if inside:
                return True
            inside = True
        for ch in ast.iter_child_nodes(n):
            if depth(ch, inside):
                return True
        return False

    return depth(node, False)


def functions(tree: ast.AST, source: str) -> list[dict]:
    out = []
    for node in ast.walk(tree):
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            c = cyclomatic(node)
            out.append(
                {
                    "name": node.name,
                    "lineno": node.lineno,
                    "complexity": c,
                    "nested": nested_control(node),
                    "shape": "nested" if nested_control(node) else "flat",
                }
            )
    return out


def crap(c: int, cov: float) -> float:
    cov = min(1.0, max(0.0, cov))
    return c * c * (1.0 - cov) ** 3 + c


def load_coverage(path: Path) -> dict[tuple[str, int], float]:
    """Cobertura-style line hits keyed by (file suffix, line). Best-effort."""
    if not path.is_file():
        return {}
    try:
        root = ET.parse(path).getroot()
    except ET.ParseError:
        return {}
    hits: dict[tuple[str, int], int] = {}
    for cls in root.iter("class"):
        filename = cls.get("filename") or ""
        for line in cls.iter("line"):
            num = int(line.get("number", "0"))
            h = int(float(line.get("hits", "0")))
            hits[(filename.replace("\\", "/"), num)] = h
    # Convert to per-line 0/1; function coverage is mean of its lines when used.
    return {k: (1.0 if v > 0 else 0.0) for k, v in hits.items()}


def file_cov(coverage: dict[tuple[str, int], float], path: Path, lineno: int, lines: int) -> float:
    if not coverage:
        return 0.0
    suffix = path.as_posix()
    vals = []
    for (fn, ln), hit in coverage.items():
        if fn.endswith(path.name) or suffix.endswith(fn) or fn.endswith(suffix):
            if lineno <= ln < lineno + max(lines, 1):
                vals.append(hit)
    if not vals:
        return 0.0
    return sum(vals) / len(vals)


def analyse(paths: list[Path], coverage_xml: Path | None) -> list[dict]:
    coverage = load_coverage(coverage_xml) if coverage_xml else {}
    rows = []
    for path in paths:
        if path.suffix != ".py" or not path.is_file():
            rows.append(
                {
                    "file": str(path),
                    "error": "skip: not a Python file or missing",
                }
            )
            continue
        src = path.read_text(encoding="utf-8")
        try:
            tree = ast.parse(src)
        except SyntaxError as e:
            rows.append({"file": str(path), "error": f"syntax: {e}"})
            continue
        src_lines = src.splitlines()
        for fn in functions(tree, src):
            end = fn["lineno"]
            # rough span until next def at same indent — use 40 lines cap
            span = 40
            cov = file_cov(coverage, path, fn["lineno"], span)
            score = round(crap(fn["complexity"], cov), 2)
            rows.append(
                {
                    "file": str(path),
                    "function": fn["name"],
                    "lineno": fn["lineno"],
                    "complexity": fn["complexity"],
                    "nested": fn["nested"],
                    "shape": fn["shape"],
                    "coverage": round(cov, 3),
                    "crap": score,
                }
            )
            _ = src_lines  # keep parse honest
    return rows


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description="CRAP guide on touched Python files")
    p.add_argument("files", nargs="+", type=Path)
    p.add_argument("--coverage", type=Path, default=None, help="Cobertura coverage.xml")
    args = p.parse_args(argv)
    rows = analyse(args.files, args.coverage)
    print(json.dumps(rows, indent=2))
    return 0


if __name__ == "__main__":
    sys.exit(main())
