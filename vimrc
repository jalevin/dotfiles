" vim: set ft=vim :

" speedup since I run vim from terminal
let did_install_default_menus = 1
let did_install_syntax_menu = 1

"plugins
call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-dispatch'

  if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  end

  " Autocomplete
  Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  	if has('win32') || has('win64')
		Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
	else
		Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
  endif

  " Linters + syntax
  Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
  Plug 'vim-airline/vim-airline'
  Plug 'sheerun/vim-polyglot'
  Plug 'radenling/vim-dispatch-neovim'
  Plug 'dense-analysis/ale'
  Plug 'luochen1990/rainbow'

  " navigation
  Plug 'jlanzarotta/bufexplorer'
  Plug 'preservim/nerdcommenter'
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'mechatroner/rainbow_csv'
  Plug 'airblade/vim-gitgutter'

  " closers
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise'
  Plug 'rstacruz/vim-closer'

  " go
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

  " ruby
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rbenv'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-eunuch'

  "themes
  Plug 'ueaner/molokai'
  Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" Deoplete and language server
"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['solargraph', 'stdio'],
		\ 'rust': ['rust-analyzer'],
		\ 'go': ['gopls'],
		\ }
let g:LanguageClient_rootMarkers = {
		\ 'ruby': ['Gemfile']
		\ }

" let me use tabs to work with deoplete autocomplete
"function! s:check_back_space() abort "{{{
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~ '\s'
"endfunction"}}}
"inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()

" Autocomplete
nnoremap <silent> <leader>, :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<CR>

"Ale config"
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_set_highlights = 0
let g:ale_linters = { 'ruby': ['standardrb'], 'go': ['gopls'], 'terraform': ['tflint'], 'rust': ['analyzer'] }
let g:ale_sign_style_error = '❌'
let g:ale_enabled = 1
let g:ale_fixers = { 'ruby': ['standardrb'], 'go': ['gofmt'], 'terraform': ['terraform'], 'rust': ['rustfmt'], '*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fix_on_save = 1

" LeaderF fuzzy search
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1

" touble tap esc to dehighlight the last search
nnoremap <esc><esc> :noh<return><esc>

" enable gitgutter
let g:gitgutter_enabled = 1

" General config
let mapleader = ","
colorscheme molokai
syntax on
filetype plugin indent on
set mouse=a
set ruler
set tabstop=2
set shiftwidth=2
set number
set expandtab
set autoindent
set copyindent
set foldmethod=syntax
set foldlevelstart=99 " don't fold by default

" set text width to 80. in program files this will only wrap comments.
" in html and shell scripts, don't wrap at all
set textwidth=80
autocmd FileType html,sh set textwidth=0

" convenience mappings
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <Leader>rl :so $MYVIMRC<CR>
"command! E :e
"command! W :w
"command! Q :q
"command! Wq :wq
cnoreabbrev ff ALEFix
cnoreabbrev move Move
cnoreabbrev delete Delete
inoremap <Leader>pwd <C-R>=getcwd()<CR> " insert filepath

" maintain selection fixing indent
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" rainbow parenthesis
let g:rainbow_active = 1
" Nerd Tree
nnoremap <Leader>nt :NERDTree<CR>
let NERDTreeShowHidden=1

" settings for ruby
"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" setup for tagging
"set tags+=.tags
"nnoremap <leader>rt :silent ! ripper-tags -R --exclude=src-databases --exclude=volume --exclude=log --exclude=tmp --exclude=dumps --exclude=test/data --exclude=.git --exclude=log -f .tags<cr>
"nnoremap <leader>pt :silent ! ptags -R --languages=ruby --exclude=volume --exclude=test/data --exclude=.git --exclude=log -f .tags<cr>
"nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>


" autoclose
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O
