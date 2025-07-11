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
         },
      },
      cmd = "MindOpenMain",
      dependencies = "nvim-lua/plenary.nvim",
   },
   -- Colorscheme
   "sainnhe/gruvbox-material",
   -- fuzzy finding
   {
      "ibhagwan/fzf-lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
         require("fzf-lua").setup({})
         vim.keymap.set("n", "<leader>e", ":FzfLua files<CR>", { silent = true })
         vim.keymap.set("n", "<leader>b", ":FzfLua buffers<CR>", { silent = true })
         vim.keymap.set("n", "<leader>l", ":FzfLua lines<CR>", { silent = true })
         vim.keymap.set("n", "<leader>t", ":FzfLua lsp_workspace_symbols<CR>", { silent = true })
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
            pattern = {
               [[.*<(KEYWORDS)\s*:]],
               [[.*<(KEYWORDS)\s*!\(]],
            },
            keyword = "",
            after = "",
            comments_only = false,
         },
         keywords = {
            TODO = { alt = { "todo", "unimplemented" } },
         },
         -- merge_keywords = true,
         search = {
            pattern = [[\b(KEYWORDS)(:|!\()]],
         },
      },
   },
   {
      "rcarriga/nvim-notify",
      config = function()
         vim.notify = require("notify")
      end,
   },
   -- Show keybindings when first keys are pressed
   {
      "folke/which-key.nvim",
      config = function()
         vim.o.timeout = true
         vim.o.timeoutlen = 300
         require("which-key").setup({})
      end,
   },
   {
      "stevearc/aerial.nvim",
      config = function()
         require("aerial").setup({
            on_attach = function(bufnum)
               vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnum })
               vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnum })
            end,
         })
         vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>")
      end,
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
      },
   },
   {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = {}, -- this is equalent to setup({}) function
   },
   {
      "nacro90/numb.nvim",
      config = true,
   },
   {
      "kevinhwang91/nvim-ufo",
      dependencies = {
         "kevinhwang91/promise-async",
      },
      config = function()
         vim.o.foldcolumn = "0"
         vim.o.foldlevel = 99
         vim.o.foldlevelstart = 99
         vim.o.foldenable = true

         vim.keymap.set("n", "zR", require("ufo").openAllFolds)
         vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
         require("ufo").setup({
            close_fold_kinds_for_ft = {
               rust = { "imports" },
            },
            provider_selector = function(bufnr, filetype, buftype)
               return { "treesitter", "indent" }
            end,
         })
      end,
   },
   {
      "saecki/crates.nvim",
      tag = "stable",
      opts = {
         lsp = {
            enabled = true,
            on_attach = function(client, buffer)
               opts = { silent = true }
               crates = require("crates")
               vim.keymap.set("n", "<c-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
               vim.keymap.set({ "n", "x" }, "<leader>1", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
               vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
               vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts)
               vim.keymap.set("n", "<leader>cr", crates.open_repository, opts)
               vim.keymap.set("n", "<leader>cd", crates.open_documentation, opts)
            end,
            actions = true,
            completion = true,
            hover = true,
         },
      },
   },
}
