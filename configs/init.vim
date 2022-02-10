set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" vim: set ft=vim :
let mapleader = ","

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
"new buffer because I forget this all the tiem
nnoremap <leader>nb :new<CR>

" reload vim config
if has('nvim')
  nnoremap <Leader>rl :so ~/.config/nvim/init.vim<CR>
else
  nnoremap <Leader>rl :so ~/.vimrc <CR>
end

nnoremap <leader>ev :e ~/.vimrc<CR>

"command! E :e
"command! W :w
"command! Q :q
"command! Wq :wq
"cnoreabbrev ff ALEFix
cnoreabbrev move Move
cnoreabbrev delete Delete
inoremap <Leader>pwd <C-R>=getcwd()<CR> " insert filepath

" touble tap esc to dehighlight the last search
nnoremap <esc><esc> :noh<return><esc>

" uppercase Y to yank full line - wtf neovim nightly, why you playin with my heart
nnoremap Y yy

" format with jq
command! JQ set ft=json | :%!jq .

" maintain selection fixing indent
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" speedup since I run vim from terminal
let did_install_default_menus = 1
let did_install_syntax_menu = 1

" caddyfile
au BufRead,BufNewFile Caddyfile* set filetype=caddyfile
au BufRead,BufNewFile *env.* set filetype=sh
au BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
au BufRead,BufNewFile docker-compose.* set filetype=yaml.docker-compose



" show capture group word is highlighted by
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>



"plugins
call plug#begin('~/.vim/plugged')
  " colors
  Plug 'ueaner/molokai'
  Plug 'dracula/vim', { 'as': 'dracula' }

  Plug 'tpope/vim-dispatch'
  if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  "Plug 'github/copilot.vim.git'
  " install copilot - https://github.com/github/copilot.vim#getting-started
  " git clone https://github.com/github/copilot.vim.git ~/.config/nvim/pack/github/start/copilot.vim
  Plug '~/.config/nvim/pack/github/start/copilot.vim'

  "https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

  " For Denite features
  "Plug 'Shougo/denite.nvim'

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

  " go
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

  " ruby
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rbenv'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-eunuch'

call plug#end()

try
  colorscheme molokai
catch
  echo "colorscheme molokai not found. run PlugInstall"
endtry


" See `:help vim.lsp.*` for documentation on any of the below functions
nnoremap <leader>gr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>

" need to figure out how to not overwrite normal mode delete end of line or
" delete line
nnoremap <silent>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent>gd <cmd>lua vim.lsp.buf.definition()<CR>



set completeopt=menu,menuone,noselect
" if you have trouble with this config, comment it out. run PlugInstall and
" uncomment
try
lua <<EOF

  -- setup lsp
  -- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
  -- FIXME not sure if I need this
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap=true, silent=true }
  end


  -- Setup nvim-cmp.
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
--      ['<Tab>'] = function(fallback)
--      if cmp.visible() then
--        cmp.select_next_item()
--      else
--        fallback()
--      end
--    end
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'cmp_tabnine' },
      { name = 'buffer' }
    },

    --  https://alpha2phi.medium.com/new-neovim-completion-plugins-you-should-try-b5e1a3661623
    formatting = {
      format = function(entry, vim_item)
      -- set a name for each source
      vim_item.menu = ({
          buffer = "[BUF]",
          nvim_lsp = "[LSP]",
      --    ultisnips = "[UltiSnips]",
      --    nvim_lua = "[Lua]",
          cmp_tabnine = "[TN]",
      --    look = "[Look]",
          path = "[Path]",
          spell = "[Spell]",
          calc = "[Calc]",
          emoji = "[Emoji]"
      })[entry.source.name]
      return vim_item
    end
      }
  })


  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Setup lspconfig.
  require'lspconfig'.tsserver.setup{
    capabilities = capabilities,
  }
  require'lspconfig'.gopls.setup{
    capabilities = capabilities,
  }
  require'lspconfig'.terraformls.setup{
    capabilities = capabilities,
  }
EOF
catch
  echo "no lspconfig. install run PlugInstall"
endtry

"" add highlighting for note and todo
match vimTodo "FIXME"
match vimTodo "NOTE"

"Ale config"
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_enabled = 1

let g:ale_linters_explicit = 1
let g:ale_linters = {
      \  'ruby': ['standardrb'],
      \}
      "\  'go': ['gopls'],
      "\  'terraform': ['tflint'],
      "\  'rust': ['analyzer'],
      "\  'typescript': ['eslint', 'tsserver'],
      "\ }
let g:ale_sign_style_error = '❌'
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \  'ruby': ['standardrb'],
      \  'go': ['gofmt'],
      \  'terraform': ['terraform'],
      \  'rust': ['rustfmt'],
      \  'typescript': ['prettier', 'eslint'],
      \  '*': ['remove_trailing_lines', 'trim_whitespace']
      \ }
let g:ale_typescript_prettier_use_local_config = 1

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
      \ "pgsql"   : { "start" : "GRAPHQL", }
    \}
