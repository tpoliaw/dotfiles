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
      virtual_text = { spacing = 4, prefix = "● " },
      severity_sort = true,
      signs = {
         text = {
            [vim.diagnostic.severity.ERROR] = "✗ ",
            [vim.diagnostic.severity.WARN] = "? ",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = " ",
         }
      }
   })
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
      vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      vim.keymap.set("n", "<leader>F", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
   end
   local caps = vim.lsp.protocol.make_client_capabilities()
   caps = require("cmp_nvim_lsp").default_capabilities(caps)
   caps.textDocument.foldingRange = {
      dynamicRegistration = true,
      lineFoldingOnly = true,
   }
   caps.offsetEncoding = { 'utf-16' }
   caps.general = { positionEncodings = { 'utf-16' } }

   vim.lsp.enable("pyright")
   vim.lsp.config("pyright", {
      on_attach = on_attach,
      capabilities = caps,
   })
   vim.lsp.enable("ruff")
   vim.lsp.config("ruff", {
      on_attach = on_attach,
      capabilities = caps,
   })

   vim.lsp.enable("regal")
   vim.lsp.config("regal", {})

   vim.lsp.enable("ocamllsp")
   vim.lsp.config("ocamllsp", {})

   vim.lsp.enable("dartls")
   vim.lsp.config("dartls", {
      on_attach = on_attach,
      capabilities = caps,
   })

   vim.lsp.enable("rust_analyzer")
   vim.lsp.config("rust_analyzer", {
      on_init = function(client, _)
         client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
      end,
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
      settings = {
         ["rust-analyzer"] = {
            rustfmt = {
               extraArgs = { "+nightly" },
               rangeFormatting = {
                  enable = true,
               },
            },
         },
      },
   })
end

return M
