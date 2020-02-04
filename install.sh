HOME=$PWD

### Vim config
## plugins only loaded with nvim/vim all other config loaded with vi as well
AFTER="$HOME/vim/after"
mkdir -p "$HOME/vim/after" && cd $AFTER
git clone https://github.com/Valloric/YouCompleteMe && \
	cd "YouCompleteMe" && \
	git submodule update --init --recursive && \
	python3 install.py --cs-completer --go-completer --clangd-completer

#autoload
AUTOLOAD="$HOME/vim/autoload" 
mkdir -p $AUTOLOAD && cd $AUTOLOAD
curl -O https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim 
curl -O https://raw.githubusercontent.com/wojtekmach/vim-rename/master/plugin/Rename.vim

#bundle
BUNDLE="$HOME/vim/bundle"
mkdir -p $BUNDLE && cd $BUNDLE
git clone https://github.com/pearofducks/ansible-vim
git clone https://github.com/vim-scripts/bufexplorer.zip
git clone https://github.com/scrooloose/nerdcommenter
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/Townk/vim-autoclose
git clone https://github.com/kchmck/vim-coffee-script
git clone https://github.com/ap/vim-css-color
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/fatih/vim-go
git clone https://github.com/jwhitley/vim-literate-coffeescript
git clone https://github.com/tpope/vim-rails
git clone https://github.com/thoughtbot/vim-rspec
git clone https://github.com/tpope/vim-vinegar
git clone https://github.com/hashivim/vim-terraform.git

#colors
COLORS="$HOME/vim/colors"
mkdir -p $COLORS && cd $COLORS
curl -O https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

ln -s "$PWD/vim" "$HOME/.vim"
ln -s "$PWD/vimrc" "$HOME/.vimrc"
ln -s "$PWD/zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config/nvim/"
ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"
