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

if [ -z "$oneBash" ]; then
  export oneBash='~/.1bash'
fi

if [ ! -d "$oneBash/1bash.d" ]; then
  echo "$oneBash/1bash.d not found"
  return
fi

for i in $oneBash/1bash.d/*.sh; do
  if [ -r $i ]; then
    . $i
  fi
done
unset i
