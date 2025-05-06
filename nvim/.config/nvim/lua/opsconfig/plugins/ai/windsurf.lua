local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Free, ultrafast AI code completion plugin for Vim and Neovim.
  --  Provides real-time, multi-line suggestions based on code context and comments.
  --  Works across multiple languages and integrates seamlessly with existing workflows.
  --  Easy setup with customizable keybindings and configuration options.
  --  Repository: https://github.com/Exafunction/windsurf.vim
  'Exafunction/windsurf.vim',

  enabled = plugins.windsurf_vim,

  config = function()
    -- vim.g.codeium_filetypes_disabled_by_default = true

    vim.g.codeium_filetypes = {
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
    }
  end,
}
