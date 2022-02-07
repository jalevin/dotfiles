#! /bin/sh

# call this from $HOME/{projects}/dotfiles
# assumes you've git cloned dotfiles and are auth'd to github

#brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# minimal brew install
brew install git neovim@HEAD

#autoload
AUTOLOAD="$HOME/vim/autoload"
mkdir -p $AUTOLOAD && cd $AUTOLOAD
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# neovim
mkdir -p "$HOME/.config/nvim/"
ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"
ln -s "$PWD/vim.vimrc" "$HOME/.vim.vimrc"
ln -s "$PWD/default.vimrc" "$HOME/.vimrc"
ln -s "$PWD/vscode.vimrc" "$HOME/.vscode.vimrc"

ln -s "$PWD/gitconfig" "$HOME/.gitconfig"
ln -s "$PWD/zshrc" "$HOME/.zshrc"
ln -s "$PWD/tmux.conf" "$HOME/.tmux.conf"
ln -s "$PWD/gemrc" "$HOME/.gemrc"







#neovim
#NVIM v0.6.0-dev+434-g7f93b2ab0
#brew install neovim --HEAD

#brew install \
  #the_silver_searcher \
  #rbenv \
  #pyenv \
  #ripgrep \
  #vgrep \
  #jq \
  #tldr

# go
