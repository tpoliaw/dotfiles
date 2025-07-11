local ls = require("luasnip")

local utils = require("snip_utils")

ls.add_snippets("all", {
   ls.parser.parse_snippet("dbg", "print(f\"{$1=}\")$0"),
   ls.parser.parse_snippet("ifmain", "if __name__ == \"__main__\":\n    $0"),
})
