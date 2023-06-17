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
  sudo apt-get install build-essential procps curl file git -y
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

echo "$BREW_PATH/bin/zsh" | sudo tee -a /etc/shells
sudo chsh -s $BREW_PATH/bin/zsh
sudo chsh -s $BREW_PATH/bin/zsh $USER

#------------------------------------------
# Develop Environment
#------------------------------------------
./setup_devenv.sh


#------------------------------------------
# dotfiles
#------------------------------------------
./setup_dotfiles.sh

#------------------------------------------
# post setup for each os
#------------------------------------------
if [ "$(uname)" == 'Darwin' ]; then
  echo "Mac"
elif [ "$(uname)" == 'Linux' ]; then

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
  fi

else
  echo 'Windows'
fi

exec $SHELL -l
