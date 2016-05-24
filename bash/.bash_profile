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
_git_prompt() {
  local ref="$(command git symbolic-ref -q HEAD 2>/dev/null)"
  if [ -n "$ref" ]; then
    echo " (${ref#refs/heads/})"
  fi
}

PS1='\[$(tput setaf 0)\]\W$(_git_prompt)\[$(tput sgr0)\]\[$(tput setaf 1)\] » \[$(tput sgr0)\]'

# ruby 2 path
export PATH=$HOME/.gem/ruby/2.3.0/bin:$PATH

# homebrew path
export PATH=/usr/local/bin:$PATH

# emacs
alias e='emacsclient -t'
alias ec='emacsclient -c'

# golang
export GOPATH=$HOME/golang
export PATH=$GOPATH/bin:$PATH

# cask
export PATH=$HOME/.cask/bin:$PATH

# dircolors
eval $(dircolors -b $HOME/.config/dircolors)

# aliases
alias ls='ls -h --color=auto'
alias rm='rm -iv'

# colored pager
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
