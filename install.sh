#!/usr/bin/env bash

SOURCE_PATH="$HOME/.dotfiles"

for f in $(ls $SOURCE_PATH -I install.sh -I scripts)
do
    ln -sf $SOURCE_PATH/$f $HOME/.$f
done

ln -sf $SOURCE_PATH/vim/gvimrc $HOME/.gvimrc
ln -sf $SOURCE_PATH/vim/vimrc $HOME/.vimrc

# emacs with prelude
# curl -L http://git.io/epre | sh
ln -sf $SOURCE_PATH/emacs/custom.el $HOME/.emacs.d/personal/custom.el
cp emacs/prelude-modules.el $HOME/.emacs.d
