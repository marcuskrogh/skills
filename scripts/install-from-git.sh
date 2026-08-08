#!/usr/bin/env bash
# Canonical project install of marcuskrogh/skills from git.
#
# Agents MUST use this script (or the documented agent prompt that runs it)
# for from-git installs. Do not freestyle: no partial copies, no alternate
# trees, no inventing AGENTS.md wording.
#
# Humans may instead use: npx skills add marcuskrogh/skills
#
# Usage (preferred — agent already cloned this repo, or curl|bash):
#   # from consuming project root, with a local clone of marcuskrogh/skills:
#   bash /path/to/marcuskrogh-skills/scripts/install-from-git.sh
#
#   # bootstrap without a prior clone (project root = cwd):
#   curl -fsSL https://raw.githubusercontent.com/marcuskrogh/skills/main/scripts/install-from-git.sh | bash
#
# Env:
#   PROJECT_ROOT   — consuming repo root (default: cwd)
#   SKILLS_REPO    — git URL (default: https://github.com/marcuskrogh/skills.git)
#   SKILLS_REF     — branch, tag, or commit (default: main)
#   SKILLS_CACHE   — clone cache (default: /tmp/marcuskrogh-skills)
#   SKIP_POINTERS  — if set to 1, skip AGENTS.md / CLAUDE.md / Cursor rule
#   SKILLS_SOURCE  — override: path to an already-checked-out skills repo root
set -euo pipefail

SKILLS_REPO="${SKILLS_REPO:-https://github.com/marcuskrogh/skills.git}"
SKILLS_REF="${SKILLS_REF:-main}"
CACHE_DIR="${SKILLS_CACHE:-/tmp/marcuskrogh-skills}"
PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"
SKIP_POINTERS="${SKIP_POINTERS:-0}"
TARGET_DIR="${PROJECT_ROOT}/.agents/skills"
SOURCE_REL="skills"

die() { echo "install-from-git: $*" >&2; exit 1; }

resolve_skills_root() {
  # 1) Explicit override (local author testing / custom checkout)
  if [ -n "${SKILLS_SOURCE:-}" ]; then
    printf '%s\n' "$SKILLS_SOURCE"
    return
  fi

  # 2) Script lives inside a skills clone (…/scripts/install-from-git.sh).
  #    Use that checkout only when it already resolves to SKILLS_REF — otherwise
  #    fall through to the cache so pins (tags/SHAs) are honoured.
  local script_path script_dir candidate head want
  script_path="${BASH_SOURCE[0]:-}"
  if [ -n "$script_path" ] && [ -f "$script_path" ]; then
    script_dir="$(cd "$(dirname "$script_path")" && pwd)"
    candidate="$(cd "$script_dir/.." && pwd)"
    if [ -d "$candidate/$SOURCE_REL" ] && [ -f "$candidate/$SOURCE_REL/workflows/SKILL.md" ]; then
      if git -C "$candidate" rev-parse --verify --quiet "${SKILLS_REF}^{commit}" >/dev/null 2>&1; then
        head="$(git -C "$candidate" rev-parse HEAD)"
        want="$(git -C "$candidate" rev-parse "${SKILLS_REF}^{commit}")"
        if [ "$head" = "$want" ]; then
          printf '%s\n' "$candidate"
          return
        fi
      fi
    fi
  fi

  # 3) Cache clone at requested ref
  ensure_cache_at_ref "$SKILLS_REPO" "$SKILLS_REF" "$CACHE_DIR"
  printf '%s\n' "$CACHE_DIR"
}

ensure_cache_at_ref() {
  local repo="$1"
  local ref="$2"
  local cache="$3"

  if [ -d "$cache/.git" ]; then
    git -C "$cache" remote set-url origin "$repo"
  else
    rm -rf "$cache"
    mkdir -p "$(dirname "$cache")"
    git clone --depth 1 "$repo" "$cache"
  fi

  if ! git -C "$cache" fetch --depth 1 origin "$ref"; then
    git -C "$cache" fetch --depth 1 origin "+${ref}:refs/fetch-skills" \
      || git -C "$cache" fetch --depth 1 --tags origin "$ref" \
      || die "could not fetch ref: $ref (repo: $repo)"
  fi

  if git -C "$cache" rev-parse --verify --quiet FETCH_HEAD >/dev/null; then
    git -C "$cache" checkout -f --detach FETCH_HEAD
  elif git -C "$cache" rev-parse --verify --quiet "refs/fetch-skills" >/dev/null; then
    git -C "$cache" checkout -f --detach "refs/fetch-skills"
  elif git -C "$cache" rev-parse --verify --quiet "$ref" >/dev/null; then
    git -C "$cache" checkout -f --detach "$ref"
  else
    die "could not resolve skills ref: $ref (repo: $repo)"
  fi
}

copy_tree() {
  local src="$1"
  local dest="$2"
  if command -v rsync >/dev/null 2>&1; then
    rsync -a "$src" "$dest"
  else
    cp -a "$src" "$dest"
  fi
}

install_skills() {
  local skills_root="$1"
  local source_dir="$skills_root/$SOURCE_REL"

  [ -d "$source_dir" ] || die "skills source not found: $source_dir"
  [ -f "$source_dir/workflows/SKILL.md" ] || die "workflows skill missing under $source_dir"

  mkdir -p "$TARGET_DIR"
  # Replace install tree entirely so stale skills / concepts cannot linger.
  find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

  local skill_path name
  for skill_path in "$source_dir"/*; do
    [ -d "$skill_path" ] || continue
    name="$(basename "$skill_path")"
    if [ "$name" = "concepts" ]; then
      copy_tree "$skill_path" "$TARGET_DIR/"
      continue
    fi
    [ -f "$skill_path/SKILL.md" ] || continue
    copy_tree "$skill_path" "$TARGET_DIR/"
  done

  [ -d "$TARGET_DIR/concepts" ] || die "concepts/ missing after install"
  [ -f "$TARGET_DIR/workflows/SKILL.md" ] || die "workflows/ missing after install"

  local sha short_sha
  sha="$(git -C "$skills_root" rev-parse HEAD 2>/dev/null || true)"
  short_sha="$(git -C "$skills_root" rev-parse --short HEAD 2>/dev/null || echo unknown)"
  cat > "$TARGET_DIR/.skills-version" <<EOF
repo=$SKILLS_REPO
ref=$SKILLS_REF
sha=$sha
synced_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
method=install-from-git
EOF

  echo "Installed skills + concepts → $TARGET_DIR"
  echo "Version: $SKILLS_REF @ $short_sha ($SKILLS_REPO)"
}

upsert_agents_block() {
  local dest="$1"
  local block_file="$2"
  local begin="<!-- marcuskrogh/skills:begin -->"
  local end="<!-- marcuskrogh/skills:end -->"
  local tmp before after

  tmp="$(mktemp)"
  # Ensure block file ends with a newline
  cat "$block_file" > "$tmp"
  if [ -s "$tmp" ] && [ "$(tail -c 1 "$tmp" | wc -l)" -eq 0 ]; then
    echo >> "$tmp"
  fi

  if [ ! -f "$dest" ]; then
    mv "$tmp" "$dest"
    return
  fi

  if grep -qF "$begin" "$dest"; then
    before="$(mktemp)"
    after="$(mktemp)"
    # Keep lines before begin marker (exclusive) and after end marker (exclusive).
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
      # If before was non-empty and does not end with blank line, still fine —
      # block is self-contained.
      cat "$tmp"
      # Preserve a blank line before leftover content when present.
      if [ -s "$after" ]; then
        first="$(head -n 1 "$after")"
        if [ -n "$first" ]; then
          echo ""
        fi
        cat "$after"
      fi
    } > "$dest"
    rm -f "$before" "$after" "$tmp"
  else
    {
      cat "$tmp"
      echo ""
      cat "$dest"
    } > "${tmp}.out"
    mv "${tmp}.out" "$dest"
    rm -f "$tmp"
  fi
}

write_fallback_block() {
  # Keep in sync with templates/agent-install/AGENTS.block.md
  cat > "$1" <<'EOF'
<!-- marcuskrogh/skills:begin -->
**Prefer workflow.** When the user describes a feature, bug, tweak, problem, idea,
investigation, or follow-up — even without naming a skill — invoke
[`.agents/skills/workflows/SKILL.md`](.agents/skills/workflows/SKILL.md): infer
the supported pipeline, then load and run only that skill. Do not freestyle
coding or ad-hoc planning when a catalog workflow fits.

Continuation cues: bare **next** / **ship** still apply (see
`.agents/skills/workflow/reference.md`). Explicit `/skill` names win over
re-routing.

Authoring skills or concepts → [`.agents/skills/writing-for-agents/SKILL.md`](.agents/skills/writing-for-agents/SKILL.md).
<!-- marcuskrogh/skills:end -->
EOF
}

write_fallback_cursor_rule() {
  # Keep in sync with templates/agent-install/github-skills.mdc
  cat > "$1" <<'EOF'
---
description: Prefer supported workflows for any described work
alwaysApply: true
---

When the user describes a feature, bug, tweak, refine, problem, idea, or other work to deliver,
prefer the model-invoked **workflows** skill: infer which pipeline fits, then
read and run only that skill. Do not freestyle past a supported workflow.

Repo skills: https://github.com/marcuskrogh/skills
Installed at: `.agents/skills/`
EOF
}

install_pointers() {
  local skills_root="$1"
  local tpl="$skills_root/templates/agent-install"
  local block_file rule_file

  block_file="$(mktemp)"
  rule_file="$(mktemp)"
  if [ -f "$tpl/AGENTS.block.md" ]; then
    cp "$tpl/AGENTS.block.md" "$block_file"
  else
    write_fallback_block "$block_file"
  fi
  if [ -f "$tpl/github-skills.mdc" ]; then
    cp "$tpl/github-skills.mdc" "$rule_file"
  else
    write_fallback_cursor_rule "$rule_file"
  fi

  upsert_agents_block "$PROJECT_ROOT/AGENTS.md" "$block_file"

  # CLAUDE.md: symlink to AGENTS.md when absent or already our symlink.
  local claude="$PROJECT_ROOT/CLAUDE.md"
  if [ -L "$claude" ] || [ ! -e "$claude" ]; then
    ln -sfn AGENTS.md "$claude"
  else
    upsert_agents_block "$claude" "$block_file"
  fi

  mkdir -p "$PROJECT_ROOT/.cursor/rules"
  cp "$rule_file" "$PROJECT_ROOT/.cursor/rules/github-skills.mdc"
  rm -f "$block_file" "$rule_file"

  echo "Wired pointers:"
  echo "  AGENTS.md"
  echo "  CLAUDE.md"
  echo "  .cursor/rules/github-skills.mdc"
}

print_commit_hint() {
  cat <<EOF

Commit these paths in the consuming repo:
  .agents/skills/
  AGENTS.md
  CLAUDE.md
  .cursor/rules/github-skills.mdc

Done. Prefer workflow is now active via .agents/skills/workflows/.
EOF
}

# --- main ---
[ -d "$PROJECT_ROOT" ] || die "PROJECT_ROOT is not a directory: $PROJECT_ROOT"
PROJECT_ROOT="$(cd "$PROJECT_ROOT" && pwd)"

SKILLS_ROOT="$(resolve_skills_root)"
[ -d "$SKILLS_ROOT" ] || die "skills root not found"

install_skills "$SKILLS_ROOT"
if [ "$SKIP_POINTERS" != "1" ]; then
  install_pointers "$SKILLS_ROOT"
fi
print_commit_hint
