" speedup since I run vim from terminal
let did_install_default_menus = 1
let did_install_syntax_menu = 1

"plugins
call plug#begin('~/.vim/plugged')

		" Autocomplete
		Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
		Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

		Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
		Plug 'vim-airline/vim-airline'
		Plug 'sheerun/vim-polyglot'
		Plug 'tpope/vim-dispatch'
		Plug 'tpope/vim-surround'
		Plug 'radenling/vim-dispatch-neovim' 
		Plug 'dense-analysis/ale'

		Plug 'jlanzarotta/bufexplorer'
		Plug 'preservim/nerdcommenter'
		Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
		Plug 'rstacruz/vim-closer'
		Plug 'mechatroner/rainbow_csv'
		Plug 'airblade/vim-gitgutter'
		Plug 'tpope/vim-rails'
		Plug 'tpope/vim-eunuch'

		"themes
		Plug 'ueaner/molokai'
call plug#end()

" Deoplete and language server
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
						\ 'ruby': ['solargraph', 'stdio'],
						\ 'rust': ['rust-analyzer'],
						\ 'go': ['gopls'],
						\ }
let g:LanguageClient_rootMarkers = {
						\ 'ruby': ['Gemfile']
						\ }

" let me use tabs to work with deoplete
set hidden 
inoremap <silent><expr> <TAB>
						\ pumvisible() ? "\<C-n>" :
						\ <SID>check_back_space() ? "\<TAB>" :
						\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

"Ale config"
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_set_highlights = 0
let g:ale_linters = { 'ruby': ['standardrb'], 'go': ['gopls'], 'terraform': ['tflint'] }
let g:ale_enabled = 1
let g:ale_fixers = { 'ruby': ['standardrb'], 'go': ['gofmt'], 'terraform': ['terraform'], '*': ['remove_trailing_lines', 'trim_whitespace']}
let g:fix_on_save = 1

" LeaderF fuzzy search
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1


" autocomplete for ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" touble tap esc to dehighlight the last search
nnoremap <esc><esc> :noh<return><esc>

" enable gitgutter
let g:gitgutter_enabled = 1

"allow project specifc .vimrc and disable commands
set exrc
set secure

" General config
colorscheme molokai
let mapleader = ","
filetype plugin indent on
syntax on
set mouse=a
set tw=80
set ruler
set ts=2
set sw=2
set number
set et

" convenience mappings
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <Leader>rl :so $MYVIMRC<CR>
command! W :w
command! Q :q
cnoreabbrev ff ALEFix
cnoreabbrev move Move
cnoreabbrev delete Delete

"maintain selection fixing indent
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" Auto indent
set ai
set ci

" Nerd Tree
nnoremap <Leader>nt :NERDTree<CR>
let NERDTreeShowHidden=1

" insert filepath
inoremap <Leader>fp <C-R>=getcwd()<CR>
