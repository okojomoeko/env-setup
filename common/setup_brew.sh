#!/bin/bash
set -eu
echo "################################"
echo "##### Brew Setup"
echo "################################"
CUR_FILE_DIR=$(cd $(dirname $0); pwd)

echo "brew update and upgrade"
which brew >/dev/null 2>&1 && brew update && brew upgrade

echo "brew install"
which brew >/dev/null 2>&1 && brew bundle --file $CUR_FILE_DIR/Brewfile

echo "brew cleanup"
which brew >/dev/null 2>&1 && brew cleanup

echo "################################"
echo "##### Done Brew Setup"
echo "################################"
