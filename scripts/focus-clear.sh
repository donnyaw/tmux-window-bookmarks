#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/focus-common.sh"

ensure_list_file
for slot in $(seq 1 "$FOCUS_SLOTS"); do
  clear_slot "$slot"
done

display_msg "cleared all focus slots"
