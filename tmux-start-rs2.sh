#!/bin/bash
tmux new-session -d -s rs2 -x "$(tput cols)" -y "$(tput lines)"

tmux split-window -h -p 33

tmux select-pane -t 0
tmux send-keys "cd ~/src/rSW/robot/rs2 && nvim ." C-m

tmux select-pane -t 1
tmux split-window -v -p 90

tmux select-pane -t 1
tmux send-keys "cd ~/src/rSW/robot/rs2/webui/frontend && VITE_BACKEND_URL=http://localhost:4000 npm run dev" C-m

tmux select-pane -t 2
tmux send-keys "cd ~/src/rSW" C-m

tmux attach -t rs2
