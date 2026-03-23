#!/usr/bin/env bash
# session-end.sh — Update session timestamp in Novel State.md on exit

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

STATE_FILE="$VAULT_PATH/Novel State.md"
if [ -z "$VAULT_PATH" ] || [ ! -f "$STATE_FILE" ]; then
  exit 0
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Update or add last-session field in frontmatter
if grep -q "^last-session:" "$STATE_FILE"; then
  sed -i "s/^last-session:.*$/last-session: $TIMESTAMP/" "$STATE_FILE"
else
  # Insert before the closing --- of frontmatter
  sed -i "0,/^---$/! { /^---$/ i\\last-session: $TIMESTAMP
  }" "$STATE_FILE"
fi
