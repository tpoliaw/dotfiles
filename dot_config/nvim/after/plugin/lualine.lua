require("lualine").setup({
   theme = "gruvbox-material",
   options = {
      icons_enabled = true,
   },
   sections = {
      lualine_c = {
         { "filename", path = 1 },
      },
      lualine_x = {
         { "filetype", colored = true },
         "encoding",
      },
      lualine_y = { "diagnostics" },
      lualine_z = { "progress", "location" },
   },
})
