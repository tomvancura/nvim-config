#!/bin/bash
# Creates a 2x2 grid of claude sessions in rSW worktrees.
# Thin wrapper around tmux-worktree-grid.sh.
#
# Usage:
#   Standalone (renames current window and sets up grid):
#     bash ~/.config/nvim/tmux-claude-grid.sh
#
#   Sourced (creates a new window named "claude" with the grid):
#     TMUX_GRID_NEW_WINDOW=1 source ~/.config/nvim/tmux-claude-grid.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_GRID_NEW_WINDOW="${TMUX_GRID_NEW_WINDOW:-0}" source "$SCRIPT_DIR/tmux-worktree-grid.sh" claude claude
