#!/usr/bin/env bash

agents_symlink() {
  local dryrun="$1"
  for dotfile in agents/.agents/skills/*; do
    skill_name=$(basename "$dotfile")
    src_file="${HOME}/.agents/skills/${skill_name}"
    if [ ! -d "$src_file" ]; then
      echo "Expected to find skill, but it's missing. Does stow need to be run? Expected file: ${src_file}"
      continue;
    fi

    dest_file="${HOME}/.claude/skills/${skill_name}"
    if [[ "$dryrun" == "true" ]]; then
      echo "Would have created symlink from ${src_file} to ${dest_file}"
    else
      ln -sfn "$src_file" "$dest_file"
    fi
  done
}
