
#!/bin/bash

if [ -f ~/.dircolors ]; then
  eval "$( dircolors -b ~/.dircolors )"
elif [ -f $ONE_BASH/dircolors ]; then
  eval "$( dircolors -b $ONE_BASH/dircolors )"
fi

# enable color support of ls and also add handy aliases
# alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
