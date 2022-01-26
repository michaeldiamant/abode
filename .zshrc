if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

alias tedit="open -e"
alias ls="ls -Gp"
alias ll="ls -alhGp"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

[ -s "/Users/michael/.scm_breeze/scm_breeze.sh" ] && source "/Users/michael/.scm_breeze/scm_breeze.sh"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv init -)"
