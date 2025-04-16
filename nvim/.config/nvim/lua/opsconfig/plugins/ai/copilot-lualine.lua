local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Displays GitHub Copilot status in Lualine.
  --  Indicates whether Copilot is active and running in Neovim.
  --  Helps visualize the AI status without leaving your workflow.
  --  Configurable, allowing customization of the display as needed.
  --  Repository: https://github.com/AndreM222/copilot-lualine
  'AndreM222/copilot-lualine',

  enabled = plugins.copilot_lualine,

  after = {
    'copilot.lua',
  },
}
