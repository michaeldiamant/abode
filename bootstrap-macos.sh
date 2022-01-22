#!/bin/bash

set -euo pipefail

function installGoVersionManager() {
  rm -rf ~/.gvm
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
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

installScmBreeze
installGoVersionManager
installGo "1.16.13"

brew tap kidonng/malt # https://github.com/dexterleng/vimac/issues/152#issuecomment-903099562

brew install \
  alt-tab \
  kidonng/malt/vimac \
  pyenv \
  shellcheck
brew install --cask \
  goland \
  karabiner-elements \
  intellij-idea-ce \
  iterm2

defaults write -g com.apple.mouse.scaling 10 # Override max mouse sensitivity
