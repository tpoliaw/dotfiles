return {
   -- Syntax awareness
   {
      "nvim-treesitter/nvim-treesitter",
      build = function()
         vim.fn([[TSInstall<CR>]])
      end,
      config = function()
         require("nvim-treesitter.configs").setup({
            ensure_installed = { "rust", "lua", "python", "query", "java" },
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