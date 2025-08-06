#!/bin/bash

# set -x
# https://willhbr.net/2023/02/07/dismissable-popup-shell-in-tmux/

parent_session="$(tmux display -p '#S')"
session="_popup_$(tmux display -p '#S')"

# if [[ $parent_session == _popup_* ]]; then
#   echo "Starts with popup"
#   sleep 2
#   tmux detach -a
#   sleep 2
#   exit 0
# fi
# echo "here we are"

if ! tmux has -t "$session" 2> /dev/null; then
  echo 'starting new'
  parent_session="$(tmux display -p '#{session_id}')"
  session_id="$(tmux new-session -dP -s "$session" -F '#{session_id}' -e TMUX_PARENT_SESSION="$parent_session")"
  bind -n C-s detach
  #tmux set-option -s -t "$session_id" key-table popup
  # tmux set-option -s -t "$session_id" status off
  # tmux set-option -s -t "$session_id" prefix None
  # tmux set-option -s -t "$session_id" mouse on

  session="$session_id"
fi

# tmux send-keys -t "$session":0.0 "export TMUX_PANE_PATH=/tmp" Enter
# sleep 2
exec tmux attach -t "$session" > /dev/null

# if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ];then
#     tmux detach-client
# else
#     tmux popup -w80% -h90% "tmux attach -t popup || tmux new -s popup"
# fi
