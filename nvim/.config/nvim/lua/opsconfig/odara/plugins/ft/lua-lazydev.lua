return {
  -- NOTE:  Automatically configures Lua Language Server (LuaLS) for editing Neovim settings.
  --  Dynamically updates workspace libraries based on required modules.
  --  Integrates with nvim-cmp and other completion sources for `require` statements.
  --  Repository: https://github.com/folke/lazydev.nvim
  'folke/lazydev.nvim',

  enabled = vim.g.opsconfig.plugins.lazydev_nvim,

  ft = 'lua',

  opts = {
    library = {
      {
        path = '${3rd}/luv/library',
        words = {
          'vim%.uv',
        },
      },
      {
        path = 'lazy.nvim',
        words = {
          'LazyVim',
        },
      },
    },
  },
}
