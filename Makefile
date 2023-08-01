fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

brew-first:
	brew install \
		git \
		stow
brew-second:
	brew install asdf \
		fd \
		jq \
		gh \
		jless \
		intellij-idea-ce \
		ripgrep \
		tmux \
		tree
	brew install --cask brave-browser \
		dbeaver-community \
		postman

java:
	asdf plugin add java
	asdf install java openjdk-20 
	asdf install java openjdk-19 
	asdf install java openjdk-18 
	asdf install java openjdk-17 
	asdf global java openjdk-20

maven:
	asdf plugin add maven
	asdf install maven latest
	asdf global maven latest

neovim:
	asdf plugin add neovim
	asdf install neovim latest 
	asdf global neovim latest

nodejs:
	asdf plugin add nodejs
	asdf install nodejs latest 
	asdf global nodejs latest

python:
	asdf plugin add python
	asdf install python latest 
	asdf global python latest

rust:
	asdf plugin add rust
	asdf install rust latest 
	asdf global rust latest

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

second: brew-second \
 fzf \
 scmbreeze \
 neovim \
 nodejs \
 python \
 rust
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

second-macos:
	brew install --cask alfred \
		alt-tab \
		hyperkey \
		keycastr
	defaults write -g ApplePressAndHoldEnabled -bool false # Enable key repeating on hold.

# Thanks to https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
first-macos:
	brew install autoconf \
		bash \
		binutils \
		coreutils \
		diffutils \
		ed \
		findutils \
		flex \
		gawk \
    		gnu-indent \
		gnu-sed \
		gnu-tar \
		gnu-which \
		gpatch \
		grep \
		gzip \
		less \
		m4 \
		make \
		nano \
		screen \
		watch \
		wdiff \
		wget \
		zip
