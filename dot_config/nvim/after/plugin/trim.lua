require("trim").setup({
   disable = { "diff" },
   patterns = {
      -- default patterns remove duplicate newlines
      [[%s/\s\+$//e]],
   },
})
