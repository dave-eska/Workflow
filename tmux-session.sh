#!/bin/bash

# Set the project name to the first argument or "Kookie" if no argument is given
PROJECT=${1:-Kookie}
PROJECT_DIR=~/Documents/c++/$PROJECT
BUILD_DIR=$PROJECT_DIR/build

# Create the project directory if it doesn't exist
mkdir -p $PROJECT_DIR
mkdir -p $BUILD_DIR

# Start tmux session
tmux new-session -d -s $PROJECT

# Create neovim window
tmux rename-window -t $PROJECT:0 'Neovim'
tmux send-keys -t $PROJECT:0 "cd $PROJECT_DIR" C-m
tmux send-keys -t $PROJECT:0 'nvim' C-m

# Create git window
tmux new-window -t $PROJECT:1 -n 'Git'
tmux send-keys -t $PROJECT:1 "cd $PROJECT_DIR" C-m

# Create debugging window
tmux new-window -t $PROJECT:2 -n 'Debugging'
tmux send-keys -t $PROJECT:2 "cd $BUILD_DIR" C-m
tmux send-keys -t $PROJECT:2 'gdb ./main1' C-m
tmux send-keys -t $PROJECT:2 'alias cls=shell clear' C-m

# Attach to the tmux session
tmux attach-session -t $PROJECT
