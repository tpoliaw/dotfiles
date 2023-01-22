return {
   "nvim-neorg/neorg",
   build = ":Neorg sync-parsers",
   ft = "norg",
   opts = {
      load = {
         ["core.defaults"] = {}, -- Loads default behaviour
         ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
         ["core.norg.dirman"] = {},
         ["core.norg.completion"] = {
            config = {
               engine = "nvim-cmp",
            },
         },
         ["core.presenter"] = {
            config = {
               zen_mode = "zen-mode",
            },
         },
         ["core.export.markdown"] = {},
         ["core.export"] = {},
      },
   },
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "folke/zen-mode.nvim",
   },
}
