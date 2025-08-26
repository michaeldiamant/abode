#!/usr/bin/env bash

# https://github.com/edr3x/tmux-sessionizer

if [[ $# -eq 1 ]]; then
    selected=$1
else
    dirs=()
    dirs+=($(find ~/dev -mindepth 1 -maxdepth 1 -type d))
    dirs+=($(find ~/dev/tvp -mindepth 2 -maxdepth 2 -type d))
    selected=$(printf '%s\n' "${dirs[@]}" | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

base=$(basename "$selected" | tr . _)
parent=$(basename "$(dirname "$selected")" | tr '.' '_')
selected_name="${parent}_${base}"

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]]; then
    tmux attach -t $selected_name
else
    tmux switch-client -t $selected_name
fi
