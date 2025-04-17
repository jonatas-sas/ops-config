local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Advanced GitHub Copilot configuration for Neovim.
  --  Provides granular control over Copilot's behavior and keybindings.
  --  Allows enabling/disabling suggestions per buffer or insert mode.
  --  Integrates with plugins like nvim-cmp for a customized experience.
  --  Repository: https://github.com/zbirenbaum/copilot.lua
  'zbirenbaum/copilot.lua',

  enabled = plugins.copilot_lua and plugins.copilot_lualine,

  lazy = false,

  cmd = 'Copilot',

  event = 'InsertEnter',

  dependencies = {
    { 'zbirenbaum/copilot-cmp', enabled = plugins.copilot_cmp },
    { 'AndreM222/copilot-lualine', enabled = true },
  },

  config = function()
    local copilot = require('copilot')

    copilot.setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<Tab>',
          next = '<C-l>',
          prev = '<C-h>',
          dismiss = '<C-]>',
        },
      },

      panel = {
        enabled = true,
      },

      filetypes = {
        yaml = false,
        json = false,
        toml = false,
        markdown = false,
        help = false,
        nerdtree = false,
        NvimTree = false,
        telescope = false,
        TelescopePrompt = false,
        fzf = false,
        gitcommit = true,
        gitrebase = true,
      },
    })
  end,
}
