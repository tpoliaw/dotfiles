return {
   -- Surround text objects with quotes/brackets/etc
   {
      "kylechui/nvim-surround",
      config = true,
   },
   -- Let plugin actions be treated as single actions
   "tpope/vim-repeat",
   -- Lua based commenting
   {
      "numToStr/comment.nvim",
      opts = {
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
      opts = {
         ft_blocklist = { "diff" },
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
      opts = {
         edit = {
            data_extension = ".norg",
            data_header = "* %s",
         }
      },
      cmd = "MindOpenMain",
      dependencies = "nvim-lua/plenary.nvim",
   },
   -- Colorscheme
   "sainnhe/gruvbox-material",
   -- fuzzy finding
   {
      "junegunn/fzf.vim",
      dependencies = {
         "junegunn/fzf",
      },
      config = function()
         vim.keymap.set("n", "<leader>e", ":Files<CR>", { silent = true })
         vim.keymap.set("n", "<leader>b", ":Buffers<CR>", { silent = true })
      end,
   },
   {
      "folke/trouble.nvim",
     dependencies = "kyazdani42/nvim-web-devicons",
     config = true,
   },
   -- Highlight and markout TODO comments
   {
      "folke/todo-comments.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      opts = {
         -- Show todo comments in the sign column but don't highlight the text
         highlight = {
            keyword = "",
            after = "",
         },
      },
   },
   {
      "rcarriga/nvim-notify",
      config = function()
         vim.notify = require('notify')
      end
   },
   -- Show keybindings when first keys are pressed
   {
      "folke/which-key.nvim",
      config = function()
         vim.o.timeout = true
         vim.o.timeoutlen = 300
         require("which-key").setup({
         })
      end,
   },
   {
      "stevearc/aerial.nvim",
      config = function()
         require("aerial").setup({
            on_attach = function(bufnum)
               vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnum })
               vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnum })
            end
         })
         vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>")
      end
   },
   {
     "m4xshen/smartcolumn.nvim",
     opts = {
        colorcoumn = { 80 },
        scope = "window",
        disabled_filetypes = {},
        custom_colorcolumn = {
           gitcommit = { 72, 80 },
        },
     }
   },
}
