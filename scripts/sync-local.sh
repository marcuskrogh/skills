#!/usr/bin/env bash
# Sync skills from this repo to the applied harness only.
# Usage: ./scripts/sync-local.sh [--prune] [--link] [--harness cursor|claude|codex|copilot]
#
# SKILLS_HARNESS or --harness selects the harness. When both are absent, detect
# the harness that is running this script. Skill folders, instruction files, and
# rules are written only for that harness.
#
# For project installs prefer: bash scripts/install-from-git.sh
# Also supported: npx skills add marcuskrogh/skills

set -euo pipefail

PRUNE=false
LINK=false

while [ $# -gt 0 ]; do
  case "$1" in
    --prune) PRUNE=true ;;
    --link) LINK=true ;;
    --harness)
      shift
      [ $# -gt 0 ] || { echo "Missing value for --harness" >&2; exit 1; }
      SKILLS_HARNESS="$1"
      ;;
    --harness=*)
      SKILLS_HARNESS="${1#--harness=}"
      ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
  shift
done

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/skills"
CONCEPTS_SOURCE="$SOURCE_DIR/concepts"
# shellcheck source=lib/harness-install.sh
source "$REPO_ROOT/scripts/lib/harness-install.sh"

HARNESSES=()
while IFS= read -r harness; do
  [ -n "$harness" ] || continue
  HARNESSES+=("$harness")
done < <(harness_resolve) || exit 1
[ "${#HARNESSES[@]}" -gt 0 ] || exit 1
TARGET_DIRS=()
for harness in "${HARNESSES[@]}"; do
  rel="$(harness_global_skills_rel "$harness")"
  TARGET_DIRS+=("${HOME}/${rel}")
done

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source directory not found: $SOURCE_DIR" >&2
  exit 1
fi

if [[ ! -d "$CONCEPTS_SOURCE" ]]; then
  echo "Concepts directory not found: $CONCEPTS_SOURCE" >&2
  exit 1
fi

mapfile -t SKILL_PATHS < <(find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -type d ! -name concepts -exec test -f "{}/SKILL.md" \; -print | sort)
if [[ ${#SKILL_PATHS[@]} -eq 0 ]]; then
  echo "No skills with SKILL.md found under $SOURCE_DIR" >&2
  exit 1
fi

sync_item() {
  local source_path="$1"
  local dest="$2"
  local label="$3"

  if $LINK; then
    rm -rf "$dest"
    ln -s "$source_path" "$dest"
    echo "Linked ($label)"
  else
    rm -rf "$dest"
    cp -R "$source_path" "$dest"
    echo "Copied ($label)"
  fi
}

for TARGET_DIR in "${TARGET_DIRS[@]}"; do
  mkdir -p "$TARGET_DIR"
  SYNCED=()

  for skill_path in "${SKILL_PATHS[@]}"; do
    skill_name="$(basename "$skill_path")"
    dest="$TARGET_DIR/$skill_name"
    sync_item "$skill_path" "$dest" "$TARGET_DIR: $skill_name"
    SYNCED+=("$skill_name")
  done

  sync_item "$CONCEPTS_SOURCE" "$TARGET_DIR/concepts" "$TARGET_DIR: concepts"
  SYNCED+=("concepts")

  if $PRUNE; then
    for existing in "$TARGET_DIR"/*; do
      [[ -d "$existing" ]] || continue
      name="$(basename "$existing")"
      found=false
      for synced in "${SYNCED[@]}"; do
        if [[ "$synced" == "$name" ]]; then
          found=true
          break
        fi
      done
      if ! $found; then
        echo "Pruning ($TARGET_DIR): $name"
        rm -rf "$existing"
      fi
    done
  fi

  echo "Synced ${#SYNCED[@]} item(s) to $TARGET_DIR"
done

upsert_marked_block() {
  local dest="$1"
  local block_file="$2"
  local begin="<!-- marcuskrogh/skills:begin -->"
  local end="<!-- marcuskrogh/skills:end -->"
  local tmp before after

  mkdir -p "$(dirname "$dest")"
  tmp="$(mktemp)"
  cat "$block_file" > "$tmp"
  if [ -s "$tmp" ] && [ "$(tail -c 1 "$tmp" | wc -l)" -eq 0 ]; then
    echo >> "$tmp"
  fi

  if [ ! -f "$dest" ]; then
    mv "$tmp" "$dest"
    echo "Wrote $dest"
    return
  fi

  if grep -qF "$begin" "$dest"; then
    before="$(mktemp)"
    after="$(mktemp)"
    awk -v b="$begin" -v e="$end" '
      $0 == b { exit }
      { print }
    ' "$dest" > "$before"
    awk -v b="$begin" -v e="$end" '
      $0 == e { saw_end=1; next }
      saw_end { print }
    ' "$dest" > "$after"
    {
      cat "$before"
      cat "$tmp"
      if [ -s "$after" ]; then
        first="$(head -n 1 "$after")"
        if [ -n "$first" ]; then
          echo ""
        fi
        cat "$after"
      fi
    } > "$dest"
    rm -f "$before" "$after" "$tmp"
    echo "Updated $dest"
  else
    {
      cat "$tmp"
      echo ""
      cat "$dest"
    } > "${tmp}.out"
    mv "${tmp}.out" "$dest"
    rm -f "$tmp"
    echo "Prepended $dest"
  fi
}

echo ""
echo "Wiring instruction files for: ${HARNESSES[*]}"
TPL="$REPO_ROOT/templates/agent-install"
for harness in "${HARNESSES[@]}"; do
  token="$(harness_skills_token "$harness" global)"
  case "$harness" in
    cursor)
      if [ ! -f "$TPL/global-cursor-language.mdc" ]; then
        echo "WARN: missing $TPL/global-cursor-language.mdc" >&2
        exit 1
      fi
      mkdir -p "${HOME}/.cursor/rules"
      cp "$TPL/global-cursor-language.mdc" "${HOME}/.cursor/rules/marcuskrogh-skills.mdc"
      echo "Wrote ${HOME}/.cursor/rules/marcuskrogh-skills.mdc"
      ;;
    claude)
      if [ ! -f "$TPL/global-CLAUDE.block.md" ]; then
        echo "WARN: missing $TPL/global-CLAUDE.block.md" >&2
        exit 1
      fi
      upsert_marked_block "${HOME}/.claude/CLAUDE.md" "$TPL/global-CLAUDE.block.md"
      ;;
    codex)
      rendered="$(mktemp)"
      sed "s|__SKILLS__|${token}|g" "$TPL/harness/codex.md" > "$rendered"
      upsert_marked_block "${HOME}/.codex/AGENTS.md" "$rendered"
      rm -f "$rendered"
      ;;
    copilot)
      rendered="$(mktemp)"
      sed "s|__SKILLS__|${token}|g" "$TPL/harness/copilot.md" > "$rendered"
      upsert_marked_block "${HOME}/.copilot/copilot-instructions.md" "$rendered"
      rm -f "$rendered"
      ;;
  esac
done

echo ""
echo "Tip: for project installs, prefer agent-from-git:"
echo "  bash scripts/install-from-git.sh"
echo "Also supported: npx skills add marcuskrogh/skills"
