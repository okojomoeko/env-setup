#!/bin/bash

set -euxo pipefail
REPO_DIR=$(cd $(dirname $0);cd ../; pwd)
source ./setup_utils.sh
echo "################################"
echo "##### Develop Environment Setup"
echo "################################"

if [ "$(uname)" == 'Darwin' ]; then

  $REPO_DIR/mac/setup_devenv_mac.sh

elif [ "$(uname)" == 'Linux' ]; then
  $REPO_DIR/linux/setup_devenv_linux.sh

  # WSL 用の調整
  if [[ "$(uname -r)" == *microsoft* ]]; then
    echo "WSL"
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
    #------------------------------------------
    # Git credential helper
    #------------------------------------------
    git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"

  fi

else
  echo 'Windows'
fi

sudo npm install -g -y npm-check-updates
#------------------------------------------
# Program language
#------------------------------------------
echo "Install Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "################################"
echo "##### Done Develop Environment Setup"
echo "################################"
