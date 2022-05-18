set nocompatible " for vim-polyglot

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

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

set termguicolors

" set text width to 80. in program files this will only wrap comments.
" in html and shell scripts, don't wrap at all
set textwidth=80
autocmd FileType html,sh set textwidth=0

" speedup since I run vim from terminal
let did_install_default_menus = 1
let did_install_syntax_menu = 1

" show capture group word is highlighted by
nmap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" disable syntax highlighting that we get from treesitter. needs to be done
" before polyglot is loaded
let g:polyglot_disabled = ['html', 'help', 'go', 'graphql', 'javascript', 'json', 'lua', 'php', 'python', 'ruby', 'rust', 'typescript']

" enable gitgutter
let g:gitgutter_enabled = 1

" rainbow parenthesis
let g:rainbow_active = 1

" settings for vim-test jest
let test#javascript#jest#executable = 'yarn run jest'
let test#strategy = 'floaterm'

" settings for ruby
"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"let g:rubycomplete_buffer_loading = 1
"let g:rubycomplete_classes_in_global = 1
"let g:rubycomplete_rails = 1
"let g:ruby_heredoc_syntax_filetypes = {
      "\ "graphql" : {"start" : "GRAPHQL"},
      "\ "pgsql"   : { "start" : "GRAPHQL", }
    "\}


" PLUGINS
call plug#begin('~/.vim/plugged')

  " THEMES
  Plug 'ueaner/molokai'
  Plug 'dracula/vim', { 'as': 'dracula' }

  " LSP
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'neovim/nvim-lspconfig'

  " COMPLETION
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
  Plug 'hrsh7th/vim-vsnip'
  "Plug 'github/copilot.vim.git'
  " install copilot - https://github.com/github/copilot.vim#getting-started
  " git clone https://github.com/github/copilot.vim.git ~/.config/nvim/pack/github/start/copilot.vim
  "Plug '~/.config/nvim/pack/github/start/copilot.vim'

  " NAVIGATION
  Plug 'jlanzarotta/bufexplorer'
  Plug 'preservim/nerdcommenter'
  Plug 'airblade/vim-gitgutter'
  Plug 'kyazdani42/nvim-tree.lua'

  " JUMPING
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim'
  Plug 'BurntSushi/ripgrep'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-endwise'

  " SYNTAX
  Plug 'mechatroner/rainbow_csv'
  Plug 'luochen1990/rainbow'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSInstall comment dot html help go graphql javascript json lua make php python ruby rust tsx typescript'}

  Plug 'sheerun/vim-polyglot'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'vim-ruby/vim-ruby'

  " TESTING
  Plug 'vim-test/vim-test'
  Plug 'voldikss/vim-floaterm'

  " RAILS
  Plug 'tpope/vim-rails'

call plug#end()

try
  colorscheme molokai
catch
  echo "colorscheme molokai not found. run PlugInstall"
endtry


set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

"set completeopt=menu,menuone,noselect

"" add highlighting for note and todo
match vimTodo "FIXME"
match vimTodo "NOTE"

" if you have trouble with this config, comment it out. run PlugInstall and
" uncomment
try
lua <<EOF

  -- NVIMTREE
  vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 0,
    files = 0,
    folder_arrows = 0,
  }
  require'nvim-tree'.setup()

  -- TELESCOPE
  local actions = require("telescope.actions")
  require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        },
      },
    },
  })

  -- LSP
  -- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Setup lspconfig.
  local servers = { 'tsserver', 'gopls', 'terraformls', 'intelephense' }
  for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
      }
    }

  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>N', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<C-Up>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<C-Down>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', '<leader>L', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  end

  -- COMPLETION
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
      ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
     end
    end
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

  -- TREESITTER
  require'nvim-treesitter.configs'.setup {
  ensure_installed = { "comment", "dot", "html", "help", "go", "graphql", "javascript", "json", "lua", "make", "php", "python", "ruby", "rust", "tsx", "typescript"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    },
  }
  end
EOF
catch
  echo "no lspconfig. install run PlugInstall"
endtry

" KEYBINDINGS
" TREESITTER
nmap <leader>nt <cmd>:NvimTreeToggle<CR>

" TELESCOPE
nmap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nmap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nmap <leader>fw <cmd>lua require('telescope.builtin').live_grep()<CR>
nmap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nmap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>

" VIM-TEST
nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>

" convenience mappings
"new buffer because I forget this all the time
nmap <leader>nb :new<CR>

" edit/reload vim config
nmap <leader>ev :e $MYVIMRC<CR>
nmap <Leader>rl :so ~/.config/nvim/init.vim<CR>

cnoreabbrev move Move
cnoreabbrev delete Delete
inoremap <Leader>pwd <C-R>=getcwd()<CR> " insert filepath

" touble tap esc to dehighlight the last search
nmap <esc><esc> :noh<return><esc>

" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n><CR>

" uppercase Y to yank full line - wtf neovim nightly, why you playin with my heart
nmap Y yy

" format with jq
command! JQ set ft=json | :%!jq .

" maintain selection fixing indent
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

" codebase navigation
nmap <S-Left> :cprevious<cr>
nmap <S-Right> :cnext<cr>
