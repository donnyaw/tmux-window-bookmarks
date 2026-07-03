FOCUS_DIR="${HOME}/.config/tmux-window-focus"
FOCUS_FILE="${FOCUS_DIR}/list"
FOCUS_SLOTS=10

ensure_list_file() {
  mkdir -p "$FOCUS_DIR"
  if [[ ! -f "$FOCUS_FILE" ]]; then
    for _ in $(seq 1 "$FOCUS_SLOTS"); do echo ""; done > "$FOCUS_FILE"
  fi
}

read_slot() {
  local slot="$1"
  ensure_list_file
  sed -n "${slot}p" "$FOCUS_FILE"
}

write_slot() {
  local slot="$1"
  local value="$2"
  ensure_list_file
  local tmp
  tmp=$(mktemp)
  awk -v n="$slot" -v v="$value" 'NR == n { print v } NR != n { print }' "$FOCUS_FILE" > "$tmp"
  mv "$tmp" "$FOCUS_FILE"
}

clear_slot() {
  write_slot "$1" ""
}

find_first_empty() {
  ensure_list_file
  awk 'NF == 0 { print NR; exit }' "$FOCUS_FILE"
}

get_current_target() {
  tmux display-message -p "#{window_id}\t#{session_name}\t#{window_index}"
}

count_occupied() {
  ensure_list_file
  awk 'NF > 0 { c++ } END { print c+0 }' "$FOCUS_FILE"
}

slot_is_empty() {
  local slot="$1"
  local val
  val=$(read_slot "$slot")
  [[ -z "$val" ]]
}

display_msg() {
  tmux display-message "$*"
}

get_window_id() {
  echo "$1" | cut -f1
}

get_session() {
  echo "$1" | cut -f2
}

get_window_index() {
  echo "$1" | cut -f3
}

switch_to_window() {
  local target="$1"
  local wid
  wid=$(get_window_id "$target")
  tmux switch-client -t "$(get_session "$target")"
  tmux select-window -t "$wid"
}
