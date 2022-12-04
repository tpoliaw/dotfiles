M = {}
local filename = function()
   local name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
   return vim.fs.basename(name)
end

return {
   filename = filename,
}
