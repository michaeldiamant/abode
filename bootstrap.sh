#!/bin/bash

set -euxo pipefail

removeSnap() {
  sudo apt autoremove --purge snapd
}

installBaseApps() {
  # Chrome
  sudo apt install -y gdebi
  wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/Downloads
  sudo gdebi -n ~/Downloads/google-chrome-stable_current_amd64.deb
  rm -f ~/Downloads/google-chrome-stable_current_amd64.deb

  sudo apt install -y \
    curl \
    git \
    gnome-tweak-tool \
    jq \
    python3-pip \
    python3-venv \
    wireshark
}

installVim() {
  sudo apt install -y vim
  sudo update-alternatives --set editor /usr/bin/vim.basic
  echo '
"General
set number	"Show line numbers
set linebreak	"Break lines at word (requires Wrap lines)
set showbreak=+++	"Wrap-broken line prefix
set textwidth=100	"Line wrap (number of cols)
set showmatch	"Highlight matching brace
set visualbell	"Use visual bell (no beeping)

set hlsearch	"Highlight all search results
set smartcase	"Enable smart-case search
set ignorecase	"Always case-insensitive
set incsearch	"Searches for strings incrementally

set autoindent	"Auto-indent new lines
set expandtab	"Use spaces instead of tabs
set shiftwidth=2	"Number of auto-indent spaces
set smartindent	"Enable smart-indent
set smarttab	"Enable smart-tabs
set softtabstop=2	"Number of spaces per Tab

"Advanced
set ruler	"Show row and column ruler information

set undolevels=1000	"Number of undo levels
set backspace=indent,eol,start	"Backspace behaviour


"Generated by VimConfig.com' > ~/.vimrc
}

installJdk() {
  local version="$1"
  wget -N https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01/OpenJDK8U-jdk_x64_linux_hotspot_8u"${version}".tar.gz -P ~/Downloads
  mkdir -p ~/opt/jdk8u"${version}"
  tar -xf ~/Downloads/OpenJDK8U-jdk_x64_linux_hotspot_8u"${version}".tar.gz -C ~/opt/jdk8u"${version}" --strip-components 1
  unlink ~/opt/jdk || true
  ln -s ~/opt/jdk8u"${version}" ~/opt/jdk
  rm -f ~/Downloads/OpenJDK8U-jdk_x64_linux_hotspot_8u"${version}".tar.gz
}

installSbt() {
  local version="$1"
  wget -N https://piccolo.link/sbt-"${version}".zip -P ~/Downloads
  unzip -o -d ~/Downloads ~/Downloads/sbt-"${version}".zip
  rm -rf ~/opt/sbt-"${version}"
  mv -f ~/Downloads/sbt ~/opt/sbt-"${version}"
  unlink ~/opt/sbt || true
  ln -s ~/opt/sbt-"${version}" ~/opt/sbt
  rm -f ~/Downloads/sbt-"${version}".zip
}

installKubectl() {
  local version="$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"
  mkdir -p ~/opt/kubectl-"${version}"
  wget -N "https://storage.googleapis.com/kubernetes-release/release/${version}/bin/linux/amd64/kubectl" -P ~/Downloads/kubectl-"${version}"
  rm -rf ~/opt/kubectl-"${version}"
  mv ~/Downloads/kubectl-"${version}" ~/opt/kubectl-"${version}"
  unlink ~/opt/kubectl || true
  ln -s ~/opt/kubectl-"${version}" ~/opt/kubectl
  chmod +x ~/opt/kubectl-"${version}"/kubectl
}

installHelm() {
  local version="$1"
  wget -N https://get.helm.sh/helm-v"${version}"-linux-amd64.tar.gz -P ~/Downloads
  mkdir -p ~/opt/helm-"${version}"
  tar -xf helm-v"${version}"-linux-amd64.tar.gz -C ~/opt/helm-"${version}" --strip-components 1
  unlink ~/opt/helm || true
  ln -s ~/opt/helm-"${version}" ~/opt/helm
  rm -f ~/Downloads/helm-v"${version}"-linux-amd64.tar.gz
}

installIntellij() {
  local version="2020.2.1"
  wget -N https://download.jetbrains.com/idea/ideaIC-"${version}".tar.gz -P ~/Downloads
  rm -rf ~/opt/intellij-"${version}"
  mkdir -p ~/opt/intellij-"${version}"
  tar -xf ~/Downloads/ideaIC-"${version}".tar.gz -C ~/opt/intellij-"${version}" --strip-components 1
  unlink ~/opt/intellij || true
  ln -s ~/opt/intellij-"${version}" ~/opt/intellij
  rm -f ~/Downloads/ideaIC-"${version}".tar.gz
  
  echo "  
[Desktop Entry]                                                                 
Encoding=UTF-8
Name=IntelliJ IDEA
Comment=IntelliJ IDEA
Exec=/home/michael/opt/intellij/bin/idea.sh
Icon=/home/michael/opt/intellij/bin/idea.png
Terminal=false
StartupNotify=true
Type=Application
" > /tmp/idea.desktop
  sudo mv -f /tmp/idea.desktop /usr/share/applications/idea.desktop
}

installScmBreeze() {
  git clone git://github.com/scmbreeze/scm_breeze.git /tmp/.scm_breeze
  rm -rf ~/.scm_breeze
  mv /tmp/.scm_breeze ~/.scm_breeze
  ~/.scm_breeze/install.sh
}

installAwsCli() {
  wget -N https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -P ~/Downloads
  unzip -o -d /tmp ~/Downloads/awscli-exe-linux-x86_64.zip
  sudo /tmp/aws/install
}

installTerraform() {
  local version="$1"
  wget -N https://releases.hashicorp.com/terraform/"$version"/terraform_"$version"_linux_amd64.zip -P ~/Downloads
  unzip -o -d /tmp ~/Downloads/terraform_"$version"_linux_amd64.zip
  mkdir -p ~/opt/terraform-"$version"
  mv /tmp/terraform ~/opt/terraform-"$version"/terraform
  unlink ~/opt/terraform || true
  ln -s ~/opt/terraform-"$version" ~/opt/terraform
  rm -f ~/Downloads/terraform_"$version"_linux_amd64.zip
}

configureBashExports() {
  local script_dir=$(dirname "$0")
  cp "$script_dir"/bash_exports ~/.bash_exports

  # Inspired by scm_breeze install.sh.
  local exec_string="source ~/.bash_exports"
  if grep -q "$exec_string" ~/.bashrc; then
    echo "bash_exports already added to ~/.bashrc"
  else
    printf "\n$exec_string\n" >> ~/.bashrc
    echo "bash_exports added to ~/.bashrc"
  fi
}

mkdir -p ~/opt
installBaseApps
installVim
installJdk "265b01"
installSbt "1.3.13"
installKubectl
installHelm "3.3.1"
installIntellij
installScmBreeze
installAwsCli
installTerraform "0.13.2"
configureBashExports
