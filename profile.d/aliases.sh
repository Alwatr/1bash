export EDITOR="vi"

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# mv, rm, cp
alias mv="mv -v"
alias rm="rm -i -v"
alias cp="cp -v"

alias where=which # sometimes i forget

alias hosts="sudo $EDITOR /etc/hosts"   # yes I occasionally 127.0.0.1 twitter.com ;)

#alias ag="ag -f --hidden"

###
# time to upgrade `ls`

# use coreutils `ls` if possible…
#hash gls >/dev/null 2>&1 || alias gls="ls"

# always use color, even when piping (to awk,grep,etc)
if ls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
alias ls="ls -lAhF ${colorflag} --group-directories-first"
alias lsd="ls | grep '^d'" # only directories
# `la` defined in .functions
###


# `cat` with beautiful colors. requires: sudo easy_install -U Pygments
#alias c="pygmentize -O style=monokai -f console256 -g"

###
# GIT STUFF

function clone() {
    git clone --depth=1 $1
    cd $(basename ${1%.*})
    bower install &
    npm install
}
alias push="git push"

# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"

# git root
alias gr="[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`"
alias master="git checkout master"
alias develop="git checkout develop"

# Networking. IP address, dig, DNS
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# alias dig="dig +nocmd any +multiline +noall +answer"
# wget sucks with certificates. Let's keep it simple.
alias wget="curl -O"

# Recursively delete `.DS_Store` files
alias clean_ds_store="find . -name '*.DS_Store' -type f -ls -delete"

alias diskspace="df -P -kHl"
alias freedisk="diskspace"

# Shortcuts
alias g="git"
alias v="vim"
alias ungz="gunzip -k"

# File size
#alias fs="stat -f \"%z bytes\""
