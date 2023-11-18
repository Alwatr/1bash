#!/bin/bash

set -Eeuo pipefail

clear

ONE_BASH=${ONE_BASH:-"$HOME/1bash"}
ONE_BASH_REPO_URL=${ONE_BASH_REPO_URL:-"https://github.com/Alwatr/1bash"}
ONE_BASH_REF=${ONE_BASH_REF:-"main"}
BACKUP_DIR="$ONE_BASH/backup"

function echoStep() {
  echo -e "\n\033[1;32m$1\033[0m"
}

function createSymlink() {
  local sourceFile=$1
  local destinationFile=$2

  echo "Creating symbolic link from $sourceFile to $destinationFile"

  if [ -e "$destinationFile" ] && [ ! -L "$destinationFile" ]; then
    echo "File $destinationFile already exists, creating a backup..."
    mv $destinationFile $BACKUP_DIR/
  fi

  ln -svf $sourceFile $destinationFile
}

# ---

echo -ne "\033[1;33m💎 Setting up 1bash\033[0m\n"

# Clone or update 1bash

if [ -d "$ONE_BASH" ]; then
  echo '✌🏻 1bash already exists, updating...'
  cd $ONE_BASH
  git pull --prune --progress --autostash --rebase
else
  echo '✌🏻 1bash does not exist, cloning...'
  git clone -b $ONE_BASH_REF $ONE_BASH_REPO_URL $ONE_BASH
fi

# Create symbolic links

echoStep '🔗 Creating symbolic links...'
mkdir -p $BACKUP_DIR
createSymlink $ONE_BASH/inputrc.sh ~/.inputrc
createSymlink $ONE_BASH/bash_profile.sh ~/.bash_profile
createSymlink $ONE_BASH/gitconfig ~/.gitconfig

echoStep '🎉 Done'