#!/usr/bin/env bash
# Checks that install and sync write skills, instructions, and rules only for
# the harness named by SKILLS_HARNESS.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

unset_detect() {
  unset CURSOR_AGENT CLAUDE_CODE CLAUDECODE CLAUDE_CODE_ENTRYPOINT || true
  unset CODEX_THREAD_ID CODEX_SANDBOX CODEX_CI || true
  unset COPILOT_AGENT GITHUB_COPILOT COPILOT_CLI || true
}

assert_absent() {
  local path="$1"
  if [ -e "$path" ]; then
    echo "FAIL: unexpected path $path" >&2
    exit 1
  fi
}

install_as() {
  local harness="$1"
  local proj="$TMP/proj-$harness"
  mkdir -p "$proj"
  unset_detect
  SKILLS_HARNESS="$harness" \
  SKILLS_SOURCE="$ROOT" \
  PROJECT_ROOT="$proj" \
    bash "$ROOT/scripts/install-from-git.sh" >/dev/null
  printf '%s\n' "$proj"
}

echo "copilot project install"
proj="$(install_as copilot)"
test -f "$proj/.github/copilot-instructions.md"
test -f "$proj/.agents/skills/workflows/SKILL.md"
grep -q "Route to a workflow" "$proj/.github/copilot-instructions.md"
grep -q "explicitly says to skip" "$proj/.github/copilot-instructions.md"
grep -q "obviously outside" "$proj/.github/copilot-instructions.md"
grep -q ".agents/skills/workflows/SKILL.md" "$proj/.github/copilot-instructions.md"
assert_absent "$proj/CLAUDE.md"
assert_absent "$proj/AGENTS.md"
assert_absent "$proj/.cursor"
assert_absent "$proj/.claude"
assert_absent "$proj/.codex"
assert_absent "$proj/.copilot"

echo "claude project install"
proj="$(install_as claude)"
test -f "$proj/CLAUDE.md"
test -f "$proj/.claude/skills/workflows/SKILL.md"
grep -q "claude-opus-5-5" "$proj/CLAUDE.md"
grep -q ".claude/skills/workflows/SKILL.md" "$proj/CLAUDE.md"
assert_absent "$proj/.agents"
assert_absent "$proj/AGENTS.md"
assert_absent "$proj/.cursor"
assert_absent "$proj/.github"

echo "cursor project install"
proj="$(install_as cursor)"
test -f "$proj/AGENTS.md"
test -f "$proj/.cursor/rules/github-skills.mdc"
test -f "$proj/.agents/skills/workflows/SKILL.md"
grep -q "composer-2.5" "$proj/.cursor/rules/github-skills.mdc"
grep -q "Route to a workflow" "$proj/AGENTS.md"
assert_absent "$proj/CLAUDE.md"
assert_absent "$proj/.github"
assert_absent "$proj/.claude"

echo "codex project install"
proj="$(install_as codex)"
test -f "$proj/AGENTS.md"
test -f "$proj/.agents/skills/workflows/SKILL.md"
grep -q "gpt-6.1-sol" "$proj/AGENTS.md"
assert_absent "$proj/.cursor"
assert_absent "$proj/CLAUDE.md"
assert_absent "$proj/.github"
assert_absent "$proj/.claude"

echo "refuses all and unknown"
unset_detect
set +e
out="$(SKILLS_HARNESS=all SKILLS_SOURCE="$ROOT" PROJECT_ROOT="$TMP/nope" bash "$ROOT/scripts/install-from-git.sh" 2>&1)"
code=$?
set -e
[ "$code" -ne 0 ]
printf '%s\n' "$out" | grep -q "refused"

set +e
out="$(SKILLS_HARNESS=windsurf SKILLS_SOURCE="$ROOT" PROJECT_ROOT="$TMP/nope" bash "$ROOT/scripts/install-from-git.sh" 2>&1)"
code=$?
set -e
[ "$code" -ne 0 ]
printf '%s\n' "$out" | grep -q "unknown harness"

echo "refuses when no harness is applied"
set +e
out="$(env -u SKILLS_HARNESS -u CURSOR_AGENT -u CLAUDE_CODE -u CLAUDECODE -u CLAUDE_CODE_ENTRYPOINT -u CODEX_THREAD_ID -u CODEX_SANDBOX -u CODEX_CI -u COPILOT_AGENT -u GITHUB_COPILOT -u COPILOT_CLI SKILLS_SOURCE="$ROOT" PROJECT_ROOT="$TMP/nope" bash "$ROOT/scripts/install-from-git.sh" 2>&1)"
code=$?
set -e
[ "$code" -ne 0 ]
printf '%s\n' "$out" | grep -q "no applied harness"

echo "copilot global sync"
home="$TMP/home-copilot"
mkdir -p "$home"
unset_detect
HOME="$home" SKILLS_HARNESS=copilot bash "$ROOT/scripts/sync-local.sh" >/dev/null
test -f "$home/.copilot/skills/workflows/SKILL.md"
test -f "$home/.copilot/copilot-instructions.md"
grep -q "Route to a workflow" "$home/.copilot/copilot-instructions.md"
assert_absent "$home/.claude"
assert_absent "$home/.cursor"
assert_absent "$home/.codex"
assert_absent "$home/.agents"

echo "cursor global sync does not touch Copilot or Claude"
home="$TMP/home-cursor"
mkdir -p "$home"
unset_detect
HOME="$home" SKILLS_HARNESS=cursor bash "$ROOT/scripts/sync-local.sh" >/dev/null
test -f "$home/.cursor/skills/workflows/SKILL.md"
test -f "$home/.cursor/rules/marcuskrogh-skills.mdc"
grep -q "does not approve the plan" "$home/.cursor/rules/marcuskrogh-skills.mdc"
assert_absent "$home/.copilot"
assert_absent "$home/.claude"
assert_absent "$home/.agents"

echo "OK"
