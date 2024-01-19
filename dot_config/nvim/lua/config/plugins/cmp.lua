local M = {
   "hrsh7th/nvim-cmp", -- Main driver for offering suggestions
   dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- complete lsp suggestions
      "hrsh7th/cmp-nvim-lua", -- complete neovim lua api
      "hrsh7th/cmp-buffer", -- suggestions based on buffer contents
      "hrsh7th/cmp-path", -- complete filesystem paths
      "hrsh7th/cmp-cmdline", -- complete nvim commands
      "saadparwaiz1/cmp_luasnip", -- Suggest snippets
   },
}

function M.config()
   local cmp = require("cmp")
   -- When scrolling through options, update the buffer with the current option
   local select_opts = { behavior = cmp.SelectBehavior.Insert }

   cmp.setup({
      completion = {
         -- menu: use a popup menu to display options
         -- menuone: still use a popup if there's only one option
         -- noinsert: don't automatically insert an option unless it's selected
         -- noselect: Don't automatically select an option
         completeopt = "menu,menuone,noinsert,noselect",
      },
      snippet = {
         expand = function(args)
            require("luasnip").lsp_expand(args.body)
         end,
      },
      window = {
         completion = cmp.config.window.bordered(),
         documentation = cmp.config.disable,
      },
      mapping = cmp.mapping.preset.insert({
         -- 'complete' is to start completion, no to complete selection
         ["<C-Space>"] = cmp.mapping.complete(),
         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
         ["<C-f>"] = cmp.mapping.scroll_docs(4),
         ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
         ["<Down>"] = cmp.mapping.select_next_item(select_opts),
         ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
         ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
         ["<C-e>"] = cmp.mapping.abort(),

         -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
         ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
         { name = "nvim_lsp" },
         { name = "nvim_lua" },
         { name = "luasnip" },
         { name = "buffer", keyword_length = 5 },
         { name = "path" },
         { name = "emoji" },
         { name = "neorg" },
      }),
      formatting = {
         format = require("config.plugins.lsp.kind").cmp_format(),
      },
      experimental = {
         ghost_text = {
            hl_group = "LspCodeLens",
         },
      },
   })
   -- autopairs integration relies on implicit requirement
   local cmp_autopairs = require("nvim-autopairs.completion.cmp")
   cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
   cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
         { name = "path" },
         { name = "cmdline" },
      },
   })

   cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
         { name = "buffer" },
      },
   })
end

return M
