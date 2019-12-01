colorscheme molokai
let g:molokai_original = 1

" touble tap esc to dehighlight the last search
nnoremap <esc><esc> :noh<return><esc>

" fix vim autoclose messing with you complete me
let g:AutoClosePumvisible = {"ENTER": "", "ESC": ""}

" reload vimrc on save
"augroup myvimrc
    "au!
    "au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
"augroup END

" enable gitgutter
let g:gitgutter_enabled = 1

" relative number by default
set number norelativenumber

"nnoremap <Leader>rl :so $MYVIMRC<CR>

set complete=.,w,b,u,t,i,kspell

set ruler
set ts=2
set sw=2

"iterm mouse support
set mouse=a

"allow project specifc .vimrc and disable commands
set exrc
set secure

"pathogen
execute pathogen#infect()
filetype plugin indent on
syntax on

command! W :w

"set <leader>
let mapleader = ","

"RuboCop
"let g:vimrubocop_keymap = 0
"nmap <Leader>r :RuboCop<CR>

"80 char warning
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" Auto indent
set ai
set ci

"maintain selection fixing indent
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" RSpec
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>

" Nerd Tree
nnoremap <Leader>nt :NERDTree<CR>

" Open vagrant files as ruby
au BufNewFile,BufRead Vagrantfile set ft=ruby

" sessions
"let g:session_autosave = 'yes'
"let g:session_autoload = 'yes'
