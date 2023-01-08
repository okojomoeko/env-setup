#!/bin/bash

set -euxo pipefail

# 最新のgitをいれるためのrepository登録
sudo add-apt-repository -y ppa:git-core/ppa;
sudo apt update;
sudo apt upgrade -y;
sudo apt install -y zsh \
                    unzip;

# 自分のdotfilesをcloneしてdefault shellをzshに
sudo chsh -s $(which zsh)
sudo chsh -s $(which zsh) $USER
exec -l $(which zsh)
rm -rf ~/.zshrc
rm -rf ~/.zsh_aliases
git clone https://github.com/okojomoeko/dotfiles.git ~/work/env/dotfiles
ln -s ~/work/env/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/work/env/dotfiles/zsh/.zsh_aliases ~/.zsh_aliases
source ~/.zshrc

# # node install
sudo apt install -y nodejs npm
sudo npm update -g npm
sudo npm install -g -y n
sudo n stable
sudo apt purge -y nodejs
sudo npm install -g -y npm-check-updates

# install rust
sudo apt-get install -y gcc
curl https://sh.rustup.rs -sSf | bash -s -- -y

# # install python
sudo apt install -y python3-pip
curl -sSL https://install.python-poetry.org | python3 -

curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip
