#!/bin/bash
set -eu
REPO_DIR=$(cd $(dirname $0); pwd)
source ./setup_utils.sh
if [ "$(uname)" == 'Darwin' ]; then

  $REPO_DIR/mac/setup_mac.sh

elif [ "$(uname)" == 'Linux' ]; then
  $REPO_DIR/linux/setup_linux.sh

  # WSL 用の調整
  if [[ "$(uname -r)" == *microsoft* ]]; then
    echo "WSL"
  fi

else
  echo 'Windows'
fi


#------------------------------------------
# Homebrew
#------------------------------------------
# $REPO_DIR/common/setup_brew.sh

ZSH_PATH=$(which zsh)
echo $ZSH_PATH | sudo tee -a /etc/shells
sudo chsh -s $ZSH_PATH
sudo chsh -s $ZSH_PATH $USER


#------------------------------------------
# Develop Environment
#------------------------------------------
$REPO_DIR/common/setup_devenv.sh


#------------------------------------------
# dotfiles
#------------------------------------------
$REPO_DIR/common/setup_dotfiles.sh
