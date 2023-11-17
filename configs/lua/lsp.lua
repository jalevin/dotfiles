-- LSP

require("mason").setup()
local masonlspconfig = require("mason-lspconfig")
masonlspconfig.setup({
  ensure_installed = {
    "bashls", "dockerls", "golangci_lint_ls", "gopls", "html", "intelephense",
    "jsonls", "jsonnet_ls", "lua_ls", "sqlls", "tailwindcss", "terraformls",
    "tflint", "tsserver", "vimls", "ruby_ls"

    --"ansible-lint", "golangci-lint", "luacheck", "markdownlint", "misspell",
    --"standardrb", "staticcheck", "tlint", "yamllint",
    --"gofumpt", "goimports", "golines", "jq", "markdownlint", "rubyfmt",
  }
})

-- get default capabilities for autocomplete
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local lspconfig = require('lspconfig')
masonlspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach
    }
  end
})

-- configure mason for linters
require("mason-null-ls").setup({
    ensure_installed = {
      "ansible-lint", "golangci-lint", "luacheck", "markdownlint", "misspell",
      "standardrb", "staticcheck", "tlint", "yamllint", "stylua", "jq"
    }
})

--  require("copilot").setup({
--    suggestion = { enabled = false },
--    panel = { enabled = false },
--  })
--  require("copilot_cmp").setup()

-- config for gopls to handle integration tests
--  lspconfig.gopls.setup {
--    capabilities = capabilities,
--    on_attach = on_attach,
--    settings = {
--      gopls =  {
--        -- add flags for integration tests and wire code gen in grafana
--        env = {
--          GOFLAGS="-tags=wireinject"
--          }
--        }
--      }
--    }
