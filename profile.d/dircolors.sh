#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

eval $( dircolors -b /etc/profile.d/dircolors )
