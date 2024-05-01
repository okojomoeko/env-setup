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
    $REPO_DIR/linux/setup_devenv_wsl.sh

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
