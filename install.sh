#! /bin/sh

### Vim config
#HOME=${HOME}

#autoload
AUTOLOAD="$HOME/vim/autoload"
mkdir -p $AUTOLOAD && cd $AUTOLOAD
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# vim
mkdir -p "$HOME/.config/nvim/"
ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"
ln -s "$PWD/vim.vimrc" "$HOME/.vim.vimrc"
ln -s "$PWD/default.vimrc" "$HOME/.vimrc"
ln -s "$PWD/vscode.vimrc" "$HOME/.vscode.vimrc"



ln -s "$PWD/gitconfig" "$HOME/.gitconfig"
ln -s "$PWD/zshrc" "$HOME/.zshrc"
ln -s "$PWD/tmux.conf" "$HOME/.tmux.conf"
ln -s "$PWD/gemrc" "$HOME/.gemrc"


#brew
brew install \
  the_silver_searcher \
  rbenv \
  ripgrep \
  vgrep \
  jq
