local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Full-featured fuzzy finder built with Lua and fzf for Neovim.
  --  Provides high-performance, async searching with a customizable UI.
  --  Supports files, buffers, git, LSP, grep, and more out of the box.
  --  Highly extensible with rich theming and keybinding options.
  --  Repository: https://github.com/ibhagwan/fzf-lua
  'ibhagwan/fzf-lua',

  enabled = plugins.fzf_lua and plugins.nvim_web_devicons,

  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = true },
  },

  opts = {},
}
