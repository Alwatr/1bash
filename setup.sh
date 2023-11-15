#!/bin/bash

set -Eeuo pipefail

clear

repoUrl='https://github.com/njfamirm/1bash'
oneBash="$HOME/.1bash"
backupDir="$oneBash/backup"

function echoStep() {
  echo -e "\n\033[1;32m$1\033[0m"
}

function createSymlink() {
  local sourceFile=$1
  local destinationFile=$2

  echo "Creating symbolic link from $sourceFile to $destinationFile"

  if [ -e "$destinationFile" ] && [ ! -L "$destinationFile" ]; then
    echo "File $destinationFile already exists, creating a backup..."
    mv $destinationFile $backupDir/
  fi

  if [ ! -e "$destinationFile" ]; then
    ln -s $sourceFile $destinationFile
  fi
}

# ---

echo -ne "\033[1;33m💎 Setting up 1bash\033[0m\n"

# Clone or update 1bash

if [ -d "$oneBash" ]; then
  echo '✌🏻 1bash already exists, updating...'
  cd $oneBash
  git pull --prune --progress --autostash --rebase
else
  echo '✌🏻 1bash does not exist, cloning...'
  git clone $repoUrl $oneBash
fi

# Create symbolic links

echoStep '🔗 Creating symbolic links...'
mkdir -p $backupDir
createSymlink $oneBash/inputrc ~/.inputrc
createSymlink $oneBash/bash_profile ~/.bash_profile
createSymlink $oneBash/gitconfig ~/.gitconfig

echoStep '🎉 Done'