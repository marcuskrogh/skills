"""Tests for skill-bundled /test tools.

Run from repo root:
  python -m unittest skills.test.tools.tests
or:
  python skills/test/tools/tests.py
"""
from __future__ import annotations

import importlib.util
import io
import json
import tempfile
import unittest
from contextlib import redirect_stdout
from pathlib import Path


def _load(name: str):
    here = Path(__file__).parent
    spec = importlib.util.spec_from_file_location(name, here / f"{name}.py")
    mod = importlib.util.module_from_spec(spec)
    assert spec.loader
    spec.loader.exec_module(mod)
    return mod


crap = _load("crap")
mutate = _load("mutate")


class CrapTests(unittest.TestCase):
    def test_nested_if_is_nested_shape(self):
        src = "def f(x):\n    if x:\n        if x > 1:\n            return 1\n    return 0\n"
        with tempfile.NamedTemporaryFile("w", suffix=".py", delete=False) as fh:
            fh.write(src)
            path = Path(fh.name)
        try:
            rows = crap.analyse([path], None)
            nested = [r for r in rows if r.get("function") == "f"][0]
            self.assertEqual(nested["shape"], "nested")
            self.assertGreaterEqual(nested["complexity"], 3)
            self.assertGreater(nested["crap"], 0)
        finally:
            path.unlink()

    def test_flat_if_is_flat(self):
        src = (
            "def g(x):\n"
            "    if x == 1:\n"
            "        return 'a'\n"
            "    if x == 2:\n"
            "        return 'b'\n"
            "    return 'c'\n"
        )
        with tempfile.NamedTemporaryFile("w", suffix=".py", delete=False) as fh:
            fh.write(src)
            path = Path(fh.name)
        try:
            rows = crap.analyse([path], None)
            g = [r for r in rows if r.get("function") == "g"][0]
            self.assertEqual(g["shape"], "flat")
        finally:
            path.unlink()

    def test_crap_formula(self):
        self.assertEqual(crap.crap(1, 1.0), 1.0)
        self.assertEqual(crap.crap(2, 0.0), 6.0)


class MutateTests(unittest.TestCase):
    def test_python_equality_mutant(self):
        src = "def eq(a, b):\n    return a == b\n"
        ms = mutate.python_mutants(src)
        kinds = {m["kind"] for m in ms}
        self.assertIn("equality", kinds)

    def test_js_and_swap(self):
        src = "if (a && b) { return 1 }"
        ms = mutate.js_mutants(src)
        self.assertTrue(any(m["from"] == "&&" for m in ms))

    def test_cli_json(self):
        with tempfile.NamedTemporaryFile("w", suffix=".py", delete=False) as fh:
            fh.write("def eq(a, b):\n    return a == b\n")
            path = Path(fh.name)
        try:
            buf = io.StringIO()
            with redirect_stdout(buf):
                mutate.main([str(path)])
            data = json.loads(buf.getvalue())
            self.assertEqual(data[0]["language"], "python")
            self.assertGreaterEqual(data[0]["mutant_count"], 1)
        finally:
            path.unlink()


if __name__ == "__main__":
    unittest.main()
