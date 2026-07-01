#!/usr/bin/env bash
# Sync skills from this repo to ~/.cursor/skills/ for local IDE use.
# Usage: ./scripts/sync-local.sh [--prune] [--link]

set -euo pipefail

PRUNE=false
LINK=false

for arg in "$@"; do
  case "$arg" in
    --prune) PRUNE=true ;;
    --link) LINK=true ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/.cursor/skills"
TARGET_DIR="${HOME}/.cursor/skills"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source directory not found: $SOURCE_DIR" >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"
SYNCED=()

for skill_path in "$SOURCE_DIR"/*; do
  [[ -d "$skill_path" ]] || continue
  skill_name="$(basename "$skill_path")"
  dest="$TARGET_DIR/$skill_name"

  if $LINK; then
    rm -rf "$dest"
    ln -s "$skill_path" "$dest"
    echo "Linked: $skill_name"
  else
    rm -rf "$dest"
    cp -R "$skill_path" "$dest"
    echo "Copied: $skill_name"
  fi

  SYNCED+=("$skill_name")
done

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
      echo "Pruning: $name"
      rm -rf "$existing"
    fi
  done
fi

echo ""
echo "Synced ${#SYNCED[@]} skill(s) to $TARGET_DIR"
