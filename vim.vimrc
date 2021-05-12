"plugins
call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-dispatch'
  if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  " Autocomplete
  Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  if has('win32') || has('win64')
    Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
  else
    Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
  endif

  " For Denite features
  Plug 'Shougo/denite.nvim'

  " Linters + syntax
  Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
  "Plug 'vim-airline/vim-airline'
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

  " typescript
  " # REQUIRED: Add a syntax file. YATS is the best
  "Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
  "Plug 'HerringtonDarkholme/yats.vim'

  " go
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

  " ruby
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rbenv'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-eunuch'

call plug#end()

" Deoplete and language server
"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
      \ 'ruby': ['solargraph', 'stdio'],
      \ 'rust': ['rust-analyzer'],
      \ 'go': ['gopls'],
      "\ 'typescript': ['typescript-language-server', '--stdio'],
      \ }
let g:LanguageClient_rootMarkers = {
      \ 'ruby': ['Gemfile']
      \ }

" let me use tabs to work with deoplete autocomplete
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()

" Autocomplete
nnoremap <silent> <leader>, :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<CR>

"Ale config"
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_set_highlights = 0
let g:ale_linters = { 'ruby': ['standardrb'], 'go': ['gopls'], 'terraform': ['tflint'], 'rust': ['analyzer'],  }
let g:ale_sign_style_error = '❌'
let g:ale_enabled = 1
let g:ale_fixers = { 'ruby': ['standardrb'], 'go': ['gofmt'], 'terraform': ['terraform'], 'rust': ['rustfmt'], '*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fix_on_save = 1

" Nerd Tree
nnoremap <Leader>nt :NERDTree<CR>
let NERDTreeShowHidden=1

" LeaderF fuzzy search
nnoremap <leader>fw :Leaderf rg<CR>
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}

" enable gitgutter
let g:gitgutter_enabled = 1

" rainbow parenthesis
let g:rainbow_active = 1

" settings for ruby
"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:ruby_heredoc_syntax_filetypes = {
      \ "graphql" : {"start" : "GRAPHQL"},
      \ "pgsql"   : { \ "start" : "GRAPHQL", }
    \}
