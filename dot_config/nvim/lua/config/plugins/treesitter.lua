return {
   -- Syntax awareness
   {
      "nvim-treesitter/nvim-treesitter",
      config = function()
         require("nvim-treesitter.configs").setup({
            ensure_installed = { "rust", "lua", "python", "query", "bash", "java" },
            sync_install = false,

            highlight = {
               enable = true,
            },
            textobjects = {
               swap = {
                  enable = true,
                  swap_next = {
                     ["<leader>a"] = "@parameter.inner",
                  },
                  swap_previous = {
                     ["<leader>A"] = "@parameter.inner",
                  },
               },
            },
         })
      end,
   },
   -- Syntax aware text objects
   "nvim-treesitter/nvim-treesitter-textobjects",
   -- debug help for treesitter
   "nvim-treesitter/playground",
}
