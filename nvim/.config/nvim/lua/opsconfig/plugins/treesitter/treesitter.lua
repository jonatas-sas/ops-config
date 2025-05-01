local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Provides advanced source code parsing using syntax trees (Tree-sitter).
  --  Enhances syntax highlighting, folding, indentation, and structural code analysis.
  --  Supports multiple languages with automatic parser installation and updates.
  --  Extensible, allowing development of features based on syntax trees.
  --  Repository: https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',

  enabled = plugins.nvim_treesitter,

  event = { 'BufReadPre', 'BufNewFile' },

  build = ':TSUpdate',

  dependencies = {
    { 'windwp/nvim-ts-autotag', enabled = plugins.nvim_ts_autotag },
  },

  config = function()
    local treesitter = require('nvim-treesitter.configs')

    local available = {
      'bash',
      'c',
      'cmake',
      'comment',
      'css',
      'csv',
      'desktop',
      'dockerfile',
      'editorconfig',
      'git_config',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'gomod',
      'gosum',
      'gowork',
      'goctl',
      'gotmpl',
      'graphql',
      'html',
      'http',
      'ini',
      'java',
      'javadoc',
      'javascript',
      'jinja',
      'jq',
      'jsdoc',
      'json',
      'json5',
      'kotlin',
      'lua',
      'luadoc',
      'luap',
      'make',
      'markdown',
      'markdown_inline',
      'nginx',
      'perl',
      'php',
      'phpdoc',
      'prisma',
      'query',
      'regex',
      'robots',
      'scss',
      'sql',
      'svelte',
      'tsx',
      'twig',
      'typescript',
      'typespec',
      'vim',
      'vimdoc',
      'vue',
      'yaml',
    }

    treesitter.setup({
      modules = {},
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      fold = { enable = true },
      injection = { enable = true },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      ensure_installed = available,
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
