#!/bin/bash

# Make your own logo and put it in ~/.1bash_logo
# http://patorjk.com/software/taag

if [ -f ~/.1bash_logo ]; then
  cat ~/.1bash_logo
elif [ -f "$oneBash/logo.txt" ]; then
  cat "$oneBash/logo.txt"
fi
