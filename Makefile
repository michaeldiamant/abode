fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

brew-first:
	brew install \
		git \
		stow
brew-second:
	brew install asdf \
		tree
	brew install --cask karabiner-elements

json:
	brew install jless 

java:
	asdf plugin add java
	asdf install java openjdk-20 
	asdf install java openjdk-19 
	asdf install java openjdk-18 
	asdf install java openjdk-17 
	asdf install java openjdk-11 
	asdf global java openjdk-20

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
# fzf \
# scmbreeze \
 brew-second \
 java \
 neovim \
 nodejs \
 python \
 rust \
 json
