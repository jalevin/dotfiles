-- TREESITTER - highlighting
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "comment", "dot", "html", "help", "go", "graphql", "javascript", "json", "php", "python", "ruby", "rust", "tsx", "typescript", "jsonnet" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- NVIMTREE - code navigation
require 'nvim-tree'.setup({
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
