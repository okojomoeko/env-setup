#!/bin/bash

set -euxo pipefail
REPO_DIR=$(cd $(dirname $0);cd ../; pwd)
source ./setup_utils.sh
echo "################################"
echo "##### Linux Develop Environment Setup"
echo "################################"

# install docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER


#------------------------------------------
# Install Node.js
#------------------------------------------
# make cache folder (if missing) and take ownership
sudo mkdir -p /usr/local/n
sudo chown -R $USER /usr/local/n
# make sure the required folders exist (safe to execute even if they already exist)
sudo mkdir -p /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
# take ownership of Node.js install destination folders
sudo chown -R $USER /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
n lts

echo "################################"
echo "##### Done Linux Develop Environment Setup"
echo "################################"
