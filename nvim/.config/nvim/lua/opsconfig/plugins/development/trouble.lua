local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Displays diagnostics, quickfix, LSP references, and TODO comments in a structured list.
  --  Intuitive interface for quickly navigating between errors and warnings.
  -- ⚗ Integrates with LSP, Telescope, todo-comments, and other plugins.
  --  Supports keybindings for toggling, filtering, and navigating results easily.
  --  Repository: https://github.com/folke/trouble.nvim
  'folke/trouble.nvim',

  enabled = plugins.trouble_nvim
    and plugins.nvim_web_devicons
    and plugins.todo_comments_nvim
    and plugins.telescope_nvim,

  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
      enabled = true,
    },
    {
      'folke/todo-comments.nvim',
      enabled = true,
    },
    {
      'nvim-telescope/telescope.nvim',
      enabled = true,
    },
  },

  cmd = 'Trouble',

  opts = {},

  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
}
