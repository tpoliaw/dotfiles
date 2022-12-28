local M = {
   "L3MON4D3/LuaSnip",
   dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
   local ls = require("luasnip")
   local types = require("luasnip.util.types")

   ls.config.set_config({
      history = true, -- Allow re-entry into snippet
      updateevents = "TextChanged,TextChangedI", -- Update other parts of snippets when entering text
      enable_autosnippets = true,
      ext_opts = {
         [types.choiceNode] = {
            active = {
               virt_text = { { "<-", "Error" } },
            },
         },
      },
   })

   ls.add_snippets("rust", {
      ls.parser.parse_snippet(
         "pfr",
         [[pub fn ${1:name}(${2}) -> Result<${3}, ${4}> {
    ${0}
}]]
      ),
      ls.parser.parse_snippet(
         "main",
         [[pub fn main() {
    ${0}
}]]
      ),
   })

   ls.add_snippets("java", {
      ls.parser.parse_snippet(
         "psvm",
         [[public static void main(String[] args) {
    ${0}
}]]
      ),
      ls.parser.parse_snippet("sysout", "System.out.println($1);$0"),
      ls.parser.parse_snippet("syserr", "System.err.println($1);$0"),
      ls.parser.parse_snippet("lde", 'logger.debug("$1", $2);$0'),
   })

   vim.keymap.set({ "i", "s" }, "<c-k>", function()
      if ls.expand_or_jumpable() then
         ls.expand_or_jump()
      end
   end, { silent = true })

   vim.keymap.set({ "i", "s" }, "<c-h>", function()
      if ls.jumpable(-1) then
         ls.jump(-1)
      end
   end, { silent = true })

   vim.keymap.set("i", "<c-l>", function()
      if ls.choice_active() then
         ls.change_choice(1)
      end
   end)

   require("luasnip.loaders.from_snipmate").lazy_load()
   require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
end

return M
