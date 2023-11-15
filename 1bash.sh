#!/bin/bash

# If $BASH not defined, don't do anything
if [ -z "$BASH" ]; then
  return
fi

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

if [ -z "$ONE_BASH" ]; then
  export ONE_BASH=~/1bash
fi

if [ ! -d "$ONE_BASH/1bash.d" ]; then
  echo "$ONE_BASH/1bash.d not found"
  return
fi

for i in $ONE_BASH/1bash.d/*.sh; do
  if [ -r $i  ]; then
      if [ "$i" != "/c/Users/mohammad.kahani/1bash/1bash.d/completion.sh" ]; then
        . $i
      fi
  fi
done
unset i


# adjust to windows envirnment
if [ "$OS" = "Windows_NT" ]; then
  for i in $ONE_BASH/1bash-win.d/*.sh; do
    if [ -r $i  ]; then
      . $i
    fi
  done
  unset i
fi


