require("Comment").setup({
   mappings = {
      basic = true,
      extra = true,
      extended = true,
   },
   ignore = "^$", -- don't comment empty lines
})

local ft = require("Comment.ft")
ft.set("rust", { "// %s", "/* %s */" }) -- override defaults to add space between // and string
