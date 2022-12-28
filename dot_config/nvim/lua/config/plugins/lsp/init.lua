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
      local opts = { noremap = true, silent = true }

      local keymap = function(buf)
         local map = function(key, func)
            local opts = { noremap = true, silent = true, buffer = buf }
            vim.keymap.set("n", key, func, opts)
         end
         return map
      end

      -- Enable completions triggered by <C-x><C-o>
      vim.api.nvim_buf_set_option(bufnum, "omnifunc", "v:lua.vim.lsp.omnifunc")
      local keymap = keymap(buffnum)
      -- Key mappings
      keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
      keymap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
      keymap("gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
      keymap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
      keymap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
      keymap("<c-k>", "<cmd>lua vim.lsp.buf.hover()<CR>")
      keymap("<leader>1", "<cmd>lua vim.lsp.buf.code_action()<CR>")
      keymap("<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
   end
   local caps = vim.lsp.protocol.make_client_capabilities()
   caps = require("cmp_nvim_lsp").default_capabilities(caps)
   caps.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
   }

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
