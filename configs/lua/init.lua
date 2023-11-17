require('lsp')
require('cmp-init')
require('treesitter-init')
require('telescope-init')

-- config for typescript/javascript prettier
--local null_ls = require("null-ls")
--null_ls.setup({
--  on_attach = function(client, bufnr)
--    if client.server_capabilities.documentFormattingProvider then
--      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")
--      -- format on save
--      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
--    end
--
--    if client.server_capabilities.documentRangeFormattingProvider then
--      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
--    end
--  end,
--})




--local function format()
--  vim.lsp.buf.format { async = true }
--end
--
--vim.api.nvim_create_autocmd(
--  'BufWritePre',
--  {
--    buffer = buffer,
--    callback = function()
--      vim.lsp.buf.format { async = false }
--    end
--  }
--)
