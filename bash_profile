#!/bin/bash

if [ "$BASH" ]; then
  export oneBash=~/.1bash

  if [ -f $oneBash/1bash.sh ]; then
    . $oneBash/1bash.sh
  fi

  # Uncoment the following lines if you want to load ~/.bashrc too
  # if [ -f ~/.bashrc ]; then
  #   . ~/.bashrc
  # fi

  # if ! shopt -oq posix; then
  #   cd /srv
  #   lsa
  # fi
fi
