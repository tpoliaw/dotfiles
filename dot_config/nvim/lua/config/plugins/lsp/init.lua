local M = {
   "neovim/nvim-lspconfig",
   event = "BufReadPre",
   dependencies = {
      "hrsh7th/cmp-nvim-lsp",
   },
}

function M.config()
   -- diagnostics
   vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = { spacing = 4, prefix = "●" },
      severity_sort = true,
   })
   for type, icon in pairs({ Error = " ", Warn = " ", Hint = " ", Info = " " }) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
   end
   vim.keymap.set("n", "<leader>[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
   vim.keymap.set("n", "<leader>]", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

   local function on_attach(client, bufnum)
      -- Enable completions triggered by <C-x><C-o>
      vim.api.nvim_buf_set_option(bufnum, "omnifunc", "v:lua.vim.lsp.omnifunc")
      local opts = { noremap = true, silent = true, buffer = buf }
      -- Key mappings
      vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      vim.keymap.set("n", "gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
      vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
      vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      vim.keymap.set("n", "<c-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      vim.keymap.set({"n", "x"}, "<leader>1", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      vim.keymap.set("n", "<leader>F", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
   end
   local caps = vim.lsp.protocol.make_client_capabilities()
   caps = require("cmp_nvim_lsp").default_capabilities(caps)
   caps.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
   }

   require("lspconfig")["pyright"].setup({
      on_attach = on_attach,
      capabilities = caps,
   })

   require("lspconfig")["rust_analyzer"].setup({
      on_attach = on_attach,
      capabilities = caps,
      flags = {
         debounce_text_changes = 150,
      },
      cargo = { allFeatures = true },
      checkOnSave = {
         command = "clippy",
         extraArgs = { "--no-deps" },
      },
   })
end

return M
