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
ln -s "$PWD/tmux.conf" "$HOME/.tmux.conf"
ln -s "$PWD/gemrc" "$HOME/.gemrc"

mkdir -p "$HOME/.config/nvim/"
ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"


#brew
brew update && brew install the_silver_searcher rbenv
