
asdf() {
  local dump_commands=('plugin') # Include all commands that should do a brew dump
  local main_command="${1}"

  command asdf ${@}

  for command in "${dump_commands[@]}"; do
    [[ "${command}" == "${main_command}" ]] && command asdf plugin list --urls > "${HOME}/.tool-plugins"
  done
}
