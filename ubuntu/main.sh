#!/bin/sh

sudo apt-get install -y \
  stow

stow -t ~/ --verbose=3 \
  git
  zsh
