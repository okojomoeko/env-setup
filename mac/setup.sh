#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
  echo "Install XCode"
  xcode-select --install

  echo "Install Rosetta2"
  sudo softwareupdate --install-rosetta --agree-to-licensesudo softwareupdate --install-rosetta --agree-to-license
  BREW_PATH="/opt/homebrew"

  echo "Install Homebrew"
  which $BREW_PATH/bin/brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

elif [ "$(uname)" == 'Linux' ]; then
  sudo apt-get install build-essential procps curl file git
  BREW_PATH="/home/linuxbrew/.linuxbrew"
  echo "Install Homebrew"
  which $BREW_PATH/bin/brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bash_profile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  git config --global core.autoCRLF false
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
echo "Install Homebrew"
which $BREW_PATH/bin/brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "brew update and upgrade"
which $BREW_PATH/bin/brew >/dev/null 2>&1 && brew update && brew upgrade

echo "brew install"
which $BREW_PATH/bin/brew >/dev/null 2>&1 && brew bundle --file ./Brewfile

echo "brew cleanup"
which brew >/dev/null 2>&1 && brew cleanup

sudo echo "$BREW_PATH/bin/zsh"  >> /etc/shells
chsh -s $BREW_PATH/bin/zsh
chsh -s $BREW_PATH/bin/zsh $USER

#------------------------------------------
# Develop Environment
#------------------------------------------
./setup_devenv.sh


#------------------------------------------
# dotfiles
#------------------------------------------
./setup_dotfiles.sh


exec $SHELL -l
