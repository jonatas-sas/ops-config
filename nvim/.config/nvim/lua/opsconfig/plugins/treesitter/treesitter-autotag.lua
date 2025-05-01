local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Automatically adds and closes HTML, JSX, Vue, and similar tags in Neovim.
  --  Based on Tree-sitter for accurate code structure analysis.
  --  Automatically updates tags when editing names or nested structures.
  --  Compatible with nvim-treesitter and easy to configure.
  --  Repository: https://github.com/windwp/nvim-ts-autotag
  'windwp/nvim-ts-autotag',

  enabled = plugins.nvim_ts_autotag,
}
