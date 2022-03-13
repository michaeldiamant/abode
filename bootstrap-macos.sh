#!/bin/bash

set -euo pipefail

function installOhMyZsh() {
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  brew install romkatv/powerlevel10k/powerlevel10k
  # echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

  brew install zsh-syntax-highlighting
  # echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>~/.zshrc

  brew install zsh-autosuggestions
  # echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >>~/.zshrc
}

function installGo() {
  local goVersion="$1"

  # Applies a workaround for Big Sur: https://github.com/moovweb/gvm/issues/360#issuecomment-754605010.
  brew install go
  gvm install go"$goVersion"
  gvm use go"$goVersion" --default
  brew uninstall go
}

function installScmBreeze() {
  rm -rf ~/.scm_breeze
  git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
  ~/.scm_breeze/install.sh  
}

function configureYabai() {
  # Follows https://apple.stackexchange.com/a/418489.
  brew services start yabai
  yabai -m config focus_follows_mouse autofocus
}

function installAsdfPackages() {
  asdf plugin add awscli
  asdf install awscli latest
  asdf global awscli latest

  asdf plugin add golang
  asdf install golang 1.14.15
  asdf global golang 1.14.15

  asdf plugin add postgres
  asdf install postgres 13.6
  asdf global postgres 13.6

  asdf plugin add python
  asdf install python 3.10.2
  asdf install python 2.7.18
  asdf global python 3.10.2 2.7.18
}

installOhMyZsh
installScmBreeze

brew tap kidonng/malt # https://github.com/dexterleng/vimac/issues/152#issuecomment-903099562

brew install \
  asdf \
  automake \
  alt-tab \
  boost \
  core-utils \
  curl \
  gmailctl \
  gcc \
  jq \
  kidonng/malt/vimac \
  msgpack-tools \
  libtool \
  openssl \
  ossp-uuid \
  readline \
  shellcheck \
  koekeishiya/formulae/yabai
  tree \
  zlib
brew install --cask \
  brave-browser \
  docker \
  goland \
  google-chrome \
  karabiner-elements \
  intellij-idea-ce \
  iterm2 \
  itsycal \
  ledger-live \
  linearmouse \
  pgadmin4 \
  pycharm \
  visual-studio-code

installAsdfPackages

defaults write -g com.apple.mouse.scaling 10 # Override max mouse sensitivity
defaults write com.apple.finder AppleShowAllFiles YES
