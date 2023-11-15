#!/bin/bash

export EDITOR="vim"

# Navigation aliases
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~' # `cd` is probably faster to type though
alias -- -='cd -'

# File operation aliases
alias rm='rm -i'
alias cp='cp -i'
alias where=which # sometimes i forget

# ls aliases
if lsa --group-directories-first > /dev/null 2>&1; then # GNU `ls`
  alias lsa='ls -lAhF --group-directories-first'
else # OS X `ls`
  alias lsa='ls -lAhF'
fi
alias lsd="ls | grep --color=never '^d'" # only directories

# Cleaning aliases
alias clean_ds_store="find . -name '*.DS_Store' -type f -ls -delete"

# Shortcuts
alias a='apt'
alias ai='apt install -y'
alias g='git'
alias v='vim'
alias vi='vim'
alias n='nano'
alias y='yarn'
alias l='lsa'
alias p='ping'
alias r='rsync -aPzh'
alias rd='rsync -aPzh --delete'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}'"
alias dtop="docker ps --format '{{.Names}}' | xargs docker stats $1"
alias dclog='dc logs -f --tail'

# Other aliases
alias k='kubectl'
alias ungz='gunzip -k'
alias df='df -h'
alias mkdir="mkdir -p"
alias c="printf '\33c\e[3J'"
alias ls="ls -ltrhA"
alias reload="exec bash"
alias co="code ."
alias imgo="open -a ImageOptim"
alias chrome-cors="open -n -a /Applications/Google\ Chrome\ Beta.app/Contents/MacOS/Google\ Chrome\ Beta --args --user-data-dir="$HOME/chrome-profile" --disable-web-security"