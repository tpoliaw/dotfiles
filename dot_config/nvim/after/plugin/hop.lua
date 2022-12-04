local hop = require("hop")
local hint = require("hop.hint")
hop.setup()

vim.keymap.set("n", "<leader>f", hop.hint_char2, { silent = true })
