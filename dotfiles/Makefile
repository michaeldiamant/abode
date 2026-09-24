.PHONY: agents

AGENTS_SKILL_FILES := $(wildcard $(HOME)/.agents/skills/*)
AGENTS_SYMLINK_DRYRUN ?= true

stow:
	stow --target=$$HOME asdf 
	stow --target=$$HOME brew
	stow --target=$$HOME claude
	stow --target=$$HOME copilot
	stow --target=$$HOME git
	stow --target=$$HOME hammerspoon
	stow --target=$$HOME ideavim
	stow --target=$$HOME scmbreeze
	stow --target=$$HOME tmux
	stow --target=$$HOME zsh
	stow --target=$$HOME agents
	stow --target=$$HOME/.config/ aerospace
	stow --target=$$HOME/.config/ nvim
	stow --target=$$HOME/.config/ posting
	stow --target=$$HOME/.config/ ghostty
	stow --target=$$HOME/.config/ starship
	stow --target=$$HOME/Library/Application\ Support\/JetBrains/IntelliJIdea2026.2/ intellij

agents:
	. ./makefile_utils.sh; agents_symlink "$(AGENTS_SYMLINK_DRYRUN)"
