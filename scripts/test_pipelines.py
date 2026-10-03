#!/usr/bin/env python3
"""Resolve workflow transitions from skills/workflow/pipelines.md and check
that independent skills do not name a successor."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PIPELINES = ROOT / "skills" / "workflow" / "pipelines.md"
SKILLS = ROOT / "skills"

INDEPENDENT = (
    "explore",
    "define",
    "bug",
    "tweak",
    "refine",
    "rework",
    "research",
    "model",
    "sandbox",
    "architect",
    "implement",
    "test",
    "restructure",
    "review",
    "iterate",
    "adopt",
    "setup",
)

SKILL_NAMES = (
    "explore|define|bug|tweak|refine|rework|adopt|research|model|sandbox|"
    "architect|implement|test|restructure|harden|review-fix|review|iterate|"
    "ship|setup|help|guide|explain|summarise"
)

SUCCESSOR_PATTERNS = (
    rf"(?m)^## Next\s*\n(?:.*\n){{0,8}}`/(?:{SKILL_NAMES})\b",
    rf"Next is `/(?:{SKILL_NAMES})\b",
    rf"Default Next is `/(?:{SKILL_NAMES})\b",
    rf"persist \*\*Next\*\* `/(?:{SKILL_NAMES})\b",
    rf"[Hh]ands off to `/(?:{SKILL_NAMES})\b",
    rf"[Hh]and off `/(?:{SKILL_NAMES})\b",
    rf"\*\*Handoff\*\*\s*\|\s*`/(?:{SKILL_NAMES})\b",
    rf"Handoff defaults[^\n]*`/(?:{SKILL_NAMES})\b",
)


def section(text: str, heading: str) -> str:
    marker = f"## {heading}"
    start = text.find(marker)
    if start < 0:
        raise SystemExit(f"missing section {heading}")
    rest = text[start + len(marker) :]
    nxt = rest.find("\n## ")
    return rest if nxt < 0 else rest[:nxt]


def table_rows(section_text: str) -> list[list[str]]:
    rows = []
    for line in section_text.splitlines():
        line = line.strip()
        if not line.startswith("|"):
            continue
        cells = [c.strip() for c in line.strip("|").split("|")]
        if not cells or cells[0] in {"Chain", "Workflow", "Skill", "Route type", "Step"}:
            continue
        if set(cells[0]) <= {"-", ":"}:
            continue
        if all(set(c) <= {"-", ":"} or c == "" for c in cells):
            continue
        rows.append(cells)
    return rows


def load(text: str):
    chains: dict[str, list[tuple[str, str]]] = {}
    for chain, step, when in table_rows(section(text, "Chains")):
        chains.setdefault(chain, []).append((step, when))
    transitions = table_rows(section(text, "Transitions"))
    outputs = {row[0]: (row[1], row[2]) for row in table_rows(section(text, "Outputs"))}
    frontier = {row[0]: row[1] for row in table_rows(section(text, "Frontier"))}
    return chains, transitions, outputs, frontier


def when_holds(expr: str, binding: dict, context: dict) -> bool:
    expr = expr.strip()
    if expr == "*":
        return True
    if expr == "always":
        return True
    if " or " in expr:
        return any(when_holds(part, binding, context) for part in expr.split(" or "))
    if "!=" in expr:
        key, value = [p.strip() for p in expr.split("!=", 1)]
        return binding.get(key) != value
    if "=" in expr:
        key, value = [p.strip() for p in expr.split("=", 1)]
        if key in context:
            return context.get(key) == value
        return binding.get(key) == value
    raise SystemExit(f"bad When expression: {expr}")


def assemble(chains, name: str, binding: dict) -> list[str]:
    steps = []
    for step, when in chains[name]:
        if when_holds(when, binding, {}):
            steps.append(step)
    return steps


def chain_target(kind: str, chain: list[str], after: str, full_order: list[str]) -> str:
    if kind == "chain-first":
        return chain[0] if chain else "none"
    if after in chain:
        index = chain.index(after)
        if index + 1 < len(chain):
            return chain[index + 1]
        return "none"
    if after in full_order:
        index = full_order.index(after)
        for step in full_order[index + 1 :]:
            if step in chain:
                return step
        return "none"
    return chain[0] if chain else "none"


def resolve(chains, transitions, workflow, after, outcome, binding, context) -> tuple[str, str]:
    chain_name = {"delivery": "delivery", "iterate": "iterate", "adopt": "adopt"}.get(workflow)
    chain = assemble(chains, chain_name, binding) if chain_name else []
    full_order = [step for step, _when in chains.get(chain_name, [])]
    for row in transitions:
        row_workflow, row_after, row_outcome, row_when, nxt, mode = row
        if row_workflow != workflow:
            continue
        if row_after not in {"*", after}:
            continue
        if row_outcome not in {"*", outcome}:
            continue
        if not when_holds(row_when, binding, context):
            continue
        if nxt in {"chain-next", "chain-first"}:
            nxt = chain_target(nxt, chain, after, full_order)
        return nxt, mode
    raise SystemExit(f"no transition for {workflow} {after} {outcome} {context}")


def default_binding(**overrides) -> dict:
    if "klass" in overrides:
        overrides["class"] = overrides.pop("klass")
    binding = {
        "side_paths": "none",
        "sandbox": "none",
        "class": "feature",
        "test.mode": "dedicated",
        "harden.mode": "dedicated",
    }
    binding.update(overrides)
    return binding


def check_resolve(chains, transitions) -> int:
    errors = 0
    cases = [
        ("delivery", "define", "ready", default_binding(), {}, "architect", "cue"),
        ("delivery", "bug", "ready", default_binding(klass="bug"), {}, "architect", "cue"),
        ("delivery", "tweak", "ready", default_binding(klass="tweak"), {}, "architect", "cue"),
        ("delivery", "refine", "ready", default_binding(klass="refine"), {}, "architect", "cue"),
        ("delivery", "rework", "ready", default_binding(klass="rework"), {}, "architect", "cue"),
        (
            "delivery",
            "define",
            "ready",
            default_binding(side_paths="research+model"),
            {},
            "research",
            "cue",
        ),
        (
            "delivery",
            "research",
            "ready",
            default_binding(side_paths="research+model"),
            {},
            "model",
            "cue",
        ),
        (
            "delivery",
            "model",
            "ready",
            default_binding(side_paths="research+model"),
            {},
            "architect",
            "cue",
        ),
        (
            "delivery",
            "research",
            "ready",
            default_binding(side_paths="research"),
            {},
            "architect",
            "cue",
        ),
        (
            "delivery",
            "architect",
            "ready",
            default_binding(sandbox="inject"),
            {},
            "sandbox",
            "cue",
        ),
        ("delivery", "architect", "ready", default_binding(), {}, "implement", "cue"),
        (
            "delivery",
            "sandbox",
            "accept",
            default_binding(sandbox="inject"),
            {},
            "implement",
            "cue",
        ),
        (
            "delivery",
            "sandbox",
            "delta",
            default_binding(sandbox="inject"),
            {},
            "sandbox",
            "cue",
        ),
        (
            "delivery",
            "sandbox",
            "end",
            default_binding(sandbox="inject"),
            {},
            "none",
            "stop",
        ),
        ("delivery", "implement", "built", default_binding(), {}, "test", "cue"),
        (
            "delivery",
            "implement",
            "built",
            default_binding(**{"test.mode": "skip", "harden.mode": "skip"}),
            {},
            "review",
            "cue",
        ),
        (
            "delivery",
            "implement",
            "built",
            default_binding(**{"test.mode": "skip"}),
            {},
            "restructure",
            "cue",
        ),
        (
            "delivery",
            "implement",
            "built",
            default_binding(klass="adopt", **{"test.mode": "skip"}),
            {},
            "test",
            "cue",
        ),
        ("delivery", "test", "ready", default_binding(), {}, "restructure", "cue"),
        ("delivery", "test", "skipped", default_binding(), {}, "restructure", "cue"),
        (
            "delivery",
            "test",
            "ready",
            default_binding(**{"harden.mode": "skip"}),
            {},
            "review",
            "cue",
        ),
        (
            "delivery",
            "restructure",
            "skipped",
            default_binding(**{"harden.mode": "skip"}),
            {},
            "review",
            "cue",
        ),
        ("delivery", "restructure", "ready", default_binding(), {}, "review", "cue"),
        ("delivery", "review", "CLEAN", default_binding(), {}, "ship", "cue"),
        ("delivery", "review", "FAILED", default_binding(), {}, "implement", "cue"),
        (
            "delivery",
            "review",
            "CLEAN",
            default_binding(shipping="human review"),
            {},
            "human review",
            "cue",
        ),
        (
            "delivery",
            "review",
            "FAILED",
            default_binding(shipping="human review"),
            {},
            "implement",
            "cue",
        ),
        (
            "delivery",
            "human review",
            "ready",
            default_binding(shipping="human review"),
            {},
            "fix-forward",
            "cue",
        ),
        (
            "delivery",
            "fix-forward",
            "CLEAN",
            default_binding(shipping="human review"),
            {},
            "ship",
            "cue",
        ),
        (
            "delivery",
            "fix-forward",
            "FAILED",
            default_binding(shipping="human review"),
            {},
            "none",
            "stop",
        ),
        ("delivery", "implement", "fixed", default_binding(), {}, "review", "cue"),
        ("delivery", "ship", "done", default_binding(), {}, "none", "stop"),
        ("explore", "explore", "ready", default_binding(), {"frontier": "define"}, "define", "cue"),
        (
            "explore",
            "explore",
            "ready",
            default_binding(),
            {"frontier": "research"},
            "research",
            "cue",
        ),
        ("explore", "explore", "ready", default_binding(), {"frontier": "task"}, "none", "stop"),
        ("explore", "research", "ready", default_binding(), {}, "frontier", "cue"),
        ("iterate", "iterate", "ready", default_binding(), {}, "implement", "immediate"),
        ("iterate", "iterate", "inspect-loop", default_binding(), {}, "sandbox", "immediate"),
        ("iterate", "sandbox", "accept", default_binding(), {}, "implement", "immediate"),
        ("iterate", "sandbox", "delta", default_binding(), {}, "sandbox", "cue"),
        ("iterate", "implement", "built", default_binding(), {}, "test", "cue"),
        (
            "iterate",
            "implement",
            "built",
            default_binding(**{"test.mode": "skip"}),
            {},
            "restructure",
            "cue",
        ),
        ("iterate", "review", "CLEAN", default_binding(), {}, "ship", "cue"),
        ("iterate", "review", "FAILED", default_binding(), {}, "implement", "cue"),
        (
            "iterate",
            "review",
            "CLEAN",
            default_binding(shipping="human review"),
            {},
            "human review",
            "cue",
        ),
        (
            "iterate",
            "review",
            "FAILED",
            default_binding(shipping="human review"),
            {},
            "implement",
            "cue",
        ),
        (
            "iterate",
            "fix-forward",
            "FAILED",
            default_binding(shipping="human review"),
            {},
            "none",
            "stop",
        ),
        (
            "iterate",
            "fix-forward",
            "CLEAN",
            default_binding(shipping="human review"),
            {},
            "ship",
            "cue",
        ),
        ("adopt", "adopt", "mapped", default_binding(klass="adopt"), {}, "architect", "immediate"),
        ("adopt", "architect", "ready", default_binding(klass="adopt"), {}, "implement", "immediate"),
        ("adopt", "implement", "built", default_binding(klass="adopt"), {}, "test", "immediate"),
        ("adopt", "test", "ready", default_binding(klass="adopt"), {}, "restructure", "immediate"),
        ("adopt", "restructure", "ready", default_binding(klass="adopt"), {}, "review", "immediate"),
        ("adopt", "review", "CLEAN", default_binding(klass="adopt"), {}, "ship", "immediate"),
        (
            "adopt",
            "review",
            "CLEAN",
            default_binding(klass="adopt", shipping="human review"),
            {},
            "human review",
            "cue",
        ),
        (
            "adopt",
            "review",
            "FAILED",
            default_binding(klass="adopt", shipping="human review"),
            {},
            "implement",
            "cue",
        ),
        (
            "adopt",
            "human review",
            "ready",
            default_binding(klass="adopt", shipping="human review"),
            {},
            "fix-forward",
            "immediate",
        ),
        (
            "adopt",
            "fix-forward",
            "CLEAN",
            default_binding(klass="adopt", shipping="human review"),
            {},
            "ship",
            "immediate",
        ),
        (
            "adopt",
            "fix-forward",
            "FAILED",
            default_binding(klass="adopt", shipping="human review"),
            {},
            "none",
            "stop",
        ),
        ("adopt", "review", "FAILED", default_binding(klass="adopt"), {}, "implement", "cue"),
        (
            "adopt",
            "ship",
            "done",
            default_binding(klass="adopt"),
            {"route": "open"},
            "adopt",
            "immediate",
        ),
        (
            "adopt",
            "ship",
            "done",
            default_binding(klass="adopt"),
            {"route": "empty"},
            "none",
            "stop",
        ),
        (
            "adopt",
            "implement",
            "hard-stop",
            default_binding(klass="adopt"),
            {},
            "blocking",
            "cue",
        ),
        ("standalone", "implement", "built", default_binding(), {}, "none", "stop"),
        ("standalone", "research", "ready", default_binding(), {}, "none", "stop"),
    ]
    # route-open / route-empty are context keys "route"
    for workflow, after, outcome, binding, context, expect_next, expect_mode in cases:
        # Map route context into When expressions route-open / route-empty via key route
        ctx = dict(context)
        if "route" in ctx:
            # when_holds looks up key from "route-open" as key route value open — our expr is route-empty
            # The table uses route-empty which splits on first '=' only if '=' present.
            # route-empty has no '='. Fix: context key stored as the full token's...
            pass
        got_next, got_mode = resolve(chains, transitions, workflow, after, outcome, binding, _route_context(context))
        if (got_next, got_mode) != (expect_next, expect_mode):
            print(
                f"FAIL: {workflow} after {after} outcome {outcome} binding {binding} context {context} "
                f"-> {got_next}/{got_mode} expected {expect_next}/{expect_mode}"
            )
            errors += 1
    if errors == 0:
        print(f"OK: {len(cases)} pipeline transitions")
    return errors


def _route_context(context: dict) -> dict:
    """Allow When 'route-empty' to match context route=empty.

    The pipelines table uses tokens route-empty and route-open. Teach the
    matcher by expanding them into the context the resolver already receives.
    """
    return context


def check_chain_shape(chains) -> int:
    errors = 0
    delivery = assemble(chains, "delivery", default_binding())
    expect = ["architect", "implement", "test", "restructure", "review", "ship"]
    if delivery != expect:
        print(f"FAIL: default delivery chain {delivery} != {expect}")
        errors += 1
    else:
        print("OK: default delivery chain includes architect, test, and restructure")
    heavy = assemble(
        chains,
        "delivery",
        default_binding(side_paths="research+model", sandbox="inject"),
    )
    if heavy[:4] != ["research", "model", "architect", "sandbox"]:
        print(f"FAIL: prefixed delivery chain {heavy}")
        errors += 1
    else:
        print("OK: side paths then architect then sandbox")
    docs = assemble(chains, "delivery", default_binding(**{"test.mode": "skip"}))
    if "test" in docs or "restructure" not in docs:
        print(f"FAIL: docs-only chain must skip test and keep restructure: {docs}")
        errors += 1
    else:
        print("OK: docs-only skips test and keeps restructure")
    adopt = assemble(chains, "adopt", default_binding(klass="adopt", **{"test.mode": "skip"}))
    if adopt != ["architect", "implement", "test", "restructure", "review", "ship"]:
        print(f"FAIL: adopt chain must keep test even if skip requested: {adopt}")
        errors += 1
    else:
        print("OK: adopt chain keeps test and restructure")
    human = assemble(chains, "delivery", default_binding(shipping="human review"))
    expect_human = [
        "architect",
        "implement",
        "test",
        "restructure",
        "review",
        "human review",
        "fix-forward",
        "ship",
    ]
    if human != expect_human:
        print(f"FAIL: human review delivery chain {human} != {expect_human}")
        errors += 1
    else:
        print("OK: human review inserts before ship on delivery")
    automatic = assemble(chains, "delivery", default_binding(shipping="automatic"))
    if automatic != expect:
        print(f"FAIL: automatic shipping changed the delivery chain: {automatic}")
        errors += 1
    else:
        print("OK: automatic shipping keeps today's delivery chain")
    skipped = assemble(
        chains,
        "delivery",
        default_binding(**{"test.mode": "skip", "harden.mode": "skip"}, shipping="human review"),
    )
    if skipped != ["architect", "implement", "review", "human review", "fix-forward", "ship"]:
        print(f"FAIL: human review skips chain {skipped}")
        errors += 1
    else:
        print("OK: human review keeps recorded skips and still inserts")
    prefixed = assemble(
        chains,
        "delivery",
        default_binding(side_paths="research+model", sandbox="inject", shipping="human review"),
    )
    if prefixed[:4] != ["research", "model", "architect", "sandbox"] or prefixed[-4:] != [
        "review",
        "human review",
        "fix-forward",
        "ship",
    ]:
        print(f"FAIL: human review prefixed chain {prefixed}")
        errors += 1
    else:
        print("OK: human review keeps optional prefixes")
    iterate = assemble(chains, "iterate", default_binding(shipping="human review"))
    if iterate != ["implement", "test", "restructure", "review", "human review", "fix-forward", "ship"]:
        print(f"FAIL: human review iterate chain {iterate}")
        errors += 1
    else:
        print("OK: human review iterate chain")
    adopt_human = assemble(
        chains,
        "adopt",
        default_binding(klass="adopt", **{"test.mode": "skip"}, shipping="human review"),
    )
    if adopt_human != [
        "architect",
        "implement",
        "test",
        "restructure",
        "review",
        "human review",
        "fix-forward",
        "ship",
    ]:
        print(f"FAIL: human review adopt chain {adopt_human}")
        errors += 1
    else:
        print("OK: human review adopt chain keeps test")
    return errors


def check_skills(outputs: dict) -> int:
    errors = 0
    for name in INDEPENDENT:
        path = SKILLS / name / "SKILL.md"
        if not path.exists():
            print(f"FAIL: missing skill {path}")
            errors += 1
            continue
        text = path.read_text()
        if "## Inputs" not in text or "## Output" not in text:
            print(f"FAIL: {path} must have ## Inputs and ## Output")
            errors += 1
        else:
            print(f"OK: {name} declares Inputs and Output")
        if "CONCEPT_SKILL" not in text:
            print(f"FAIL: {path} must point at CONCEPT_SKILL")
            errors += 1
        if name not in outputs:
            print(f"FAIL: pipelines Outputs missing {name}")
            errors += 1
            continue
        artifact, _outcome = outputs[name]
        if artifact not in text:
            print(f"FAIL: {path} must name its output {artifact}")
            errors += 1
        for pattern in SUCCESSOR_PATTERNS:
            if re.search(pattern, text):
                print(f"FAIL: {path} names a successor ({pattern})")
                errors += 1
                break
        else:
            print(f"OK: {name} does not name a successor")
    overrides = SKILLS / "define" / "overrides.md"
    text = overrides.read_text()
    for pattern in SUCCESSOR_PATTERNS:
        if re.search(pattern, text):
            print(f"FAIL: {overrides} names a successor")
            errors += 1
            break
    else:
        print("OK: define overrides do not name a successor")
    return errors


def check_no_second_map() -> int:
    errors = 0
    delivery = (ROOT / "skills" / "workflow" / "delivery.md").read_text()
    if re.search(rf"Next `/(?:{SKILL_NAMES})\b", delivery):
        print("FAIL: delivery.md still writes a successor Next")
        errors += 1
    else:
        print("OK: delivery.md does not write a successor Next")
    handoff = (ROOT / "skills" / "workflow" / "handoff.md").read_text()
    if "Default Next by stage" in handoff:
        print("FAIL: handoff.md still has a per-stage Next table")
        errors += 1
    else:
        print("OK: handoff.md defers Next to pipelines.md")
    return errors


def check_prose(text: str) -> int:
    errors = 0
    for needle in (
        "Skills do not carry this map",
        "Apply, do not redefine",
        "Define when absent",
        "immediate",
        "cue",
    ):
        if needle not in text:
            print(f"FAIL: pipelines.md missing '{needle}'")
            errors += 1
        else:
            print(f"OK: pipelines.md contains '{needle}'")
    concept = (ROOT / "skills" / "concepts" / "CONCEPT_SKILL.md").read_text()
    for needle in ("No successor", "Define when absent", "Apply when present", "Workflow writes Next"):
        if needle not in concept:
            print(f"FAIL: CONCEPT_SKILL.md missing '{needle}'")
            errors += 1
        else:
            print(f"OK: CONCEPT_SKILL.md contains '{needle}'")
    return errors


def main() -> int:
    # Patch when_holds so route-empty / route-open match context route=
    global when_holds

    original = when_holds

    def when_holds(expr: str, binding: dict, context: dict) -> bool:
        expr = expr.strip()
        if expr in {"route-empty", "route-open"}:
            return context.get("route") == expr.split("-", 1)[1]
        return original(expr, binding, context)

    text = PIPELINES.read_text()
    chains, transitions, outputs, frontier = load(text)
    if frontier.get("define") != "define" or frontier.get("task") != "none":
        print(f"FAIL: frontier table {frontier}")
        return 1
    print("OK: frontier types map to skills")
    errors = 0
    errors += check_prose(text)
    errors += check_no_second_map()
    errors += check_chain_shape(chains)
    errors += check_resolve(chains, transitions)
    errors += check_skills(outputs)
    if errors:
        print(f"\nPipeline checks failed with {errors} error(s).")
        return 1
    print("\nPipeline checks passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
