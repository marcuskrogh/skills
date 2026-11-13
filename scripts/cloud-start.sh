#!/usr/bin/env bash
# Cursor cloud install and start: refresh .agents/skills/ from skills main.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_REF=main bash "$ROOT/.agents/sync-skills.sh"
