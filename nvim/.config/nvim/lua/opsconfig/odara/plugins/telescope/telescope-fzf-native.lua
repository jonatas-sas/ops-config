local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Telescope extension for ultra-fast fuzzy finding using native FZF.
  --  Written in C for high-performance fuzzy matching.
  --  Supports smart sorting and fast result previewing.
  --  Requires compilation but significantly boosts search speed.
  --  Repository: https://github.com/nvim-telescope/telescope-fzf-native.nvim
  'nvim-telescope/telescope-fzf-native.nvim',

  build = 'make',

  cond = function()
    return vim.fn.executable('make') == 1
  end,

  enabled = plugins.telescope_dap_nvim and plugins.nvim_dap and plugins.telescope_nvim,

  dependencies = {
    { 'nvim-telescope/telescope.nvim', enabled = true },
  },

  config = function()
    local telescope = require('telescope')

    telescope.load_extension('fzf')
  end,
}
