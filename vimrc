" speedup since I run vim from terminal
let did_install_default_menus = 1
let did_install_syntax_menu = 1

"plugins
call plug#begin('~/.vim/plugged')

	" Multi language linter
	Plug 'dense-analysis/ale'
	Plug 'vim-airline/vim-airline'
	Plug 'sheerun/vim-polyglot'
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

	" Navigator - load on demand
	Plug 'jlanzarotta/bufexplorer'
	Plug 'preservim/nerdcommenter'
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'Townk/vim-autoclose'
	Plug 'ap/vim-css-color'
	Plug 'mechatroner/rainbow_csv'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-vinegar'
	Plug 'fatih/vim-go'
	Plug 'tpope/vim-rails'
	Plug 'tpope/vim-eunuch'
	Plug 'vim-ruby/vim-ruby'
	Plug 'pearofducks/ansible-vim'
	"themes
	Plug 'tomasr/molokai'
	"Plug 'kchmck/vim-coffee-script'
	"Plug 'tpope/vim-surround'
	"Plug 'jwhitley/vim-literate-coffeescript'

call plug#end()

filetype plugin indent on
syntax on

" set up airline for linter
" https://techandfi.com/rubocop-vim/
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1

" Disable ALE auto highlights since we're using plugins
let g:ale_set_highlights = 0
let g:ale_linters = { 'ruby': ['standardrb'] }
let g:ale_enabled = 1
let g:ale_fixers = { 'ruby': ['standardrb'], '*': ['remove_trailing_lines', 'trim_whitespace']}
let g:fix_on_save = 1
"setup vim-ruby to use same indentation as standard rb
let g:ruby_indent_assignment_style = 'variable'

cnoreabbrev ff ALEFix
cnoreabbrev move Move
cnoreabbrev delete Delete

" live reload files that change on disk - hopefully I don't shoot myself in
" the foot here
set autoread

" theme
colorscheme molokai
let g:molokai_original = 1
"set termguicolors

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
set sw=4

"" Use 2 space tabs for certain languages
autocmd FileType ruby,eruby,javascript,html set sw=2 sts=2 et

"iterm mouse support
set mouse=a

"allow project specifc .vimrc and disable commands
set exrc
set secure

" map W to w so I don't get messages all the time
command! W :w

"set <leader>
let mapleader = ","

"Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

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
let NERDTreeShowHidden=1

" sessions
"let g:session_autosave = 'yes'
"let g:session_autoload = 'yes'
