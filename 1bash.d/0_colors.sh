#!/bin/bash

if [ -f ~/.dircolors ]; then
  eval "$( dircolors -b ~/.dircolors )"
elif [ -f $ONE_BASH/dircolors ]; then
  eval "$( dircolors -b $ONE_BASH/dircolors )"
fi

if ls --color=auto > /dev/null 2>&1; then colorflag="--color=auto"; else colorflag="-G"; fi;

# enable color support of ls and also add handy aliases
alias ls='ls $colorflag'
alias dir='dir $colorflag'
alias vdir='vdir $colorflag'
alias grep='grep $colorflag'
alias fgrep='fgrep $colorflag'
alias egrep='egrep $colorflag'
