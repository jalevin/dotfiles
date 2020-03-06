#! /bin/sh

### Vim config
HOME=$PWD

## plugins only loaded with nvim/vim all other config loaded with vi as well
#AFTER="$HOME/vim/after"
#mkdir -p "$HOME/vim/after" && cd $AFTER

#autoload
AUTOLOAD="$HOME/vim/autoload" 
mkdir -p $AUTOLOAD && cd $AUTOLOAD
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s "$PWD/vim" "$HOME/.vim"
ln -s "$PWD/vimrc" "$HOME/.vimrc"
ln -s "$PWD/zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config/nvim/"
ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"

# UNTESTED - installs ruby fmt
cd "$HOME/.config/nvim" && 
	git clone https://github.com/penelopezone/rubyfmt/ --branch=v0.2.0 && 
	cd "$HOME/.config/nvim/rubyfmt" &&
	make &&
	make install
