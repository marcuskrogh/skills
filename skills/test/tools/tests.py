"""Tests for skill-bundled /test tools.

Run from repo root:
  python -m unittest skills.test.tools.tests
or:
  python skills/test/tools/tests.py
"""
from __future__ import annotations

import importlib.util
import tempfile
import unittest
from pathlib import Path


def _load(name: str):
    here = Path(__file__).parent
    spec = importlib.util.spec_from_file_location(name, here / f"{name}.py")
    mod = importlib.util.module_from_spec(spec)
    assert spec.loader
    spec.loader.exec_module(mod)
    return mod


crap = _load("crap")


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


if __name__ == "__main__":
    unittest.main()
