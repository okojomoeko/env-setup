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
