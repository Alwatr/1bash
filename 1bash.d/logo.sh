#!/bin/bash

# Make your own logo and put it in ~/.1bash_logo
# http://patorjk.com/software/taag

if [ -f ~/.1bash_logo ]; then
  cat ~/.1bash_logo
elif [ -f $ONE_BASH/logo.txt ]; then
  cat $ONE_BASH/logo.txt
fi
