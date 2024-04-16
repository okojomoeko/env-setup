#!/bin/bash
set -eu
echo "################################"
echo "##### Mac Setup"
echo "################################"

# ################################
# # Load Utils for setup #
REPO_DIR=$(cd $(dirname $0);cd ../; pwd)
source $REPO_DIR/setup_utils.sh
# ################################

# ################################
# # base tools #
echo "Install XCode"
which xcodebuild >/dev/null 2>&1 || \
  xcode-select --install
echo "Done Install XCode"

echo "Install Rosetta2"
(/usr/sbin/sysctl hw.optional.arm64 | grep "hw.optional.arm64: 1" >/dev/null 2>&1 ) || \
  sudo softwareupdate --install-rosetta --agree-to-licensesudo softwareupdate --install-rosetta --agree-to-license
echo "Done Install Rosetta2"

echo "Install Homebrew"
BREW_PATH="/opt/homebrew"
which $BREW_PATH/bin/brew >/dev/null 2>&1 || (/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null && write_string 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile)
echo "Done Install Homebrew"
################################

echo "################################"
