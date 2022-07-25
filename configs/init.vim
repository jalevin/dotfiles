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
noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
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

" keep vim-go from setting go doc mapping
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled= 0

"" add highlighting for note and todo
match vimTodo "FIXME"
match vimTodo "NOTE"

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
  Plug 'tpope/vim-rails'

  " TESTING
  Plug 'vim-test/vim-test'
  Plug 'voldikss/vim-floaterm'

call plug#end()

" colors
try
  colorscheme molokai
catch
  echo "colorscheme molokai not found. run PlugInstall"
endtry

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

" if you have trouble with this config, comment it out then
" run PlugInstall and uncomment
try
lua <<EOF

  -- TREESITTER
  require'nvim-treesitter.configs'.setup {
  ensure_installed = { "comment", "dot", "html", "help", "go", "graphql", "javascript", "json", "lua", "make", "php", "python", "ruby", "rust", "tsx", "typescript"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    },
  }

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
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local servers = { 'tsserver',  'terraformls', 'intelephense' }
  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach
    }
  end

  -- special config for gopls to handle integration tests
  lspconfig.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      gopls =  {
        -- add flags for integration tests and wire code gen in grafana
        env = {GOFLAGS="-tags=integration, -tags=wireinject"}
        }
      }
    }

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

EOF
catch
  echo "no lspconfig. install run PlugInstall"
endtry

" KEYBINDINGS

" lsp - :help vim.lsp.* for docs
noremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
noremap gd <cmd>lua vim.lsp.buf.definition()<CR>
noremap K <cmd>lua vim.lsp.buf.hover()<CR>
noremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
noremap gr <cmd>lua vim.lsp.buf.references()<CR>
noremap <leader>D <cmd>lua vim.lsp.buf.type_definition()<CR>
noremap <leader>N <cmd>lua vim.lsp.buf.rename()<CR>
noremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
noremap <leader>F <cmd>lua vim.lsp.buf.formatting()<CR>
noremap <leader>lr <cmd>LspRestart

noremap E <cmd>lua vim.diagnostic.open_float()<CR>
noremap <C-Up> <cmd>lua vim.diagnostic.goto_prev()<CR>
noremap <C-Down> <cmd>lua vim.diagnostic.goto_next()<CR>
noremap <leader>L <cmd>lua vim.diagnostic.set_loclist()<CR>

" codebase navigation
noremap <S-Left> :cprevious<cr>
noremap <S-Right> :cnext<cr>

" treesitter
noremap <leader>nt <cmd>:NvimTreeToggle<CR>

" telescope 
noremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
noremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
noremap <leader>fw <cmd>lua require('telescope.builtin').live_grep()<CR>
noremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
noremap <leader>fbg <cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>
noremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>

" vim-test
noremap <leader>tn :TestNearest<CR>
noremap <leader>tf :TestFile<CR>
noremap <leader>ts :TestSuite<CR>

" convenience mappings
"new buffer because I forget this all the time
noremap <leader>nb :new<CR>

" edit/reload vim config
noremap <leader>ev :e $MYVIMRC<CR>
noremap <Leader>rl :so ~/.config/nvim/init.vim<CR>

cnoreabbrev move Move
cnoreabbrev delete Delete
inoremap <Leader>pwd <C-R>=getcwd()<CR> " insert filepath

" touble tap esc to dehighlight the last search
noremap <esc><esc> :noh<return><esc>

" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n><CR>

" format with jq
command! JQ set ft=json | :%!jq .

" maintain selection fixing indent
vnoremap > >gv
vnoremap < <gv
vnoremap = =gv

