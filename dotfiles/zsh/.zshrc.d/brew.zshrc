
# Overrides default brew behavior to update ~/.Brewfile.
# Resources:
# * https://github.com/Homebrew/brew/issues/3933#issuecomment-373771217
# * https://stackoverflow.com/a/10169840
brew() {
  local dump_commands=('install' 'uninstall', 'remove') # Include all commands that should do a brew dump
  local main_command="${1}"

  command brew ${@}

  for command in "${dump_commands[@]}"; do
    [[ "${command}" == "${main_command}" ]] && brew bundle dump --file="${HOME}/.Brewfile" --force
  done
}

