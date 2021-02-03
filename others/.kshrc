export CLICOLOR=1
export HISTCONTROL=ignoredups
export HISTFILE=~/.mksh_history
# export VISUAL='emacsclient -a "" -c'
# export EDITOR="$VISUAL"
export EDITOR="emacs"

PS1='$(tput setaf 1)$(pwd | rev | cut -d/ -f1 | rev)$(tput sgr0)$(tput setaf 2) » $(tput sgr0)'
[ $TERM = "dumb" ] && PS1='$ '

# user scripts
export PATH=$HOME/.bin:$PATH

# ruby path
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH

# golang
export GOPATH=$HOME/golang
export PATH=$GOPATH/bin:$PATH
export GO111MODULE=on

# pip path
export PATH=$HOME/.local/bin:$PATH

# aliases
alias ls='ls -h --color=auto'
alias rm='rm -iv'

# fzf settings
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
