#!/usr/bin/env bash
# Fetch personal Cursor skills from cursor-skills into .cursor/skills/ (cloud VM startup).
set -euo pipefail

SKILLS_REPO="${CURSOR_SKILLS_REPO:-https://github.com/marcuskrogh/cursor-skills.git}"
CACHE_DIR="${CURSOR_SKILLS_CACHE:-/tmp/cursor-skills}"
TARGET_DIR=".cursor/skills"

if [ -d "$CACHE_DIR/.git" ]; then
  git -C "$CACHE_DIR" pull --ff-only
else
  git clone --depth 1 "$SKILLS_REPO" "$CACHE_DIR"
fi

if [ ! -d "$CACHE_DIR/.cursor/skills" ]; then
  echo "Skills source not found in $CACHE_DIR/.cursor/skills" >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"

if command -v rsync >/dev/null 2>&1; then
  rsync -a --delete "$CACHE_DIR/.cursor/skills/" "$TARGET_DIR/"
else
  find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
  cp -a "$CACHE_DIR/.cursor/skills/." "$TARGET_DIR/"
fi

echo "Synced cursor skills to $TARGET_DIR"
