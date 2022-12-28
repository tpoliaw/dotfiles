local M = {
   "simrat39/rust-tools.nvim",
}

function M.setup(options)
   local opts = {
      tools = {
         autoSetHints = true,
         hover_with_actions = true,
      },
      inlay_hints = {
         only_current_line = false,
         -- only_current_line_autocmd = "CursonHold",
         -- highlight = "LspCodeLens",
      },
      executor = require("rust-tools/executors").termopen,
      hover_actions = {
         auto_focus = true,
      },
      server = options,
   }
   require("rust-tools").setup(opts)
end

return M
