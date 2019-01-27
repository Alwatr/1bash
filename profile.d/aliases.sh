#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export EDITOR="nano"

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# mv, rm, cp
# alias mv="mv -v"
# alias rm="rm -i -v"
# alias cp="cp -v"

alias where=which # sometimes i forget

###
# time to upgrade `ls`

# use coreutils `ls` if possible…
#hash gls >/dev/null 2>&1 || alias gls="ls"

# always use color, even when piping (to awk,grep,etc)
if ls --color=auto > /dev/null 2>&1; then colorflag="--color=auto"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
alias lsa="ls -lAhF ${colorflag} --group-directories-first"
alias lsd="ls | grep '^d'" # only directories
# `la` defined in .functions
###


# `cat` with beautiful colors. requires: sudo easy_install -U Pygments
#alias c="pygmentize -O style=monokai -f console256 -g"

###

# Networking. IP address, dig, DNS
# alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# alias dig="dig +nocmd any +multiline +noall +answer"
# wget sucks with certificates. Let's keep it simple.
# alias wget="curl -O"

# Recursively delete `.DS_Store` files
alias clean_ds_store="find . -name '*.DS_Store' -type f -ls -delete"

# Shortcuts
alias a="apt"
alias ai="apt install -y"
alias g="git"
alias v="vim"
alias n="nano"
alias l="lsa"
alias r="rsync -aPzh"
alias rd="rsync -aPzh --delete"

alias d="docker"
alias dc="docker-compose"
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}'"
alias dtop="docker ps --format '{{.Names}}' | xargs docker stats $1"
alias dclog="dc logs -f --tail"

alias ungz="gunzip -k"
