#!/bin/bash

#export EDITOR="nano"

# Easier navigation: .., ..., ~ and -
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~' # `cd` is probably faster to type though
alias -- -='cd -'

# mv, rm, cp
# -v is very slow over ssh for huge files and slow connection
alias rm='rm -i'
# alias mv='mv -v'
# alias cp='cp -v'

alias where=which # sometimes i forget

# ls make colerfull in color.sh
# always use color, even when piping (to awk,grep,etc)
# export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
if lsa --group-directories-first > /dev/null 2>&1; then # GNU `ls`
    alias lsa='ls -lAhF --group-directories-first'
else # OS X `ls`
    alias lsa='ls -lAhF'
fi
alias lsd="ls | grep --color=never '^d'" # only directories
# `la` defined in .functions

# `cat` with beautiful colors. requires: sudo easy_install -U Pygments
#alias c="pygmentize -O style=monokai -f console256 -g"

# Networking. IP address, dig, DNS
# alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# alias dig="dig +nocmd any +multiline +noall +answer"
# wget sucks with certificates. Let's keep it simple.
# alias wget="curl -O"

# Recursively delete `.DS_Store` files
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

alias d='docker'
alias dc='docker-compose'
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}'"
alias dtop="docker ps --format '{{.Names}}' | xargs docker stats $1"
alias dclog='dc logs -f --tail'

alias k='kubectl'

alias ungz='gunzip -k'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# more https://github.com/algotech/dotaliases
