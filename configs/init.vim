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
let g:go_metalinter_command = "golangci-lint"

"" add highlighting for note and todo
match vimTodo "FIXME"
match vimTodo "NOTE"

" PLUGINS
call plug#begin('~/.vim/plugged')

  " THEMES
  Plug 'ueaner/molokai'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'keyvchan/monokai.nvim'

  " LSP
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'neovim/nvim-lspconfig'

  " prettier
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'MunifTanjim/prettier.nvim'

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
  "https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
  Plug 'kyazdani42/nvim-tree.lua'

  " JUMPING
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim'
  "Plug 'BurntSushi/ripgrep'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-endwise'

  " SYNTAX
  "Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'mechatroner/rainbow_csv'
  Plug 'luochen1990/rainbow'

  " if you run into issues update parsers with TSUpdate
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSInstall comment dot html help go graphql javascript json lua php python ruby rust tsx typescript vimscript vim'}
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
  ensure_installed = { "comment", "dot", "html", "help", "go", "graphql", "javascript", "json", "php", "python", "ruby", "rust", "tsx", "typescript"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    },
  }

  -- NVIMTREE
  require'nvim-tree'.setup({
    git = {
      -- show ignored git files
      ignore = false
    },
    -- https://taoshu.in/vim/migrate-nerdtree-to-nvim-tree.html
    renderer = {
      icons = {
        show = {
          git = true,
          file = false,
          folder = false,
          folder_arrow = true,
        },
        glyphs = {
          folder = {
            arrow_closed = "⏵",
            arrow_open = "⏷",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "⌥",
            renamed = "➜",
            untracked = "★",
            deleted = "⊖",
            ignored = "◌",
          },
        },
      },
      },
  })

  -- TELESCOPE
  local telescope = require("telescope")
  local telescopeConfig = require("telescope.config")
  local actions = require("telescope.actions")
  -- Clone the default Telescope configuration
--  local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
--   table.insert(vimgrep_arguments, "--unrestricted")
--  ---- search hidden/dot files.
--  table.insert(vimgrep_arguments, "--hidden")
--  ---- ignore .git dir
--  table.insert(vimgrep_arguments, "--glob")
--  table.insert(vimgrep_arguments, "!**/.git/*")
--  ---- don't ignore .gitignore dirs
--  table.insert(vimgrep_arguments, "--no-ignore")

  telescope.setup({
    defaults = {
      -- `hidden = true` is not supported in text grep commands.
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '--unrestricted',
        },
      mappings = {
        i = {
          ["<esc>"] = actions.close,
        },
      },
    },
    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--unrestricted" },
      },
    },
  })

  -- LSP
  -- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local servers = { 'tsserver',  'terraformls', 'golangci_lint_ls', "tailwindcss", "intelephense"} --, "ruby_ls"}
  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach
    }
  end

  -- config for gopls to handle integration tests
  lspconfig.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      gopls =  {
        -- add flags for integration tests and wire code gen in grafana
        env = {
          GOFLAGS="-tags=wireinject"
          }
        }
      }
    }

  -- config for php
  lspconfig.intelephense.setup {
    on_attach=on_attach,
    capabilities=capabilities,
    settings = { intelephense = { files = { associations = {"*.php", "*.phtml", "*.module", "*.inc"}}}}
  }


  -- config for typescript/javascript prettier
  local null_ls = require("null-ls")
  null_ls.setup({
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")
        -- format on save
        vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
      end

      if client.server_capabilities.documentRangeFormattingProvider then
        vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
      end
      end,
    })

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

  -- indentation lines
--  require('go').setup({
--    goimport = 'gopls',
--    gofmt = 'gopls',
--  })
--
--  local go_group = vim.api.nvim_create_augroup('Go', { clear = true })
--  vim.api.nvim_create_autocmd('BufWritePre', {
--    -- callback = function() require('go.format').goimport() end,
--    command = "GoImport",
--    group = go_group,
--    pattern = '*.go',
--  })
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
noremap <leader>R <cmd>lua vim.lsp.buf.rename()<CR>
noremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
noremap <leader>F <cmd>lua vim.lsp.buf.formatting()<CR>
noremap <leader>lr <cmd>LspRestart<CR>

noremap E <cmd>lua vim.diagnostic.open_float()<CR>
noremap N <cmd>lua vim.diagnostic.goto_next()<CR>
noremap P <cmd>lua vim.diagnostic.goto_prev()<CR>
noremap <leader>L <cmd>lua vim.diagnostic.set_loclist()<CR>

" format on save
autocmd BufWritePre <buffer> lua vim.lsp.buf.format()


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

