#!/bin/bash

set -euxo pipefail

# 最新のgitをいれるためのrepository登録
sudo add-apt-repository -y ppa:git-core/ppa;
sudo apt update;
sudo apt upgrade -y;
sudo apt install -y zsh;

# Install Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# ubun2u22.04(2022.07時)ではiptablesをlegacyモードにしないとdocker daemonがstartしないのでlegacy modeにする
echo 1 | sudo update-alternatives --config iptables

sudo service docker start

sudo mkdir -p /sys/fs/cgroup/systemd
sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd

# Dockerを sudo なしで実行可能に
# ※ カレントユーザーをdockerグループに所属させた上で docker.sock へのグループ書き込み権限を付与すればよい
sudo gpasswd -a $USER docker
sudo chgrp docker /var/run/docker.sock
sudo service docker restart

# Ubuntu起動時にdockerサービスを起動する
cat << EOS | sudo tee /etc/wsl.conf
[boot]
command="service docker start"
EOS

# 自分のdotfilesをcloneしてdefault shellをzshに
git clone https://github.com/okojomoeko/dotfiles.git ~/work/dotfiles
ln -s ~/work/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/work/dotfiles/zsh/.zsh_aliases ~/.zsh_aliases
sudo chsh -s $(which zsh)
sudo chsh -s $(which zsh) $USER

# # node install
# curl -SL https://deb.nodesource.com/setup_18.x | sudo bash;
# sudo apt-get install nodejs;
# sudo npm install -g -y n npm-check-updates

sudo apt install -y nodejs npm
sudo npm update -g npm
sudo npm install -g -y n
sudo n stable
sudo apt purge -y nodejs
sudo npm install -g -y npm-check-updates

# # install rust
# sudo apt-get install -y gcc
# curl https://sh.rustup.rs -sSf | sudo bash -s -- -y

# # install python
sudo apt install -y python3-pip
curl -sSL https://install.python-poetry.org | python3 -
