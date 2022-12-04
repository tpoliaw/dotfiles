local ls = require("luasnip")

local utils = require("snip_utils")

ls.add_snippets("all", {
   ls.s({ trig = "date" }, {
      f(function()
         return string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), os.date())
      end, {}),
   }),
   ls.s({ trig = "current" }, {
      ls.function_node(function()
         return utils.filename()
      end),
   }),
   ls.parser.parse_snippet("another", "-- this was expanded"),
})
