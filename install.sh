#! /bin/sh

# exit if we get an error
set -e

# call this from $HOME/{projects}/dotfiles
# assumes you've git cloned dotfiles and are auth'd to github

ln -F -s "$PWD/gitconfig" "$HOME/.gitconfig"
ln -F -s "$PWD/zshrc" "$HOME/.zshrc"
ln -F -s "$PWD/tmux.conf" "$HOME/.tmux.conf"
ln -F -s "$PWD/gemrc" "$HOME/.gemrc"

# export brews - documentation. never used in this script.
# think about adding to .zshrc
#brew leaves > brews_all.txt

#brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# make sure we have important shell variables
source "$HOME/.zshrc"

# install developer tooling
xargs brew install < "$PWD/brews/essential.txt"

# install gui apps
xargs brew install < "$PWD/brews/gui.txt"

# install optional # FIXME - trim this list
#xargs brew install "$PWD/brews/extra.txt"


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
