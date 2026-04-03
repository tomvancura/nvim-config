#!/bin/bash
SESSION="rs2"

tmux has-session -t $SESSION 2>/dev/null

if [ $? == 0 ]; then
  tmux attach -t $SESSION
  exit 0
fi

tmux new-session -d -s $SESSION -x "$(tput cols)" -y "$(tput lines)"

tmux split-window -h -p 33

tmux select-pane -t 0
tmux send-keys "cd ~/src/rSW/robot/rs2 && nvim ." C-m

tmux select-pane -t 1
tmux split-window -v -p 60

tmux select-pane -t 1
tmux send-keys "cd ~/src/rSW && claude" C-m

tmux select-pane -t 2
tmux send-keys "cd ~/src/rSW" C-m

# Window 1: claude - 2x2 grid of claude sessions
TMUX_GRID_NEW_WINDOW=1 source ~/.config/nvim/tmux-worktree-grid.sh claude claude

# Window 2: bash - 2x2 grid of shells in worktree roots
TMUX_GRID_NEW_WINDOW=1 source ~/.config/nvim/tmux-worktree-grid.sh bash

# Window 3: nvim - 2x2 grid of nvim in worktree roots
TMUX_GRID_NEW_WINDOW=1 source ~/.config/nvim/tmux-worktree-grid.sh nvim "nvim ."

# Window 4: dev.sh - 2x2 grid running dev.sh from webui
TMUX_GRID_NEW_WINDOW=1 source ~/.config/nvim/tmux-worktree-grid.sh dev.sh "cd robot/rs2/webui && ./dev.sh"

# Return to the first window
tmux select-window -t 0

tmux attach -t $SESSION
