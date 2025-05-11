local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Easy commenting plugin for Neovim supporting line and block comments.
  --  Supports multiple languages with automatic syntax detection.
  --  Integrates with Neovim motions and operators for flexible usage.
  --  Simple setup with customizable keybindings and options.
  --  Repository: https://github.com/numToStr/Comment.nvim
  'numToStr/Comment.nvim',

  enabled = plugins.comment_nvim and plugins.nvim_ts_context_commentstring,

  event = {
    'BufReadPre',
    'BufNewFile',
  },

  dependencies = {
    { 'JoosepAlviste/nvim-ts-context-commentstring', enabled = true },
  },

  config = function()
    local comment = require('Comment')
    local setup = {
      padding = true,
      sticky = true,
      ignore = nil,

      toggler = {
        line = 'gcc',
        block = 'gbc',
      },

      opleader = {
        line = 'gc',
        block = 'gb',
      },

      extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
      },

      mappings = {
        basic = true,
        extra = true,
      },

      pre_hook = nil,
      post_hook = nil,
    }

    local ts_context_commentstring = require('ts_context_commentstring.integrations.comment_nvim')

    setup.pre_hook = ts_context_commentstring.create_pre_hook()

    comment.setup(setup)
  end,
}
