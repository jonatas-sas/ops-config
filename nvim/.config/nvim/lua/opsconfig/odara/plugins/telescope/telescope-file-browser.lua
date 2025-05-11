local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  File browser extension for Telescope in Neovim.
  --  Allows navigating, creating, renaming, and deleting files and directories.
  --  Integrates seamlessly with Telescope’s fuzzy finding and preview features.
  --  Configurable with custom keybindings and layout options.
  --  Repository: https://github.com/nvim-telescope/telescope-file-browser.nvim
  'nvim-telescope/telescope-file-browser.nvim',

  enabled = plugins.telescope_file_browser_nvim and plugins.telescope_nvim,

  dependencies = {
    { 'nvim-telescope/telescope.nvim', enabled = true },
  },

  config = function()
    local telescope = require('telescope')

    telescope.load_extension('file_browser')
  end,
}
