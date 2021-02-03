export XDG_RUNTIME_DIR=/tmp/$(id -u)
mkdir -p "$XDG_RUNTIME_DIR"

eval "$(gpg-agent --daemon)"

export ENV=$HOME/.kshrc
