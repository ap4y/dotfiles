#!/usr/bin/env bash

SOURCE_PATH="$HOME/.dotfiles"

for f in $(find . -type file -maxdepth 1 ! -name 'install.sh' ! -name '[.]*' -exec basename {} \;)
do
    ln -sf $SOURCE_PATH/$f $HOME/.$f
done

ln -sf $SOURCE_PATH/vim/ $HOME/.vim
ln -sf $SOURCE_PATH/emacs.d/ $HOME/.emacs.d

ln -sf $SOURCE_PATH/vim/gvimrc $HOME/.gvimrc
ln -sf $SOURCE_PATH/vim/vimrc $HOME/.vimrc
