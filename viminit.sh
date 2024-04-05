#!/bin/bash

sudo apt install universal-ctags
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

cd ~/.vim/bundle/YouCompleteMe/
python3 install.py --clangd-completer
