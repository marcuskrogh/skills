#!/usr/bin/env python3
"""Lock the GitHub Copilot ceiling after Gemini 4 Argon leaves Copilot."""

from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
COPILOT = ROOT / "skills" / "concepts" / "platforms" / "github-copilot.md"
GENERAL = ROOT / "skills" / "concepts" / "platforms" / "general.md"
INDEX = ROOT / "skills" / "concepts" / "PLATFORM-CATALOGS.md"
CLOSED = (
    ROOT / "skills" / "concepts" / "platforms" / "cursor.md",
    ROOT / "skills" / "concepts" / "platforms" / "claude-code.md",
    ROOT / "skills" / "concepts" / "platforms" / "codex.md",
)

RANK3 = "| 3 | Google | Gemini 4 Carbon | preferred ceiling (`gemini-4-carbon`) |"
RANK4 = "| 4 | Anthropic | Claude Opus 5.5 | ceiling after Gemini 4 Carbon is insufficient |"
COST = "Gemini 4 Carbon is the preferred capability ceiling."

ABSENT_FROM_COPILOT = (
    "Gemini 4 Argon",
    "gemini-4-argon",
    "Gemini 4 Hydrogen",
    "gemini-4-hydrogen",
    "Gemini 3.8 Flash",
    "Grok 4.6",
    "Kimi K3",
    "Claude Haiku 4.5",
)

ABSENT_FROM_RANKED = (
    "Claude Fable",
    "Claude Haiku",
    "Gemini 4 Argon",
    "Gemini 4 Hydrogen",
    "Gemini 3.8 Flash",
    "Grok 4.6",
    "Kimi K3",
)


def main() -> int:
    errors = 0

    def check(ok: bool, label: str) -> None:
        nonlocal errors
        if ok:
            print(f"OK: {label}")
        else:
            print(f"FAIL: {label}")
            errors += 1

    copilot = COPILOT.read_text()
    ranked_at = copilot.find("## High-capability")
    if ranked_at < 0:
        raise SystemExit("missing heading ## High-capability")
    ranked = copilot[ranked_at:]

    check(COST in copilot, "cost split names Gemini 4 Carbon as the preferred ceiling")
    check(RANK3 in copilot, "high rank 3 is Gemini 4 Carbon")
    check(RANK4 in copilot, "Opus row follows Carbon and does not name Argon")
    check(copilot.count("`gemini-4-carbon`") == 1, "gemini-4-carbon appears once")

    for needle in ABSENT_FROM_COPILOT:
        check(needle not in copilot, f"github-copilot.md omits {needle}")

    for needle in ABSENT_FROM_RANKED:
        check(needle not in ranked, f"ranked Copilot rows omit {needle}")

    general = GENERAL.read_text()
    check(
        "| 5 | Google | Gemini 4 Argon | `gemini-4-argon` |" in general,
        "general.md keeps the Argon row",
    )
    check("gemini-4-carbon" not in general, "general.md does not gain gemini-4-carbon")

    index = INDEX.read_text()
    check(
        "Gemini 4 Argon** (`gemini-4-argon`) is the preferred capability ceiling" in index,
        "PLATFORM-CATALOGS.md rule 1 still names Argon",
    )
    check("gemini-4-carbon" not in index, "PLATFORM-CATALOGS.md does not gain gemini-4-carbon")

    for path in CLOSED:
        text = path.read_text()
        check("gemini-4-carbon" not in text, f"{path.name} does not gain gemini-4-carbon")
        check("Gemini 4 Argon" not in text, f"{path.name} does not name Argon as a Copilot ceiling")

    if errors:
        print(f"\n{errors} check(s) failed.")
        return 1
    print("\nCopilot catalogue lock passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
