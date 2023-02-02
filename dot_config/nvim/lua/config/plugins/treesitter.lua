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
      dependencies = {
         "nvim-neorg/neorg",
      },
   },
   -- Hop but by treesitter nodes
   {
      "mfussenegger/nvim-treehopper",
      config = function()
         vim.keymap.set("o", "m", [[:lua require("tsht").nodes()<CR>]], { noremap = false, silent = true })
         vim.keymap.set("x", "m", [[:lua require("tsht").nodes()<CR>]], { silent = true })
      end,
   },
   -- Syntax aware text objects
   "nvim-treesitter/nvim-treesitter-textobjects",
   -- debug help for treesitter
   "nvim-treesitter/playground",
}
