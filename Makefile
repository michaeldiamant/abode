fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

brew-first:
	brew install \
		asdf \
		git \
		stow
	make -C dotfiles/ 
	brew bundle --file=~/.Brewfile

asdf-plugins:
	cat ~/.tool-plugins | tr -s ' ' | cut -d' ' -f1,2 | xargs -I{} /bin/bash -c "asdf plugin add {}"

scmbreeze:
	git clone --depth 1 https://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
	sh ~/.scm_breeze/install.sh

ohmyzsh:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ohmyzsh-plugins:
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/custom/plugins/zsh-vi-mode
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

first: brew-first ohmyzsh ohmyzsh-plugins

second:	fzf \
 scmbreeze \
 asdf-plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	asdf install
	npm install -g json-diff

second-macos:
	defaults write -g ApplePressAndHoldEnabled -bool false # Enable key repeating on hold.
	defaults write -g InitialKeyRepeat -int 15
	defaults write -g KeyRepeat -int 2

