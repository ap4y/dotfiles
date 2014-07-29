# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# 10ms for key sequences
KEYTIMEOUT=1

# locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# mac os ruby 2 path
export PATH=$HOME/.gem/ruby/2.1.0/bin:$PATH

# homebrew path
export PATH=/usr/local/bin:$PATH

# emacs
alias e='emacsclient -t'
alias ec='emacsclient -c'

# golang
export GOPATH=$HOME/golang
export PATH=$GOPATH/bin:$PATH
