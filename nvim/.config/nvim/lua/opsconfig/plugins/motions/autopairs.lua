return {
  -- NOTE:  Insere automaticamente pares de caracteres como parênteses e aspas no Neovim.
  --  Suporte a múltiplas linguagens com integração ao Treesitter.
  --  Funciona com completion plugins como nvim-cmp para fechamento inteligente.
  --  Personalizável, permitindo regras específicas para diferentes contextos.
  --  Repositório: https://github.com/windwp/nvim-autopairs
  'windwp/nvim-autopairs',

  enabled = vim.g.opsconfig.plugins.nvim_autopairs,

  event = { 'InsertEnter' },

  dependencies = {
    -- NOTE:  Autocompletar poderoso e extensível para Neovim.
    --  Suporte a múltiplas fontes, incluindo LSP, buffers e snippets.
    --  Integra-se com luasnip, nvim-autopairs e outros plugins.
    --  Altamente configurável, com mapeamentos e comportamento personalizável.
    --  Repositório: https://github.com/hrsh7th/nvim-cmp
    {
      'hrsh7th/nvim-cmp',
      enabled = vim.g.opsconfig.plugins.nvim_cmp,
    },

    -- NOTE:  Fornece parsing avançado de código-fonte usando árvores sintáticas (Tree-sitter).
    --  Melhora realce de sintaxe, folds, indentação e análise estrutural do código.
    --  Suporte a múltiplas linguagens com instalação e atualização automática de parsers.
    --  Extensível, permitindo desenvolvimento de funcionalidades baseadas em árvore sintática.
    --  Repositório: https://github.com/nvim-treesitter/nvim-treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      enabled = vim.g.opsconfig.plugins.nvim_treesitter,
    },
  },
  config = function()
    local autopairs = require('nvim-autopairs')

    local setup = {}

    if vim.g.opsconfig.plugins.nvim_treesitter then
      setup.check_ts = true
      setup.ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
        java = false,
      }
    end

    autopairs.setup(setup)

    if vim.g.opsconfig.plugins.nvim_cmp then
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      local cmp = require('cmp')

      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  end,
}
