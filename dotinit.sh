#!/bin/bash

# Exit on any error
set -e  

# Install required packages
#sudo apt update
sudo apt install -y universal-ctags global cmake

# The distribution vim is new enough now, so there is no source build here.
# Build vim from source only if YouCompleteMe reports that vim is too old.

# Copy .vimrc and .tmux.conf if they exist in the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/.vimrc" ~/
cp "$SCRIPT_DIR/.tmux.conf" ~/

# Clean and clone Vundle
if [ -d ~/.vim/bundle/Vundle.vim ]; then
  rm -rf ~/.vim/bundle/Vundle.vim
fi
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Vim plugins using Vundle
vim +PluginInstall +qall

# Clean and install YouCompleteMe
if [ -d ~/.vim/bundle/YouCompleteMe ]; then
  cd ~/.vim/bundle/YouCompleteMe
  git submodule update --init --recursive
else
  git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
  cd ~/.vim/bundle/YouCompleteMe
  git submodule update --init --recursive
fi
python3 install.py --clangd-completer
cd ~

# Clean and clone Tmux Plugin Manager
if [ -d ~/.tmux/plugins/tpm ]; then
  rm -rf ~/.tmux/plugins/tpm
fi
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tmux plugins and source config
~/.tmux/plugins/tpm/bin/install_plugins
tmux source ~/.tmux.conf

echo "✅ Setup complete!"
