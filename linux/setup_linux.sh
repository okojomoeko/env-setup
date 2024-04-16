#!/bin/bash
set -eu
echo "################################"
echo "##### Linux Setup"
echo "################################"

# ################################
# # Load Utils for setup #
REPO_DIR=$(cd $(dirname $0);cd ../; pwd)
source $REPO_DIR/setup_utils.sh
# ################################

# ################################
# # base tools #
sudo apt-get update
sudo apt-get install build-essential procps curl file git -y

echo "Install Homebrew"
BREW_PATH="/home/linuxbrew/.linuxbrew"
which $BREW_PATH/bin/brew >/dev/null 2>&1 || (/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null &&  \
  write_string 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' ~/.zprofile \
  write_string 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' ~/.bash_profile
  )

################################

echo "################################"
