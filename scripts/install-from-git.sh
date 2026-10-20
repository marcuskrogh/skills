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
#   SKIP_POINTERS  — if set to 1, skip instruction files and rules
#   SKILLS_SOURCE  — override: path to an already-checked-out skills repo root
#   SKILLS_HARNESS — cursor, claude, codex, and/or copilot (comma-separated).
#                    When unset, detect the harness that is running this script.
#                    Files are written only for those harnesses. "all" is refused.
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
  local dest_root="$2"
  local source_dir="$skills_root/$SOURCE_REL"

  [ -d "$source_dir" ] || die "skills source not found: $source_dir"
  [ -f "$source_dir/workflows/SKILL.md" ] || die "workflows skill missing under $source_dir"

  mkdir -p "$dest_root"
  # Replace install tree entirely so stale skills / concepts cannot linger.
  find "$dest_root" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

  local skill_path name
  for skill_path in "$source_dir"/*; do
    [ -d "$skill_path" ] || continue
    name="$(basename "$skill_path")"
    if [ "$name" = "concepts" ]; then
      copy_tree "$skill_path" "$dest_root/"
      continue
    fi
    [ -f "$skill_path/SKILL.md" ] || continue
    copy_tree "$skill_path" "$dest_root/"
  done

  [ -d "$dest_root/concepts" ] || die "concepts/ missing after install"
  [ -f "$dest_root/workflows/SKILL.md" ] || die "workflows/ missing after install"

  local sha short_sha
  sha="$(git -C "$skills_root" rev-parse HEAD 2>/dev/null || true)"
  short_sha="$(git -C "$skills_root" rev-parse --short HEAD 2>/dev/null || echo unknown)"
  cat > "$dest_root/.skills-version" <<EOF
repo=$SKILLS_REPO
ref=$SKILLS_REF
sha=$sha
synced_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
method=install-from-git
EOF

  echo "Installed skills + concepts → $dest_root"
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
**Route to a workflow.** When these skills are installed, route every request through the catalog workflow unless the user explicitly says to skip that routing, or the request is obviously outside what these skills apply to. Invoke [`.agents/skills/workflows/SKILL.md`](.agents/skills/workflows/SKILL.md).
**Front doors:** foggy → explore; concrete → define. Define interviews for
alignment, then classifies and binds a workflow. A short description starts that
interview; it does not approve the plan. Skills do not name the next skill; the
bound workflow writes persisted **Next**. Follow that cue. A reply that
finishes a skill ends with the exact `## Next` block (`/<skill> <KEY>` — why).
An open alignment question does not include that block. Do not freestyle
coding or ad-hoc planning when a catalog workflow fits.

Continuation cues: bare **next** / **ship** still apply (see
`.agents/skills/workflow/reference.md`). Explicit `/skill` names win over
re-routing. Lost on which skill to use → [`.agents/skills/help/SKILL.md`](.agents/skills/help/SKILL.md).

**Cursor models (catalog-closed).** On Cursor (Desktop, Cloud, CLI, Mobile), every `Task` spawn of any type —
including `computerUse` and `videoReview` — must pass an explicit `model`
slug from the Cursor Models allowlist only: `composer-2.5` (Routine /
Moderate) or `cursor-grok-4.6-high` (Demanding / manager). Only `composer-*`
and `cursor-grok-*` slugs are provably first-party; bare `grok-*` and
third-party picker slugs bill **Other Models**. If the chosen slug is absent
from the Task enum, pass the other allowlisted slug, else `composer-2.5`.
Never `inherit`, omit `model`, or pick a picker slug. No `*-fast` variants.
Load
[`.agents/skills/concepts/CONCEPT_DELEGATION.md`](.agents/skills/concepts/CONCEPT_DELEGATION.md)
and [`.agents/skills/concepts/platforms/cursor.md`](.agents/skills/concepts/platforms/cursor.md)
before every spawn.

**Language.** Before any reply the operator will see, read
[`.agents/skills/concepts/CONCEPT_LANGUAGE.md`](.agents/skills/concepts/CONCEPT_LANGUAGE.md),
[`.agents/skills/concepts/LANGUAGE-PHRASES.md`](.agents/skills/concepts/LANGUAGE-PHRASES.md),
and [`.agents/skills/concepts/LANGUAGE-HUMANIZER.md`](.agents/skills/concepts/LANGUAGE-HUMANIZER.md).
Follow those files. Spell names in full (`GeneralProcessSimulator`, not `GPS`).
Keep **harness** for the agent host (Cursor, Claude Code, Codex, …). Do not call
a sandbox tree, wrapper, or other code a harness.

Authoring skills or concepts → [`.agents/skills/writing-for-agents/SKILL.md`](.agents/skills/writing-for-agents/SKILL.md).
<!-- marcuskrogh/skills:end -->
EOF
}

write_fallback_cursor_rule() {
  # Keep in sync with templates/agent-install/github-skills.mdc
  cat > "$1" <<'EOF'
---
description: Prefer supported workflows and Cursor first-party models
alwaysApply: true
---

When the user describes work to deliver, prefer the model-invoked **workflows**
skill. Front doors: foggy → **explore**; concrete → **define**, which interviews
for alignment, then classifies and binds a workflow. A short description starts
that interview; it does not approve the plan. Skills do not name the next skill;
the bound workflow writes persisted **Next**. Follow that cue. A reply
that finishes a skill ends with the exact `## Next` block (`/<skill> <KEY>` — why).
An open alignment question does not include that block. Do not freestyle past
a supported workflow. For a navigation overview only, prefer **help**.

On Cursor (Desktop, Cloud, CLI, Mobile), every Task spawn of any type —
including computerUse and videoReview — must pass an explicit `model` slug
from the Cursor Models allowlist only: `composer-2.5` (Routine/Moderate) or
`cursor-grok-4.6-high` (Demanding/manager). Only `composer-*` and
`cursor-grok-*` slugs are provably first-party; bare `grok-*` and picker
slugs bill Other Models. If the chosen slug is absent from the Task enum,
pass the other allowlisted slug, else `composer-2.5`. Never inherit, omit
model, or pick a picker slug. No `*-fast` variants. Load
CONCEPT_DELEGATION and `concepts/platforms/cursor.md` before every spawn.

Language: before any reply the operator will see, read
`.agents/skills/concepts/CONCEPT_LANGUAGE.md`,
`.agents/skills/concepts/LANGUAGE-PHRASES.md`, and
`.agents/skills/concepts/LANGUAGE-HUMANIZER.md`. Follow those files. Spell names
in full (`GeneralProcessSimulator`, not `GPS`). Keep **harness** for the agent
host (Cursor, Claude Code, Codex, …). Do not call a sandbox tree, wrapper, or
other code a harness.

Repo skills: https://github.com/marcuskrogh/skills
EOF
}

render_harness_block() {
  local template="$1"
  local token="$2"
  local dest="$3"
  sed "s|__SKILLS__|${token}|g" "$template" > "$dest"
}

install_pointers() {
  local skills_root="$1"
  shift
  local -a harnesses=("$@")
  local tpl="$skills_root/templates/agent-install"
  local harness token block_file rule_file
  local -a wrote=()

  block_file="$(mktemp)"
  rule_file="$(mktemp)"

  for harness in "${harnesses[@]}"; do
    token="$(harness_skills_token "$harness" project)"
    case "$harness" in
      cursor)
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
        mkdir -p "$PROJECT_ROOT/.cursor/rules"
        cp "$rule_file" "$PROJECT_ROOT/.cursor/rules/github-skills.mdc"
        wrote+=("AGENTS.md" ".cursor/rules/github-skills.mdc")
        ;;
      claude)
        if [ -f "$tpl/harness/claude.md" ]; then
          render_harness_block "$tpl/harness/claude.md" "$token" "$block_file"
        else
          die "missing Claude instruction template: $tpl/harness/claude.md"
        fi
        local claude="$PROJECT_ROOT/CLAUDE.md"
        if [ -L "$claude" ]; then
          rm -f "$claude"
        fi
        upsert_agents_block "$claude" "$block_file"
        wrote+=("CLAUDE.md")
        ;;
      codex)
        if [ -f "$tpl/harness/codex.md" ]; then
          render_harness_block "$tpl/harness/codex.md" "$token" "$block_file"
        else
          die "missing Codex instruction template: $tpl/harness/codex.md"
        fi
        upsert_agents_block "$PROJECT_ROOT/AGENTS.md" "$block_file"
        wrote+=("AGENTS.md")
        ;;
      copilot)
        if [ -f "$tpl/harness/copilot.md" ]; then
          render_harness_block "$tpl/harness/copilot.md" "$token" "$block_file"
        else
          die "missing Copilot instruction template: $tpl/harness/copilot.md"
        fi
        mkdir -p "$PROJECT_ROOT/.github"
        upsert_agents_block "$PROJECT_ROOT/.github/copilot-instructions.md" "$block_file"
        wrote+=(".github/copilot-instructions.md")
        ;;
    esac
  done

  rm -f "$block_file" "$rule_file"

  echo "Wired for: ${harnesses[*]}"
  printf '  %s\n' "${wrote[@]}"
  WROTE_PATHS=("${wrote[@]}")
}

print_commit_hint() {
  local path
  cat <<EOF

Commit these paths in the consuming repo:
EOF
  for path in "${WROTE_PATHS[@]}"; do
    printf '  %s\n' "$path"
  done
  cat <<EOF

Done. Workflow routing is active for the applied harness only.
EOF
}

# --- main ---
SKILLS_ROOT="$(resolve_skills_root)"
[ -d "$SKILLS_ROOT" ] || die "skills root not found"

LIB="$SKILLS_ROOT/scripts/lib/harness-install.sh"
[ -f "$LIB" ] || die "missing $LIB"
# shellcheck source=lib/harness-install.sh
source "$LIB"

HARNESSES=()
while IFS= read -r harness; do
  [ -n "$harness" ] || continue
  HARNESSES+=("$harness")
done < <(harness_resolve) || die "could not resolve applied harness"
[ "${#HARNESSES[@]}" -gt 0 ] || die "could not resolve applied harness"
if harness_has cursor "${HARNESSES[@]}" && harness_has codex "${HARNESSES[@]}"; then
  die "cursor and codex both write AGENTS.md. Install one of them at a time."
fi

[ -d "$PROJECT_ROOT" ] || die "PROJECT_ROOT is not a directory: $PROJECT_ROOT"
PROJECT_ROOT="$(cd "$PROJECT_ROOT" && pwd)"

seen_skill_dirs=" "
WROTE_PATHS=()
for harness in "${HARNESSES[@]}"; do
  rel="$(harness_project_skills_rel "$harness")"
  case "$seen_skill_dirs" in
    *" $rel "*) continue ;;
  esac
  seen_skill_dirs="$seen_skill_dirs$rel "
  install_skills "$SKILLS_ROOT" "$PROJECT_ROOT/$rel"
  WROTE_PATHS+=("$rel/")
done

if [ "$SKIP_POINTERS" != "1" ]; then
  install_pointers "$SKILLS_ROOT" "${HARNESSES[@]}"
fi
print_commit_hint
