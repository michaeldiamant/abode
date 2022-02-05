if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

alias tedit="open -e"
alias ls="ls -Gp"
alias ll="ls -alhGp"
alias py-new-venv="python3 -m venv .venv"
alias py-activate="source .venv/bin/activate"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

eval "$(pyenv init -)"

source /Users/michael/.gvm/scripts/gvm

[ -s "/Users/michael/.scm_breeze/scm_breeze.sh" ] && source "/Users/michael/.scm_breeze/scm_breeze.sh"
