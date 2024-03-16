" legacy from vim. probably don't need this anymore
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath

let mapleader = ','

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
set termguicolors

" set text width to 80. in program files this will only wrap comments.
" in html and shell scripts, don't wrap at all
set textwidth=80
autocmd FileType html,sh set textwidth=0

"" add highlighting for note and todo
match vimTodo "FIXME"
match vimTodo "NOTE"

" PLUGINS
call plug#begin('~/.vim/plugged')
  " THEMES
  Plug 'ueaner/molokai'
  Plug 'keyvchan/monokai.nvim'
  "Plug 'tanvirtin/monokai.nvim'
  "Plug 'dracula/vim', { 'as': 'dracula' }

  " LSP
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  " Formatting
  Plug 'nvimtools/none-ls.nvim'
  Plug 'jay-babu/mason-null-ls.nvim'

  " COMPLETION
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/vim-vsnip'
  "Plug 'hrsh7th/cmp-buffer'
  "Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
  "Plug 'zbirenbaum/copilot.lua'
  "Plug 'zbirenbaum/copilot-cmp'

  " NAVIGATION
  Plug 'jlanzarotta/bufexplorer'
  Plug 'preservim/nerdcommenter'
  Plug 'airblade/vim-gitgutter'
  Plug 'kyazdani42/nvim-tree.lua'

  " JUMPING
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-endwise'

  " SYNTAX
  Plug 'mechatroner/rainbow_csv'
  Plug 'luochen1990/rainbow'

  " if you run into issues update parsers with TSUpdate
  Plug 'nvim-treesitter/nvim-treesitter'

  " not sure if I need language plugins now. mostly using syntax highlighting +
  " lsp features all configured by mason
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'

  " TESTING
  Plug 'vim-test/vim-test'
  Plug 'voldikss/vim-floaterm'

call plug#end()

" if issues, comment. run :PlugInstall. uncomment
" IMPORT lua config
lua require('init')

" colors
" if issues, :PlugInstall
"colorscheme monokai
colorscheme molokai

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()


" KEYBINDINGS
" lsp - :help vim.lsp.* for docs
noremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
noremap gd <cmd>lua vim.lsp.buf.definition()<CR>
noremap K <cmd>lua vim.lsp.buf.hover()<CR>
noremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
noremap gr <cmd>lua vim.lsp.buf.references()<CR>
noremap <leader>D <cmd>lua vim.lsp.buf.type_definition()<CR>
noremap <leader>R <cmd>lua vim.lsp.buf.rename()<CR>
noremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
" format on save
"autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
noremap <leader>F <cmd>lua vim.lsp.buf.format()<CR>
noremap <leader>lr <cmd>LspRestart<CR>

noremap E <cmd>lua vim.diagnostic.open_float()<CR>
noremap N <cmd>lua vim.diagnostic.goto_next()<CR>
noremap P <cmd>lua vim.diagnostic.goto_prev()<CR>
noremap <leader>L <cmd>lua vim.diagnostic.set_loclist()<CR>
noremap <Leader>li :LspInfo<CR>

noremap <Leader>x <cmd>lua vim.print(null_ls.builtins)<CR>




function FoldConfig()
	set foldmethod=expr
	set foldexpr=nvim_treesitter#foldexpr()
endfunction
autocmd BufAdd,BufEnter,BufNew,BufNewFile,BufWinEnter * :call FoldConfig()


" codebase navigation
noremap <S-Left> :cprevious<cr>
noremap <S-Right> :cnext<cr>

" nvim tree
" https://raw.githubusercontent.com/kyazdani42/nvim-tree.lua/master/doc/nvim-tree-lua.txt - search DEFAULT MAPPINGS
noremap <leader>nt <cmd>:NvimTreeToggle<CR>

" telescope 
noremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
noremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
noremap <leader>fw <cmd>lua require('telescope.builtin').live_grep()<CR>
noremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
noremap <leader>fbg <cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>
noremap <leader>fs <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>

" vim-test
noremap <leader>tn :TestNearest<CR>
noremap <leader>tf :TestFile<CR>
noremap <leader>ts :TestSuite<CR>

" convenience mappings
"new buffer because I forget this all the time
noremap <leader>nb :new<CR>

" edit/reload vim config
noremap <leader>ev :e $MYVIMRC<CR>
noremap <leader>el :e ~/.config/nvim/lua<CR>
noremap <Leader>rl :so ~/.config/nvim/init.vim<CR>

" clipboard
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy
noremap <leader>Y "+yg_

cnoreabbrev move Move
cnoreabbrev delete Delete
inoremap <Leader>pwd <C-R>=getcwd()<CR> " insert filepath

" touble tap esc to:
"   dehighlight the last search
"   close quickfix window
"   close Floatterm
noremap <Esc><Esc> :noh<bar>:cclose<bar>:FloatermKill<CR>

" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n><CR>

" format with jq
command! JQ set ft=json | :%!jq .

" maintain selection fixing indent
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" PLUGIN configs
" speedup since I run vim from terminal
let did_install_default_menus = 1
let did_install_syntax_menu = 1

" show capture group word is highlighted by
noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" enable gitgutter
let g:gitgutter_enabled = 1

" rainbow parenthesis
let g:rainbow_active = 1

" settings for vim-test jest
let test#javascript#jest#executable = 'yarn run jest'
let test#strategy = 'floaterm'

" keep vim-go from setting go doc mapping
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled= 0
let g:go_metalinter_command = 'golangci-lint'
