return {
  -- NOTE:  Plugin para comentar e descomentar linhas ou blocos no Neovim de forma fácil.
  --  Suporte a múltiplas linguagens com detecção automática de sintaxe.
  --  Integra-se com motions e operadores do Neovim para maior flexibilidade.
  --  Configuração simples e suporte a atalhos personalizados.
  --  Repositório: https://github.com/numToStr/Comment.nvim
  'numToStr/Comment.nvim',

  enabled = vim.g.opsconfig.plugins.comment_nvim,

  event = {
    'BufReadPre',
    'BufNewFile',
  },

  dependencies = {
    -- NOTE:  Define automaticamente o tipo de comentário correto com base no contexto do Tree-sitter.
    --  Funciona em arquivos com múltiplas linguagens, como HTML, Vue e JavaScript.
    --  Integra-se com plugins como Comment.nvim para uma experiência aprimorada.
    --  Configuração simples e compatível com nvim-treesitter.
    --  Repositório: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      enabled = vim.g.opsconfig.plugins.nvim_ts_context_commentstring,
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
    local comment = require('Comment')
    local setup = {
      padding = true,
      sticky = true,
      ignore = nil,

      toggler = {
        line = 'gcc',
        block = 'gbc',
      },

      opleader = {
        line = 'gc',
        block = 'gb',
      },

      extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
      },

      mappings = {
        basic = true,
        extra = true,
      },

      pre_hook = nil,
      post_hook = nil,
    }

    if vim.g.opsconfig.plugins.nvim_ts_context_commentstring and vim.g.opsconfig.plugins.nvim_treesitter then
      local ts_context_commentstring = require('ts_context_commentstring.integrations.comment_nvim')

      setup.pre_hook = ts_context_commentstring.create_pre_hook()
    end

    comment.setup(setup)
  end,
}
