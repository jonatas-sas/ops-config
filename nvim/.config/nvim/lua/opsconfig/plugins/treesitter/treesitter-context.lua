local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Shows the current code context at the top of the window using Tree-sitter.
  --  Displays the function, class, or block you’re currently inside.
  --  Enhances code readability and navigation, especially in large files.
  --  Configurable with support for custom patterns, trimming, and styling.
  --  Repository: https://github.com/nvim-treesitter/nvim-treesitter-context
  'nvim-treesitter/nvim-treesitter-context',

  enabled = plugins.nvim_treesitter_context,

  config = function()
    require('treesitter-context').setup({
      enable = true,
      multiwindow = false,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = 'outer',
      mode = 'cursor',
      separator = nil,
      zindex = 20,
      on_attach = nil,
    })
  end,
}
