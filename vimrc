" speedup since I run vim from terminal
let did_install_default_menus = 1
let did_install_syntax_menu = 1

"plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'radenling/vim-dispatch-neovim' 

" Multi language linter
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'dense-analysis/ale'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

Plug 'Shougo/echodoc.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'

Plug 'jlanzarotta/bufexplorer'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Townk/vim-autoclose'
Plug 'mechatroner/rainbow_csv'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-eunuch'

"themes
Plug 'tomasr/molokai'

call plug#end()

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
let g:deoplete#enable_at_startup = 1
set hidden
let g:LanguageClient_serverCommands = {
						\ 'ruby': ['solargraph', 'stdio'],
						\ 'rust': ['rust-analyzer'],
						\ 'go': ['gopls'],
						\ }
let g:LanguageClient_rootMarkers = {
						\ 'ruby': ['Gemfile']
						\ }
" tab to work with deople
inoremap <silent><expr> <TAB>
						\ pumvisible() ? "\<C-n>" :
						\ <SID>check_back_space() ? "\<TAB>" :
						\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" doc stuff
set cmdheight=2
let g:echodoc#enable_at_startup = 1

filetype plugin indent on
syntax on
" LeaderF fuzzy search
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1

" set up airline for linter
" https://techandfi.com/rubocop-vim/
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1

" Disable ALE auto highlights since we're using plugins
let g:ale_set_highlights = 0
let g:ale_enabled = 1
let g:ale_linters = { 'ruby': ['standardrb'], 'go': ['gopls'] }
let g:ale_fixers = { 'ruby': ['standardrb'], '*': ['remove_trailing_lines', 'trim_whitespace']}
let g:fix_on_save = 1
"setup vim-ruby to use same indentation as standard rb
let g:ruby_indent_assignment_style = 'variable'

cnoreabbrev ff ALEFix
cnoreabbrev move Move
cnoreabbrev delete Delete

" autocomplete for ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

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
set tw=80
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
command! Q :q

"set <leader>
let mapleader = ","

"Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

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


" insert filepath
inoremap <Leader>fp <C-R>=getcwd()<CR>
