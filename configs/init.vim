set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" default .vimrc
source ~/.default.vimrc

" vim/neovim
if !exists('g:vscode')
  source ~/.vim.vimrc
endif

" vscode
if exists('g:vscode')
  source ~/.vscode.vimrc
endif
