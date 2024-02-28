vim.api.nvim_create_autocmd("BufWritePre", {
   buffer = 0,
   callback = function()
      if vim.lsp.buf_is_attached() then
         vim.lsp.buf.format({ async = false })
      end
   end,
})
