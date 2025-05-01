local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Replaces `vim.ui.select` with Telescope-powered interface in Neovim.
  --  Leverages Telescope's UI for interactive selection menus.
  --  Enhances navigation and usability in prompts and dialogs.
  --  Lightweight, easy to configure, and compatible with other plugins.
  --  Repository: https://github.com/nvim-telescope/telescope-ui-select.nvim
  'nvim-telescope/telescope-ui-select.nvim',

  enabled = plugins.telescope_ui_select_nvim and plugins.telescope_nvim,

  dependencies = {
    { 'nvim-telescope/telescope.nvim', enabled = true },
  },

  config = function()
    local telescope = require('telescope')

    telescope.load_extension('ui-select')
  end,
}
