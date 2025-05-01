local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Integrates DAP (Debug Adapter Protocol) with Telescope.
  --  Enables quick navigation through breakpoints, frames, threads, and variables.
  --  Improves debugging workflow with fast and efficient fuzzy search.
  --  Configurable with support for filters and custom keybindings.
  --  Repository: https://github.com/nvim-telescope/telescope-dap.nvim
  'nvim-telescope/telescope-dap.nvim',

  enabled = plugins.telescope_dap_nvim and plugins.nvim_dap and plugins.telescope_nvim,

  dependencies = {
    { 'mfussenegger/nvim-dap', enabled = true },
    { 'nvim-telescope/telescope.nvim', enabled = true },
  },

  config = function()
    local telescope = require('telescope')

    telescope.load_extension('dap')
  end,
}
