#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/focus-common.sh"

target=$(get_current_target)
slot=$(find_first_empty)

if [[ -z "$slot" ]]; then
  display_msg "all 10 focus slots are full"
  exit 0
fi

write_slot "$slot" "$target"
display_msg "focused $(get_session "$target"):$(get_window_index "$target") (slot $slot)"
