local cmp = require("cmp")
local lspkind = require("lspkind")

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },
   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
   },
   mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
      ["<Down>"] = cmp.mapping.select_next_item(select_opts),
      ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
      ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
   },
   sources = {
      { name = "path" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "buffer", keyword_length = 5 },
   },
   formatting = {
      format = lspkind.cmp_format({
         with_text = true,
         menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
         },
      }),
   },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "buffer" },
   },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
   }),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig")["rust_analyzer"].setup({
   capabilities = capabilities,
})
