local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Helper plugin for working with Hugo static sites in Vim/Neovim.
  --  Provides commands to create, edit, and manage Hugo content and taxonomies.
  --  Speeds up workflow for writing and organizing Markdown files in Hugo projects.
  --  Lightweight and easy to integrate into existing Neovim setups.
  --  Repository: https://github.com/robertbasic/vim-hugo-helper
  'robertbasic/vim-hugo-helper',

  ft = {
    'markdown',
    'md',
  },

  enabled = plugins.vim_hugo_helper,
}
