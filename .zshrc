if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

alias tedit="open -e"
alias ls="gls --color=auto"
alias ll="gls -alh --color=auto"
alias py-new-venv="python3 -m venv .venv"
alias py-activate="source .venv/bin/activate"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

. /usr/local/opt/asdf/libexec/asdf.sh

GOV=$(asdf where golang)
export GOROOT=$GOV/go
export GOPATH=$(go env GOPATH)

[ -s "/Users/michael/.scm_breeze/scm_breeze.sh" ] && source "/Users/michael/.scm_breeze/scm_breeze.sh"
