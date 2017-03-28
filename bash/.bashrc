export CLICOLOR=1
export HISTCONTROL=ignoredups
export EDITOR=~/.bin/edit

PATH=~/.bin:"$PATH"
PATH=bin:"$PATH"
export PATH

bash_completion="/usr/share/bash-completion/bash_completion"
if [ -r "$bash_completion" ]; then
    source "$bash_completion"
    source $HOME/.bin/totp_completion
fi
unset bash_completion
_git_prompt() {
    local ref="$(command git symbolic-ref -q HEAD 2>/dev/null)"
    if [ -n "$ref" ]; then
        echo " (${ref#refs/heads/})"
    fi
}

PS1='\[$(tput setaf 2)\]\W$(_git_prompt)\[$(tput sgr0)\]\[$(tput setaf 1)\] » \[$(tput sgr0)\]'

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
alias gpg='gpg2'

# colored pager
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="/home/ap4y/.gnupg/S.gpg-agent.ssh"
fi
