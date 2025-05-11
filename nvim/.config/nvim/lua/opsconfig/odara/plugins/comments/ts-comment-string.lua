local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Automatically sets the correct comment string based on Tree-sitter context.
  --  Works seamlessly with mixed-language files like HTML, Vue, and JavaScript.
  --  Integrates with plugins like Comment.nvim for an enhanced commenting experience.
  --  Easy to configure and fully compatible with nvim-treesitter.
  --  Repository: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  'JoosepAlviste/nvim-ts-context-commentstring',

  enabled = plugins.nvim_ts_context_commentstring and plugins.nvim_treesitter,

  event = {
    'BufReadPre',
    'BufNewFile',
  },

  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', enabled = true },
  },
}
