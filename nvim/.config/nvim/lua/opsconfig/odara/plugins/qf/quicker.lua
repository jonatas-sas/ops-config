local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE: ⚡ Plugin to define and run quick commands directly from a Neovim buffer.
  --  Lets you create command lists inside files and execute them easily.
  --  Great for scripting, prototyping, and repetitive task automation.
  --  Configurable with support for custom filetypes and execution strategies.
  --  Repository: https://github.com/stevearc/quicker.nvim
  'stevearc/quicker.nvim',

  enabled = plugins.quicker_nvim,

  event = 'FileType qf',

  opts = {},
}
