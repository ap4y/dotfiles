export XDG_RUNTIME_DIR=/tmp/$(id -u)
mkdir -p "$XDG_RUNTIME_DIR"

gpg-agent --daemon --enable-ssh-support > /dev/null 2>&1
pass ap4y.me/ap4y > /dev/null
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

export ENV=$HOME/.kshrc
