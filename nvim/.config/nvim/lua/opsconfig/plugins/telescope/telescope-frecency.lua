local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Frecency-based file sorting extension for Telescope.
  --  Combines frequency and recency to prioritize file search results.
  --  Integrates with sqlite or external databases for tracking usage.
  --  Customizable workspace support and filtering options.
  --  Repository: https://github.com/nvim-telescope/telescope-frecency.nvim
  'nvim-telescope/telescope-frecency.nvim',

  enabled = plugins.telescope_frecency_nvim and plugins.telescope_nvim,

  dependencies = {
    { 'nvim-telescope/telescope.nvim', enabled = true },
  },

  config = function()
    local telescope = require('telescope')

    telescope.load_extension('frecency')
  end,
}
