#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/focus-common.sh"

ensure_list_file

parts=""
for slot in $(seq 1 "$FOCUS_SLOTS"); do
  if ! slot_is_empty "$slot"; then
    target=$(read_slot "$slot")
    sess=$(get_session "$target")
    win=$(get_window_index "$target")
    parts+=" [$slot]${sess}:${win}"
  fi
done

if [[ -z "$parts" ]]; then
  display_msg "focus list is empty"
else
  display_msg "focus:${parts}"
fi
