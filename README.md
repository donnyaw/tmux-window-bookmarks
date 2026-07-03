# tmux-window-focus

10-slot speed dial for tmux windows across all sessions.

Assign important windows to numbered slots (1-10), then jump to them instantly with `prefix + s 1` through `prefix + s 0`. Manage slots via an intuitive key table: add, remove, reorder, list, and clear.

## Requirements

- [tmux](https://github.com/tmux/tmux) 3.0+
- [fzf](https://github.com/junegunn/fzf) (with `fzf-tmux`)

## Installation

### Manual

Clone the repo and source the config:

```tmux
# ~/.tmux.conf
set -g @plugin 'donnyaw/tmux-window-focus'
```

Or manually:

```tmux
source-file /path/to/tmux-window-focus/tmux-window-focus.conf
```

### With TPM

```tmux
set -g @plugin 'donnyaw/tmux-window-focus'
```

Press `prefix + I` to install.

## Usage

Press `prefix + s` to enter the focus key table, then:

| Key | Action |
|---|---|
| `1`–`9`, `0` | Jump to window in slot 1–10 |
| `a` | Add current window to first free slot |
| `A` | Assign current window to a specific slot |
| `d` | Delete/clear a slot |
| `m` | Move/reorder a slot (e.g. `5:2` shifts 5 to position 2) |
| `l` | List all occupied slots via fzf with preview |
| `s` | Show all occupied slots in tmux message bar |
| `c` | Clear all slots (with confirmation) |
| `Esc` | Exit focus key table |

## How it works

- Data is stored in `~/.config/tmux-window-focus/list` — plain text, 10 lines (one per slot).
- Windows are identified by tmux `window_id` for stable targeting across renames/reorders.
- Move operations shift entries to maintain priority ordering (slot 1 = highest priority).

## License

MIT
