local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Allows loading local Neovim configuration files per project.
  --  Supports `.nvim.lua` and `.nvimrc` files with optional user confirmation.
  --  Useful for project-specific settings without affecting global config.
  --  Repository: https://github.com/klen/nvim-config-local
  'klen/nvim-config-local',

  enabled = plugins.nvim_config_local,
}
