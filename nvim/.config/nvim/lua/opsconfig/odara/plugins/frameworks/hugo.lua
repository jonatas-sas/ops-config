local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Vim/Neovim plugin for enhanced Hugo static site integration.
  --  Adds commands for creating posts, managing archetypes, and running Hugo.
  --  Streamlines content generation and preview for Hugo-based blogs and sites.
  --  Minimal and extensible, designed to fit into existing workflows.
  --  Repository: https://github.com/phelipetls/vim-hugo
  'phelipetls/vim-hugo',

  enabled = plugins.vim_hugo,
}
