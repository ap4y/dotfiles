export CLICOLOR=1
export HISTCONTROL=ignoredups
export HISTFILE=~/.mksh_history
# export VISUAL='emacsclient -a "" -c'
# export EDITOR="$VISUAL"
export EDITOR="emacs"
export XDG_RUNTIME_DIR=/tmp/$(id -u)

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
alias gpg='gpg2'
alias e="emacsclient -t --socket-name=/tmp/emacs1000/server"

# fzf settings
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

# QT5 settings
export QT_STYLE_OVERRIDE=breeze

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
	gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
