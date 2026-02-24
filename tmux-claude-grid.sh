#!/bin/bash
# Creates a 2x2 grid of claude sessions in rSW worktrees.
# Can be sourced from tmux-start-rs2.sh or run standalone in any tmux window.
#
# Usage:
#   Standalone (renames current window and sets up grid):
#     bash ~/.config/nvim/tmux-claude-grid.sh
#
#   Sourced (creates a new window named "claude" with the grid):
#     TMUX_CLAUDE_NEW_WINDOW=1 source ~/.config/nvim/tmux-claude-grid.sh

WORKTREES=(~/src/rSW ~/src/rSW-2 ~/src/rSW-3 ~/src/rSW-4)

if [ "${TMUX_CLAUDE_NEW_WINDOW:-0}" = "1" ]; then
  tmux new-window -n "claude"
else
  tmux rename-window "claude"
fi

# First pane (pane 0) is already the current pane
tmux send-keys "cd ${WORKTREES[0]} && claude" C-m

# Split right to create pane 1
tmux split-window -h
tmux send-keys "cd ${WORKTREES[1]} && claude" C-m

# Split pane 1 vertically to create pane 2 (bottom-right)
tmux split-window -v
tmux send-keys "cd ${WORKTREES[2]} && claude" C-m

# Go back to pane 0 and split vertically to create pane 3 (bottom-left)
tmux select-pane -t 0
tmux split-window -v
tmux send-keys "cd ${WORKTREES[3]} && claude" C-m

# Select top-left pane
tmux select-pane -t 0
