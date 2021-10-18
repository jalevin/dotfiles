"plugins
call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-dispatch'
  if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

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


" See `:help vim.lsp.*` for documentation on any of the below functions
nnoremap <silent>gr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent>gi <cmd>lua vim.lsp.buf.implementation()<CR>



set completeopt=menu,menuone,noselect
" if you have trouble with this config, comment it out. run PlugInstall and
" uncomment
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
      ['<TAB>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
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

"Ale config"
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_enabled = 1

let g:ale_linters_explicit = 1
"let g:ale_linters = {
      "\  'ruby': ['standardrb'],
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

" let deoplete use ALE for completion
"call deoplete#custom#option('sources', {
"\ '_': ['ale', 'tabnine'],
"\})

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
