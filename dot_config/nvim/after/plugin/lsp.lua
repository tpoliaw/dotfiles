local rt = require("rust-tools")

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.keymap.set("n", "<leader>]", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

local keymap = function(buf)
   local map = function(key, func)
      local opts = { noremap = true, silent = true, buffer = buf }
      vim.keymap.set("n", key, func, opts)
   end
   return map
end

local on_attach = function(client, bufnum)
   -- Enable completions triggered by <C-x><C-o>
   vim.api.nvim_buf_set_option(bufnum, "omnifunc", "v:lua.vim.lsp.omnifunc")
   local keymap = keymap(buffnum)
   -- Key mappings
   keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
   keymap("gd", "<cmd>Telescope lsp_definitions<CR>")
   keymap("gtd", "<cmd>Telescope lsp_type_definitions<CR>")
   keymap("gr", "<cmd>Telescope lsp_references<CR>")
   keymap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
   keymap("K", "<cmd>RustHoverActions<CR>")
   keymap("<c-k>", "<cmd>lua vim.lsp.buf.hover()<CR>")
   keymap("<leader>1", "<cmd>lua vim.lsp.buf.code_action()<CR>")
   keymap("<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
end

rt.setup({
   tools = {
      executor = require("rust-tools/executors").termopen,
      hover_actions = {
         auto_focus = true,
      },
   },
   server = {
      on_attach = on_attach,
      standalone = false,
      flags = {
         debounce_text_changes = 150,
      },
   },
})
