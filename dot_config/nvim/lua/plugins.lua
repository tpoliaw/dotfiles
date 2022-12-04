vim.cmd([[packadd paq-nvim]])

-- Option Type
-- as       string      Name to use for the package locally
-- branch   string      Branch of the repository
-- opt      boolean     Optional packages are not loaded on startup
-- pin      boolean     Pinned packages are not updated
-- run      string      Shell command to run after install/update
-- run      function    Lua function to run after install/update
-- url      string      URL of the remote repository, useful for non-GitHub repos

-- Some day I'll get this to be automatic but for now it's not needed
-- often enough to be worth it. To install paq:
-- git clone --depth=1 https://github.com/savq/paq-nvim.git \
-- "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

require("paq")({
   -- Make paq manage itself
   "savq/paq-nvim",
   -- Surround text objects with quotes/brackets/etc
   "tpope/vim-surround",
   -- Let plugin actions be treated as single actions
   "tpope/vim-repeat",
   -- Lua based commenting
   "numToStr/comment.nvim",
   -- Remove trailing whitespace
   "cappyzawa/trim.nvim",
   -- Jump around text
   "phaazon/hop.nvim",
   -- -- Highlight jump characters for f/F/t/T
   -- "unblevable/quick-scope",
   -- Macroeditor in splitscreen
   "dohsimpson/vim-macroeditor",
   -- Underline instances of the word under the cursor
   "itchyny/vim-cursorword",
   -- Dependency for lualine
   "kyazdani42/nvim-web-devicons",
   -- Status bar
   "nvim-lualine/lualine.nvim",
   -- Convert between single and multiline constructs
   "AndrewRadev/splitjoin.vim",

   -- Outliner/tree
   "phaazon/mind.nvim",

   -- Syntax awareness
   {
      "nvim-treesitter/nvim-treesitter",
      run = function()
         vim.cmd(":TSUpdate<CR>")
      end,
   },
   -- Syntax aware text objects
   "nvim-treesitter/nvim-treesitter-textobjects",
   -- debug help for treesitter
   "nvim-treesitter/playground",

   -- Auto-complete for all the things
   "hrsh7th/cmp-nvim-lsp", -- complete lsp suggestions
   "hrsh7th/cmp-nvim-lua", -- complete neovim lua api
   "hrsh7th/cmp-buffer", -- suggestions based on buffer contents
   "hrsh7th/cmp-path", -- complete filesystem paths
   "hrsh7th/cmp-cmdline", -- complete nvim commands
   "hrsh7th/nvim-cmp", -- Main driver for offering suggestions
   "saadparwaiz1/cmp_luasnip", -- Suggest snippets
   "onsails/lspkind.nvim", -- Autocomplete menu details

   -- Snippets for LSP and non-LSP things
   "L3MON4D3/LuaSnip",
   -- Colorscheme
   "sainnhe/gruvbox-material",
   -- LSP support for code-actions, jump to definition etc
   "neovim/nvim-lspconfig",
   -- LSP support for Rust specific stuff
   "simrat39/rust-tools.nvim",
   -- Fuzzy finding for everything
   "nvim-telescope/telescope.nvim",
   -- Use native fzf implementation for telescope
   { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
   -- Dependency of telescope
   "nvim-lua/plenary.nvim",
})
