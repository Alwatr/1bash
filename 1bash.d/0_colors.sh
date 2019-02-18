#!/bin/bash

if type dircolors > /dev/null 2>&1; then
  if [ -f ~/.dircolors ]; then
    eval "$( dircolors -b ~/.dircolors )"
  elif [ -f $ONE_BASH/dircolors ]; then
    eval "$( dircolors -b $ONE_BASH/dircolors )"
  fi
fi

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

# enable color support of ls and also add handy aliases
alias ls='ls $colorflag'
alias dir='dir $colorflag'
alias vdir='vdir $colorflag'
alias grep='grep $colorflag'
alias fgrep='fgrep $colorflag'
alias egrep='egrep $colorflag'
