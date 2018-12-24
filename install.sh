#!/bin/bash

cp -v profile.d/* /etc/profile.d/

if [[ -f ~/.inputrc && ! -f ~/inputrc.old ]]
then
  mv -v ~/.inputrc ~/inputrc.old
fi

cp -v .inputrc ~/.inputrc


if [[ -f ~/.gitconfig && ! -f ~/gitconfig.old ]]
then
  mv -v ~/.gitconfig ~/gitconfig.old
fi
cp -v .gitconfig ~/.gitconfig

if [[ -f ~/.bashrc && ! -f ~/bashrc.old ]]
then
  mv -v ~/.bashrc ~/bashrc.old
fi

read -p "Press enter to change your gitconfig."
nano ~/.gitconfig

read -p "Press enter to change your logo"
nano /etc/profile.d/logo.txt
