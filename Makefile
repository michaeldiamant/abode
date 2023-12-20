fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

brew-first:
	brew install \
		git \
		stow
	make -C dotfiles/ 
	brew bundle --file=~/.Brewfile

helm:
	asdf plugin add helm
	asdf install helm 3.12.3
	helm plugin install https://github.com/databus23/helm-diff
java:
	asdf plugin add java
	asdf install java openjdk-21
	asdf install java openjdk-20 
	asdf install java openjdk-19 
	asdf install java openjdk-18 
	asdf install java openjdk-17 
	asdf install java corretto-8.382.05.1
	asdf global java openjdk-21

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

terraform:
	asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.github
	asdf install terraform latest
	asdf global terraform latest

terragrunt:
	asdf plugin-add terragrunt https://github.com/ohmer/asdf-terragrunt
	asdf install terragrunt latest
	asdf global terragrunt latest

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

second: fzf \
 scmbreeze \
 java \
 neovim \
 nodejs \
 python \
 rust \
 helm \
 terraform \
 terragrunt \
 git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
 npm install -g json-diff

second-macos:
	defaults write -g ApplePressAndHoldEnabled -bool false # Enable key repeating on hold.

