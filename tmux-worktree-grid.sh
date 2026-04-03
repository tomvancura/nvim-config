#!/bin/bash
# Creates a 2x2 grid of panes across rSW worktrees.
# Can be sourced or run standalone in any tmux window.
#
# Usage:
#   Standalone (renames current window and sets up grid):
#     bash ~/.config/nvim/tmux-worktree-grid.sh <window-name> [command...]
#
#   Sourced (creates a new window with the grid):
#     TMUX_GRID_NEW_WINDOW=1 source ~/.config/nvim/tmux-worktree-grid.sh <window-name> [command...]
#
# Examples:
#   tmux-worktree-grid.sh bash
#   tmux-worktree-grid.sh claude claude
#   tmux-worktree-grid.sh nvim "nvim ."
#   tmux-worktree-grid.sh dev.sh "cd robot/rs2/webui && ./dev.sh"

WORKTREES=(~/src/rSW ~/src/rSW-2 ~/src/rSW-3 ~/src/rSW-4)
GRID_WINDOW_NAME="${1:?Usage: tmux-worktree-grid.sh <window-name> [command...]}"
shift
GRID_CMD="$*"

if [ "${TMUX_GRID_NEW_WINDOW:-0}" = "1" ]; then
  tmux new-window -n "$GRID_WINDOW_NAME"
else
  tmux rename-window "$GRID_WINDOW_NAME"
fi

_grid_send() {
  local dir="$1"
  if [ -n "$GRID_CMD" ]; then
    tmux send-keys "cd $dir && $GRID_CMD" C-m
  else
    tmux send-keys "cd $dir" C-m
  fi
}

# First pane (pane 0) is already the current pane
_grid_send "${WORKTREES[0]}"

# Split right to create pane 1
tmux split-window -h
_grid_send "${WORKTREES[1]}"

# Split pane 1 vertically to create pane 2 (bottom-right)
tmux split-window -v
_grid_send "${WORKTREES[2]}"

# Go back to pane 0 and split vertically to create pane 3 (bottom-left)
tmux select-pane -t 0
tmux split-window -v
_grid_send "${WORKTREES[3]}"

# Select top-left pane
tmux select-pane -t 0

# Show git branch at the bottom of each pane
tmux set-window-option pane-border-status bottom
tmux set-window-option pane-border-format \
  '#[fg=#38c2b4] #{b:pane_current_path}  #(cd #{pane_current_path} && git branch --show-current 2>/dev/null) '

unset GRID_WINDOW_NAME GRID_CMD WORKTREES _grid_send
