local actions = require("telescope.actions")
require("telescope").setup({
   defaults = {
      mappings = {
         i = {
            ["<esc>"] = actions.close,
         },
      },
   },
   pickers = {
      lsp_code_actions = {
         theme = "dropdown",
      },
   },
   extensions = {
      ["ui-select"] = {
         require("telescope.themes").get_dropdown({}),
      },
      fzf = {
         fuzzy = true,
         override_generic_sorter = true,
         override_file_sorter = true,
         case_mode = "smart_case",
      },
   },
})

require("telescope").load_extension("fzf")

-- local vimp = require "vimp"
-- Fuzzy open files - like :e
vim.keymap.set("n", "<leader>e", "<cmd>Telescope find_files theme=dropdown<CR>")
-- Fuzzy switch buffer - like :bn, bp etc
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers <CR>")
-- Fuzzy lines - vaguely following eclipse's Ctrl-L
vim.keymap.set("n", "<leader>l", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
-- Fuzzy type definitions - eclipse's ctrl-shift-T
vim.keymap.set(
   "n",
   "<leader>t",
   '<cmd>Telescope lsp_workspace_symbols symbols={"struct","enum","interface","typeparameter"}<CR>'
)
-- Fuzzy functions - limited to current buffer
vim.keymap.set("n", "<leader>o", "<cmd>Telescope lsp_document_symbols<CR>")
