local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Telescope extension for integrating LuaSnip with Neovim.
  --  Enables searching and inserting LuaSnip snippets through the Telescope UI.
  --  Makes it easier to preview and insert code snippets interactively.
  --  Repository: https://github.com/benfowler/telescope-luasnip.nvim
  'benfowler/telescope-luasnip.nvim',

  enabled = plugins.telescope_luasnip_nvim and plugins.luasnip and plugins.telescope_nvim,

  dependencies = {
    { 'L3MON4D3/LuaSnip', enabled = true },
    { 'nvim-telescope/telescope.nvim', enabled = true },
  },

  config = function()
    local telescope = require('telescope')

    telescope.load_extension('luasnip')
  end,
}
