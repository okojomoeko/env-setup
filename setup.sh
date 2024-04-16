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

echo "################################"
echo "##### Common Setup"
echo "################################"


#------------------------------------------
# Homebrew
#------------------------------------------
$REPO_DIR/common/setup_brew.sh

# echo "$BREW_PATH/bin/zsh" | sudo tee -a /etc/shells
# sudo chsh -s $BREW_PATH/bin/zsh
# sudo chsh -s $BREW_PATH/bin/zsh $USER

# #------------------------------------------
# # Develop Environment
# #------------------------------------------
# ./setup_devenv.sh


# #------------------------------------------
# # dotfiles
# #------------------------------------------
# ./setup_dotfiles.sh

# #------------------------------------------
# # post setup for each os
# #------------------------------------------
# if [ "$(uname)" == 'Darwin' ]; then
#   echo "Mac"
# elif [ "$(uname)" == 'Linux' ]; then

#   # WSL 用の調整
#   if [[ "$(uname -r)" == *microsoft* ]]; then
#     echo "WSL"
#     #------------------------------------------
#     # Install Node.js
#     #------------------------------------------
#     # make cache folder (if missing) and take ownership
#     sudo mkdir -p /usr/local/n
#     sudo chown -R $USER /usr/local/n
#     # make sure the required folders exist (safe to execute even if they already exist)
#     sudo mkdir -p /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
#     # take ownership of Node.js install destination folders
#     sudo chown -R $USER /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
#     n lts
#     #------------------------------------------
#     # Git credential helper
#     #------------------------------------------
#     git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
#   fi

# else
#   echo 'Windows'
# fi

# exec $SHELL -l
