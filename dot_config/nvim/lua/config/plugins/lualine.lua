-- Status bar
return {
   "nvim-lualine/lualine.nvim",
   dependencies = "kyazdani42/nvim-web-devicons",
   opts = {
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
            "encoding", "fileformat"
         },
         lualine_y = { "diagnostics" },
         lualine_z = { "progress", "location" },
      },
   },
}
