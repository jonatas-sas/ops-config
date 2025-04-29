return {
  -- NOTE:  Provides advanced source code parsing using syntax trees (Tree-sitter).
  --  Enhances syntax highlighting, folding, indentation, and structural code analysis.
  --  Supports multiple languages with automatic parser installation and updates.
  --  Extensible, allowing development of features based on syntax trees.
  --  Repository: https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',

  enabled = vim.g.opsconfig.plugins.nvim_treesitter,

  event = { 'BufReadPre', 'BufNewFile' },

  build = ':TSUpdate',

  dependencies = {
    -- NOTE:  Automatically adds and closes HTML, JSX, Vue, and similar tags in Neovim.
    --  Based on Tree-sitter for accurate code structure analysis.
    --  Automatically updates tags when editing names or nested structures.
    --  Compatible with nvim-treesitter and easy to configure.
    --  Repository: https://github.com/windwp/nvim-ts-autotag
    {
      'windwp/nvim-ts-autotag',
      enabled = true,
    },
  },

  config = function()
    local treesitter = require('nvim-treesitter.configs')

    treesitter.setup({
      modules = {},

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
      },

      autotag = {
        enable = true,
      },

      fold = {
        enable = true,
      },

      injection = {
        enable = true,
      },

      sync_install = false,

      auto_install = true,

      ignore_install = {},

      ensure_installed = {
        'json',
        'javascript',
        'typescript',
        'nginx',
        'tsx',
        'yaml',
        'html',
        'http',
        'css',
        'prisma',
        'markdown',
        'markdown_inline',
        'svelte',
        'graphql',
        'bash',
        'lua',
        'vim',
        'dockerfile',
        'gitignore',
        'query',
        'vimdoc',
        'c',
        'regex',
        'ini',
        'php',
        'gotmpl',
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    })

    vim.treesitter.language.register('php', 'phtml')
    vim.treesitter.language.register('php', 'phpconfig')
    vim.treesitter.language.register('php', 'yiimigrations')
  end,
}
