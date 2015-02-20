if [ -r ~/.profile ]; then
  source ~/.profile
fi

export CLICOLOR=1
export HISTCONTROL=ignoredups
export EDITOR=~/.bin/edit

PATH=~/.bin:"$PATH"
PATH=bin:"$PATH"
export PATH

bash_completion="$(brew --prefix 2>/dev/null)/etc/bash_completion"
if [ -r "$bash_completion" ]; then
  source "$bash_completion"
fi
unset bash_completion

# Set terminal title
title() {
  echo -n -e "\033]0;${@}\007"
}

_git_prompt() {
  local ref="$(command git symbolic-ref -q HEAD 2>/dev/null)"
  if [ -n "$ref" ]; then
    echo " (${ref#refs/heads/})"
  fi
}

PS1='\[$(tput setaf 0)\]\W$(_git_prompt)\[$(tput sgr0)\]\[$(tput setaf 1)\] » \[$(tput sgr0)\]'

# mac os ruby 2 path
export PATH=$HOME/.gem/ruby/2.2.0/bin:$PATH

# homebrew path
export PATH=/usr/local/bin:$PATH

# emacs
alias e='emacsclient -t'
alias ec='emacsclient -c'

# golang
export GOPATH=$HOME/golang
export PATH=$GOPATH/bin:$PATH

# dircolors
eval $(dircolors -b $HOME/.config/dircolors)

# aliases
alias ls='ls -h --color=auto'
alias rm='rm -iv'
