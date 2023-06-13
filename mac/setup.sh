#!/bin/bash

echo "Install XCode"
xcode-select --install

echo "Install Rosetta2"
sudo softwareupdate --install-rosetta --agree-to-licensesudo softwareupdate --install-rosetta --agree-to-license

#------------------------------------------
# Homebrew
#------------------------------------------
echo "Install Homebrew"
which /opt/homebrew/bin/brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "brew update and upgrade"
which /opt/homebrew/bin/brew >/dev/null 2>&1 && brew update && brew upgrade

echo "brew install"
which /opt/homebrew/bin/brew >/dev/null 2>&1 && brew bundle --file ./Brewfile

echo "brew cleanup"
which brew >/dev/null 2>&1 && brew cleanup

#------------------------------------------
# Develop Environment
#------------------------------------------
./setup_devenv.sh

exec $SHELL -l
