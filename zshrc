# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# tmux clipboard fix
if [[ "$(uname)" = "Darwin" ]]; then
  alias vim='reattach-to-user-namespace mvim -v'
  alias tmux='tmux -2 -f ~/.tmux-osx.conf'
else
  alias tmux='tmux -2'
fi
alias t1='tmux a -t 1'
alias t2='tmux a -t 2'

# 10ms for key sequences
KEYTIMEOUT=1

# locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# mac os ruby 2 path
export PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin

# homebrew path
export PATH=/usr/local/bin:$PATH

# emacs
alias e='emacsclient -t'
alias ec='emacsclient -c'

# golang
export GOPATH=$HOME/golang
export PATH=$GOPATH/bin:$PATH
