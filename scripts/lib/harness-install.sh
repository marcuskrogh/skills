#!/usr/bin/env bash
# Shared install targets. Source this file; do not execute it.
#
# Writes skill folders, instruction files, and rules only for the applied
# harness. SKILLS_HARNESS overrides detection. There is no "all harnesses"
# default: an unknown harness is a hard stop.

harness_die() { echo "harness-install: $*" >&2; return 1; }

harness_known() {
  case "$1" in
    cursor|claude|codex|copilot) return 0 ;;
    *) return 1 ;;
  esac
}

# Print applied harness ids, one per line.
harness_resolve() {
  local raw="${SKILLS_HARNESS:-}"
  local item
  local -a found=()

  if [ -n "$raw" ]; then
    raw="${raw//,/ }"
    for item in $raw; do
      item="$(printf '%s' "$item" | tr '[:upper:]' '[:lower:]')"
      if [ "$item" = "all" ]; then
        harness_die "SKILLS_HARNESS=all is refused. Name only the harnesses that should receive files (cursor, claude, codex, copilot)."
        return 1
      fi
      if ! harness_known "$item"; then
        harness_die "unknown harness '$item'. Use cursor, claude, codex, or copilot."
        return 1
      fi
      found+=("$item")
    done
  else
    if [ -n "${CURSOR_AGENT:-}" ]; then
      found+=(cursor)
    fi
    if [ -n "${CLAUDE_CODE:-${CLAUDECODE:-${CLAUDE_CODE_ENTRYPOINT:-}}}" ]; then
      found+=(claude)
    fi
    if [ -n "${CODEX_THREAD_ID:-${CODEX_SANDBOX:-${CODEX_CI:-}}}" ]; then
      found+=(codex)
    fi
    if [ -n "${COPILOT_AGENT:-${GITHUB_COPILOT:-${COPILOT_CLI:-}}}" ]; then
      found+=(copilot)
    fi
  fi

  if [ "${#found[@]}" -eq 0 ]; then
    harness_die "no applied harness. Set SKILLS_HARNESS=cursor|claude|codex|copilot. Refusing to write skill folders, instruction files, or rules for harnesses that are not in use."
    return 1
  fi

  printf '%s\n' "${found[@]}" | awk '!seen[$0]++'
}

# Project-relative skill directory for this harness.
harness_project_skills_rel() {
  case "$1" in
    claude) printf '%s\n' ".claude/skills" ;;
    cursor|codex|copilot) printf '%s\n' ".agents/skills" ;;
    *) return 1 ;;
  esac
}

# Home-relative skill directory for this harness.
harness_global_skills_rel() {
  case "$1" in
    claude) printf '%s\n' ".claude/skills" ;;
    cursor) printf '%s\n' ".cursor/skills" ;;
    codex) printf '%s\n' ".codex/skills" ;;
    copilot) printf '%s\n' ".copilot/skills" ;;
    *) return 1 ;;
  esac
}

# Token substituted into instruction templates.
harness_skills_token() {
  local harness="$1"
  local scope="$2"
  if [ "$scope" = "global" ]; then
    case "$harness" in
      claude) printf '%s\n' "~/.claude/skills" ;;
      cursor) printf '%s\n' "~/.cursor/skills" ;;
      codex) printf '%s\n' "~/.codex/skills" ;;
      copilot) printf '%s\n' "~/.copilot/skills" ;;
    esac
  else
    harness_project_skills_rel "$harness"
  fi
}

harness_selected() {
  local want="$1"
  local id
  for id in "$@"; do
    [ "$id" = "$want" ] && return 0
  done
  # first arg is want; remaining were expanded wrong if called as harness_selected cursor "${arr[@]}"
  return 1
}

harness_has() {
  local want="$1"
  shift
  local id
  for id in "$@"; do
    [ "$id" = "$want" ] && return 0
  done
  return 1
}
