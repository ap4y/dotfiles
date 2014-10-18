#!/usr/bin/env bash

SOURCE_PATH="$HOME/.dotfiles"

for f in $(ls $SOURCE_PATH -I install.sh -I scripts -I vim)
do
    ln -sf $SOURCE_PATH/$f $HOME/.$f
done

ln -sf $SOURCE_PATH/vim/gvimrc $HOME/.gvimrc
ln -sf $SOURCE_PATH/vim/vimrc $HOME/.vimrc
