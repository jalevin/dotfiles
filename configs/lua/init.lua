-- import lua configs. suffixed with -init to avoid naming conflicts
require('lsp-init')
require('cmp-init')
require('telescope-init')
require('nvim-tree-init')

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
