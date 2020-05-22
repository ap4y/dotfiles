export CLICOLOR=1
export HISTCONTROL=ignoredups
export VISUAL='emacsclient -a "" -c'
export EDITOR="$VISUAL"

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
alias gpg='gpg2'
alias e='emacsclient -t'
alias ec='emacsclient -c'

# fzf settings
export FZF_DEFAULT_COMMAND='ag -g ""'

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
