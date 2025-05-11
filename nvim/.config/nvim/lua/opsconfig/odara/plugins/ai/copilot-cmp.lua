local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Integrates GitHub Copilot with nvim-cmp.
  --  Allows using Copilot suggestions as an autocomplete source.
  --  Improves the coding experience with more natural and fluid predictions.
  --  Fully configurable, with support for priorities and fine-grained adjustments.
  --  Repository: https://github.com/zbirenbaum/copilot-cmp
  'zbirenbaum/copilot-cmp',

  enabled = plugins.copilot_cmp,

  after = {
    'copilot.lua',
  },

  config = function()
    require('copilot_cmp').setup()
  end,
}
