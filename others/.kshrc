export HISTCONTROL=ignoredups
export VISUAL=emacsclient
export EDITOR="$VISUAL"
export MPD_HOST=192.168.1.8

PS1='\033[32m\W\033[31m » \033[0m'

# custom bin path
export PATH=$HOME/.bin:$PATH

# ruby 2 path
export PATH=$HOME/.gem/ruby/2.3/bin:$PATH

# golang
export GOPATH=$HOME/golang
export PATH=$GOPATH/bin:$PATH

# cask
export PATH=$HOME/.cask/bin:$PATH

# aliases
alias ls='colorls -h -G'
alias rm='rm -iv'
alias gpg='gpg2'

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
