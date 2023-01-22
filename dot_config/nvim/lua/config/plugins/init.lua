return {
   -- Surround text objects with quotes/brackets/etc
   "tpope/vim-surround",
   -- Let plugin actions be treated as single actions
   "tpope/vim-repeat",
   -- Lua based commenting
   {
      "numToStr/comment.nvim",
      config = {
         mappings = {
            basic = true,
            extra = true,
            extended = true,
         },
         ignore = "^$", -- don't comment empty lines
      },
   },
   -- Remove trailing whitespace
   {
      "cappyzawa/trim.nvim",
      config = {
         disable = { "diff" },
         patterns = {
            -- default patterns remove duplicate newlines
            [[%s/\s\+$//e]],
         },
      },
   },
   -- Jump around text
   {
      "phaazon/hop.nvim",
      config = true,
      init = function()
         vim.keymap.set("n", "<leader>f", require("hop").hint_char1, { silent = true })
      end,
   },
   -- -- Highlight jump characters for f/F/t/T
   "unblevable/quick-scope",
   -- Macroeditor in splitscreen
   "dohsimpson/vim-macroeditor",
   -- Visualise history and jump between versions
   {
      "mbbill/undotree",
      config = function()
         vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
      end,
   },
   -- Underline instances of the word under the cursor
   "itchyny/vim-cursorword",
   -- Convert between single and multiline constructs
   {
      "AndrewRadev/splitjoin.vim",
      init = function()
         vim.g.splitjoin_split_mapping = ""
         vim.g.splitjoin_join_mapping = ""
      end,
      config = function()
         vim.keymap.set("n", "<leader>j", "<plug>SplitjoinSplit", { silent = true })
         vim.keymap.set("n", "<leader>k", "<plug>SplitjoinJoin", { silent = true })
      end,
   },
   -- Outliner/tree
   {
      "phaazon/mind.nvim",
      config = true,
      cmd = "MindOpenMain",
      dependencies = "nvim-lua/plenary.nvim",
   },
   -- Show registers after pressing ", @ or Ctrl-r
   "junegunn/vim-peekaboo",
   -- Colorscheme
   "sainnhe/gruvbox-material",
   -- fuzzy finding
   {
      "junegunn/fzf.vim",
      dependencies = {
         {
            "junegunn/fzf",
            build = "<cmd>fzf#install()<CR>",
         },
      },
      config = function()
         vim.keymap.set("n", "<leader>e", ":Files<CR>", { silent = true })
         vim.keymap.set("n", "<leader>b", ":Buffers<CR>", { silent = true })
         -- vim.keymap.set("n", "<leader>a", ":Rg<CR>", { silent = true })
      end,
   },
   {
      "folke/trouble.nvim",
     requires = "kyazdani42/nvim-web-devicons",
     config = true,
   },
   {
      "folke/todo-comments.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      config = true,
   },
   {
      "rcarriga/nvim-notify",
      config = function()
         vim.notify = require('notify')
      end
   }
}
