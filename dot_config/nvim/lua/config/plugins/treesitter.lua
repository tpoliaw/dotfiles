return {
   -- Syntax awareness
   {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      branch = "main",
      build = ":TSUpdate",
      config = function()
         require("nvim-treesitter").install({
            "bash",
            "html",
            "java",
            "just",
            "lua",
            "markdown",
            "python",
            "rust",
            "toml",
            "yaml",
            "zsh",
         })
      end,
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
   {
      "mizlan/iswap.nvim",
      config = function()
         require("iswap").setup({
            move_cursor = true,
         })
         vim.keymap.set("n", "<leader>s", [[:ISwapWithRight<CR>]], { noremap = false, silent = true })
         vim.keymap.set("n", "<leader>S", [[:ISwapWithLeft<CR>]], { noremap = false, silent = true })
      end,
   },
}
