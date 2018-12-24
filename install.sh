#!/bin/bash
if [[ -f /etc/profile.d/logo.txt ]]
then
  mv -v /etc/profile.d/logo.txt /etc/profile.d/logo.bak
fi
cp -v profile.d/* /etc/profile.d/
if [[ -f /etc/profile.d/logo.bak ]]
then
  mv -v /etc/profile.d/logo.bak /etc/profile.d/logo.txt
fi


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

echo " "
echo " "
read -p "Press enter to change your gitconfig."
nano ~/.gitconfig

echo " "
read -p "Press enter to change your logo"
nano /etc/profile.d/logo.txt
