local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Utility library for Lua development in Neovim.
  --  Provides helpers for file I/O, async, paths, jobs, and more.
  --  Core dependency for many plugins like Telescope and nvim-lint.
  --  Simplifies plugin development with a unified and efficient API.
  --  Repository: https://github.com/nvim-lua/plenary.nvim
  'nvim-lua/plenary.nvim',

  enabled = plugins.plenary_nvim,
}
