#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [[ -f /etc/profile.d/logo.txt ]]
then
  cat /etc/profile.d/logo.txt
fi
