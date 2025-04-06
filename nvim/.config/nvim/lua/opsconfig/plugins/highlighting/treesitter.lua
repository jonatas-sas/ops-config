return {
  -- NOTE:  Fornece parsing avançado de código-fonte usando árvores sintáticas (Tree-sitter).
  --  Melhora realce de sintaxe, folds, indentação e análise estrutural do código.
  --  Suporte a múltiplas linguagens com instalação e atualização automática de parsers.
  --  Extensível, permitindo desenvolvimento de funcionalidades baseadas em árvore sintática.
  --  Repositório: https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',

  enabled = vim.g.opsconfig.plugins.nvim_treesitter,

  event = { 'BufReadPre', 'BufNewFile' },

  build = ':TSUpdate',

  dependencies = {
    -- NOTE:  Adiciona e fecha automaticamente tags HTML, JSX, Vue e similares no Neovim.
    --  Baseado no Tree-sitter para análise precisa da estrutura do código.
    --  Atualiza automaticamente as tags ao editar nomes ou estruturas aninhadas.
    --  Compatível com nvim-treesitter e fácil de configurar.
    --  Repositório: https://github.com/windwp/nvim-ts-autotag
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
  end,
}
