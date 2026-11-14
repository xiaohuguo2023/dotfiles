#!/bin/bash

# Exit on any error
set -e  

# Install required packages. The package manager and some names differ
# between Debian or Ubuntu and RHEL or CentOS.
if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y universal-ctags global cmake \
                        build-essential python3-dev vim
elif command -v dnf >/dev/null 2>&1; then
    # ctags and global come from EPEL on RHEL and CentOS. Enable it first:
    #   sudo dnf install -y epel-release
    sudo dnf install -y ctags global cmake gcc-c++ make \
                        python3-devel vim-enhanced
else
    echo "No apt and no dnf. Install ctags, global, cmake, a C++ compiler," >&2
    echo "the python3 headers and vim by hand, then run this script again." >&2
    exit 1
fi

# The distribution vim is new enough now, so there is no source build here.
# Build vim from source only if YouCompleteMe reports that vim is too old.

# Copy .vimrc and .tmux.conf if they exist in the script's directory
# Use $0, not BASH_SOURCE, so the script also works under "sh dotinit.sh".
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
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
