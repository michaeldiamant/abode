#!/usr/bin/env bash 

# For nvim plugins, Supplements lazy.nvim diff capabilities by diffing the 
# local README against the remote README.
# It's assumed meaningful changes will be captured in the README.

plugin_dir="$HOME/.local/share/nvim/lazy"

# shellcheck disable=SC2016
find "${plugin_dir}" -maxdepth 1 -type d -printf '%f\n' | \
  fzf | \
  xargs -I{} echo "${plugin_dir}"/{} | \
  xargs -I{} sh -c 'git fetch origin && git -C {} diff $(git -C {} symbolic-ref refs/remotes/origin/HEAD --short) README.md'
