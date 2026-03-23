#!/usr/bin/env bash
# session-start.sh — Load novel vault context at session start
# Walks up from CWD or checks OBSIDIAN_VAULT_PATH to find Novel State.md
# Outputs a context summary for the Claude session

set -euo pipefail

# Locate the vault
VAULT_PATH="${OBSIDIAN_VAULT_PATH:-}"

if [ -z "$VAULT_PATH" ]; then
  # Walk up from CWD looking for Novel State.md
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
  echo "No Obsidian vault found. Set OBSIDIAN_VAULT_PATH or run /novel-init to create a vault."
  exit 0
fi

echo "=== Novel Studio — Session Context ==="
echo ""

# Extract frontmatter fields from Novel State.md
STATE_FILE="$VAULT_PATH/Novel State.md"
if [ -f "$STATE_FILE" ]; then
  title=$(sed -n '/^---$/,/^---$/{ /^title:/{ s/^title: *"*//; s/"*$//; p; } }' "$STATE_FILE")
  phase=$(sed -n '/^---$/,/^---$/{ /^phase:/{ s/^phase: *//; p; } }' "$STATE_FILE")
  target_words=$(sed -n '/^---$/,/^---$/{ /^target-words:/{ s/^target-words: *//; p; } }' "$STATE_FILE")
  target_chapters=$(sed -n '/^---$/,/^---$/{ /^target-chapters:/{ s/^target-chapters: *//; p; } }' "$STATE_FILE")
  genre=$(sed -n '/^---$/,/^---$/{ /^genre:/{ s/^genre: *//; p; } }' "$STATE_FILE")

  echo "Title: ${title:-Untitled}"
  echo "Genre: ${genre:-Not set}"
  echo "Phase: ${phase:-Not set}"
  echo "Target: ${target_words:-?} words / ${target_chapters:-?} chapters"
  echo ""
fi

# List chapters and their statuses
echo "--- Chapters ---"
total_words=0
chapter_count=0
if [ -d "$VAULT_PATH/Manuscript" ]; then
  find "$VAULT_PATH/Manuscript" -name "*.md" -type f | sort | while read -r ch; do
    basename_ch=$(basename "$ch" .md)
    status=$(sed -n '/^---$/,/^---$/{ /^status:/{ s/^status: *//; p; } }' "$ch")
    wc_val=$(sed -n '/^---$/,/^---$/{ /^wordcount:/{ s/^wordcount: *//; p; } }' "$ch")
    echo "  $basename_ch — status: ${status:-unknown}, words: ${wc_val:-0}"
  done
fi
echo ""

# List characters
echo "--- Characters ---"
if [ -d "$VAULT_PATH/Characters" ]; then
  find "$VAULT_PATH/Characters" -name "*.md" -type f | sort | while read -r char; do
    basename_char=$(basename "$char" .md)
    role=$(sed -n '/^---$/,/^---$/{ /^role:/{ s/^role: *//; p; } }' "$char")
    echo "  $basename_char (${role:-unknown role})"
  done
fi
echo ""

# Show pre-writing foundation status
echo "--- Pre-Writing Foundation ---"
if [ -f "$VAULT_PATH/Plot/Concept.md" ]; then
  echo "  Ideation: completed"
else
  echo "  Ideation: not started (run /novel-ideate)"
fi

research_count=0
if [ -d "$VAULT_PATH/Research" ]; then
  research_count=$(find "$VAULT_PATH/Research" -name "*.md" -type f 2>/dev/null | wc -l)
fi
echo "  Research briefs: $research_count"

if [ -f "$VAULT_PATH/Critique/Pre-Writing/readiness-report.md" ]; then
  readiness=$(grep -m1 "^## Readiness Status" -A1 "$VAULT_PATH/Critique/Pre-Writing/readiness-report.md" 2>/dev/null | tail -1 | tr -d '[:space:]')
  echo "  Validation: ${readiness:-unknown}"
else
  echo "  Validation: not run (run /novel-validate)"
fi
echo ""

# Show critique pipeline progress
echo "--- Critique Pipeline ---"
if [ -d "$VAULT_PATH/Critique" ]; then
  for critique_dir in "$VAULT_PATH/Critique"/Chapter-*/; do
    if [ -d "$critique_dir" ]; then
      chapter_name=$(basename "$critique_dir")
      ledger="$critique_dir/approval-ledger.json"
      if [ -f "$ledger" ]; then
        stages_done=$(grep -o '"stages_completed": *[0-9]*' "$ledger" | grep -o '[0-9]*' || echo "0")
        echo "  $chapter_name — stages completed: $stages_done/5"
      else
        echo "  $chapter_name — not started"
      fi
    fi
  done
else
  echo "  No critiques yet."
fi

echo ""
echo "Vault: $VAULT_PATH"
echo "=== End Context ==="
