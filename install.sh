#!/usr/bin/env bash

SOURCE_PATH="$HOME/.dotfiles"

for f in $(find . -maxdepth 1 -type f ! -name 'install.sh' ! -name '[.]*' -exec basename {} \;)
do
    ln -sf $SOURCE_PATH/$f $HOME/.$f
done

ln -sf $SOURCE_PATH/vim/ $HOME/.vim
ln -sf $SOURCE_PATH/emacs.d/ $HOME/.emacs.d

ln -sf $SOURCE_PATH/vim/gvimrc $HOME/.gvimrc
ln -sf $SOURCE_PATH/vim/vimrc $HOME/.vimrc

ln -sf $SOURCE_PATH/bin/ $HOME/bin
ln -sf $SOURCE_PATH/colors/ $HOME/.colors
