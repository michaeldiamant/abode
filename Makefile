asdf:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf

fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

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

ohmyzsh:
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
