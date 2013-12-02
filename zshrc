# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(git rvm github gem brew osx sublime)
plugins=(git github gem brew osx)

# Customize to your needs...
source $ZSH/oh-my-zsh.sh

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

# vim keybindings for zsh
bindkey -v
