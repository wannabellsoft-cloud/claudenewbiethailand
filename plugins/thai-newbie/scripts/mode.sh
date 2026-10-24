#!/bin/bash
# Read or set the explanation mode: newbie (default) or dev.
#   bash mode.sh          -> prints the current mode
#   bash mode.sh dev      -> switch to Dev Mode
#   bash mode.sh newbie   -> switch back to newbie mode
# Stored per user (not per project), so the choice follows you across projects.
FILE="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/thai-newbie-mode"
case "$1" in
  dev|newbie)
    mkdir -p "$(dirname "$FILE")" && printf '%s\n' "$1" > "$FILE"
    echo "$1"
    ;;
  "")
    m=$(cat "$FILE" 2>/dev/null)
    [ "$m" = "dev" ] && echo dev || echo newbie
    ;;
  *)
    echo "usage: mode.sh [dev|newbie]" >&2
    exit 1
    ;;
esac
