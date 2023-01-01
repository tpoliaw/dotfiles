-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Show numbers -- relative numbers are more useful than absolute
vim.opt.number = true
vim.opt.relativenumber = true

-- Move to the cursor position last time the buffer was closed
local restore_cursor = function()
   if vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd([[normal! g`"]])
   end
end

local restore_group = vim.api.nvim_create_augroup("restore_group", {})
vim.api.nvim_create_autocmd("BufWinEnter", {
   group = restore_group,
   callback = restore_cursor,
})

-- Don't wrap long lines
vim.opt.wrap = false
-- Set width for autoformatting text. Mainly useful for reflowing comments
-- vim.opt.textwidth = 72
-- Don't automatically insert comment characters when starting a new line after a comment
vim.opt.fo:remove({ "o" })

-- Don't use the mouse for anything
vim.opt.mouse = ""

-- Remember changes from last time file was edited
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~") .. "/.local/share/nvim/undo"

-- Keep the cursor off the top and bottom of screen
vim.opt.scrolloff = 4
-- And keep search results centred
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })

-- Use sane defaults for searching
vim.opt.ignorecase = true -- match everything
vim.opt.smartcase = true -- unless any character is uppercase
vim.opt.incsearch = true -- update search before pressing enter
vim.opt.hlsearch = true -- highlight search results
-- but easily remove highlighting
vim.keymap.set("n", "<leader><leader>", "<cmd>set hlsearch!<CR>", { noremap = true, silent = true })
-- Show leading and trailing whitespace
vim.opt.list = true
vim.opt.listchars = { tab = "|~>", trail = "·" }

-- Sane defaults for tabs
vim.opt.autoindent = true
vim.opt.smartindent = true
-- Indent with 4 spaces + show tabs as four spaces wide
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Add shortcut to make terminal (slightly more) copy friendly
vim.keymap.set("n", "<F7>", "<cmd> set nu! rnu! list!<CR>", { silent = true })
-- And one to make pasting behave
vim.opt.pastetoggle = "<F2>"

-- Highlight the current line
vim.opt.cursorline = true
-- and highlight the 80th column
vim.opt.colorcolumn = "80" -- string because it can be multiple numbers

-- Keep cursor position constant when using arrow keys
vim.keymap.set("n", "<Up>", "<C-y>k", { silent = true })
vim.keymap.set("n", "<Down>", "<C-e>j", { silent = true })

-- Switch buffers easily
vim.keymap.set("n", "<leader>9", "<cmd>bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>0", "<cmd>bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>-", "<cmd>b#<CR>", { silent = true })
-- Close current buffer and switch to previous
vim.keymap.set("n", "<leader><BS>", "<cmd>bp|bd#<CR>", { silent = true })
-- Allow buffers to be hidden without being saved
vim.opt.hidden = true

-- Copy to the system clipboard using <leader>y
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("x", "<leader>y", "\"+y")

-- Delete text to blackhole register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("x", "<leader>d", "\"_d")

-- Replace text without overwriting last yanked text
vim.keymap.set("n", "<leader>c", "\"_c")
vim.keymap.set("x", "<leader>c", "\"_c")

-- Move selected lines and automatically indent
vim.keymap.set("x", "<M-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "<M-Down>", ":m '>+1<CR>gv=gv")

-- Show the partial command in progress
vim.opt.showcmd = true

-- Show completion options for command mode - longest:full completes
-- only to the longest substring, then shows the list of options
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- Options for autocomplete in insert mode
-- menuone - show the popup even when there is only one option
-- noinsert - don't insert the first match until selected
-- noselect - don't select the first match automatically
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

-- Make themes expect a dark background
vim.opt.background = "dark"

-- Adjust highlighting for common non-theme things
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 8 })
vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = 8 })

vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_palette = "original"
vim.cmd([[colorscheme gruvbox-material]])

-- Load all plugins from lua/plugins.lua
-- require("plugins")

require("config.lazy")
