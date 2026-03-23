#!/usr/bin/env bash
# pre-compact.sh — Preserve critical novel state during context compaction
# Outputs the most essential information so it survives compaction

set -euo pipefail

VAULT_PATH="${OBSIDIAN_VAULT_PATH:-}"

if [ -z "$VAULT_PATH" ]; then
  dir="$(pwd)"
  while [ "$dir" != "/" ]; do
    if [ -f "$dir/Novel State.md" ]; then
      VAULT_PATH="$dir"
      break
    fi
    dir="$(dirname "$dir")"
  done
fi

if [ -z "$VAULT_PATH" ] || [ ! -f "$VAULT_PATH/Novel State.md" ]; then
  echo "NOVEL_STATE: No vault found"
  exit 0
fi

STATE_FILE="$VAULT_PATH/Novel State.md"

# Extract critical fields
title=$(sed -n '/^---$/,/^---$/{ /^title:/{ s/^title: *"*//; s/"*$//; p; } }' "$STATE_FILE")
phase=$(sed -n '/^---$/,/^---$/{ /^phase:/{ s/^phase: *//; p; } }' "$STATE_FILE")

echo "=== NOVEL STATE (preserve across compaction) ==="
echo "Title: ${title:-Untitled}"
echo "Phase: ${phase:-unknown}"
echo "Vault: $VAULT_PATH"

# Character names
echo "Characters:"
if [ -d "$VAULT_PATH/Characters" ]; then
  find "$VAULT_PATH/Characters" -name "*.md" -type f | sort | while read -r char; do
    echo "  - $(basename "$char" .md)"
  done
fi

# Current chapter being worked on (most recently modified in Manuscript/)
echo "Current work:"
if [ -d "$VAULT_PATH/Manuscript" ]; then
  latest=$(find "$VAULT_PATH/Manuscript" -name "*.md" -type f -exec ls -t {} + 2>/dev/null | head -1)
  if [ -n "$latest" ]; then
    echo "  Last modified chapter: $(basename "$latest" .md)"
    status=$(sed -n '/^---$/,/^---$/{ /^status:/{ s/^status: *//; p; } }' "$latest")
    echo "  Status: ${status:-unknown}"
  fi
fi

# Active critique stage
echo "Active critiques:"
if [ -d "$VAULT_PATH/Critique" ]; then
  for critique_dir in "$VAULT_PATH/Critique"/Chapter-*/; do
    if [ -d "$critique_dir" ]; then
      ledger="$critique_dir/approval-ledger.json"
      if [ -f "$ledger" ]; then
        chapter_name=$(basename "$critique_dir")
        stages_done=$(grep -o '"stages_completed": *[0-9]*' "$ledger" | grep -o '[0-9]*' || echo "0")
        if [ "$stages_done" -lt 5 ] 2>/dev/null; then
          echo "  $chapter_name — in progress at stage $((stages_done + 1))"
        fi
      fi
    fi
  done
fi

echo "=== END NOVEL STATE ==="
