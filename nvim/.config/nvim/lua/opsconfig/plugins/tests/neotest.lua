return {
  -- NOTE:   Framework de testes modular para Neovim.
  --   Suporte a múltiplas linguagens e frameworks de teste.
  --   Integra-se com Treesitter, LSP e interfaces personalizadas.
  --   Permite execução assíncrona e exibição detalhada de resultados.
  --   Repositório: https://github.com/nvim-neotest/neotest
  'nvim-neotest/neotest',

  enabled = vim.g.opsconfig.plugins.neotest and vim.g.opsconfig.plugins.plenary and vim.g.opsconfig.plugins.treesitter,

  dependencies = {
    {
      -- NOTE:   Adaptador do Neotest para testes em Go.
      --   Permite executar, depurar e visualizar testes de Go diretamente no Neovim.
      --   Integra-se com `go test` e suporta execução assíncrona.
      --   Compatível com `neotest`, oferecendo feedback detalhado sobre testes.
      --   Repositório: https://github.com/nvim-neotest/neotest-go
      'nvim-neotest/neotest-go',
      enabled = vim.g.opsconfig.plugins.neotest_go,
    },
    {
      -- NOTE:  Biblioteca auxiliar com funções utilitárias para desenvolvimento em Lua no Neovim.
      --  Fornece manipulação de arquivos, async, paths, jobs e mais.
      --  Dependência essencial para diversos plugins, como Telescope e nvim-lint.
      --  Facilita desenvolvimento de plugins com API unificada e eficiente.
      --  Repositório: https://github.com/nvim-lua/plenary.nvim
      'nvim-lua/plenary.nvim',
      enabled = true,
    },
    {
      -- NOTE:  Fornece parsing avançado de código-fonte usando árvores sintáticas (Tree-sitter).
      --  Melhora realce de sintaxe, folds, indentação e análise estrutural do código.
      --  Suporte a múltiplas linguagens com instalação e atualização automática de parsers.
      --  Extensível, permitindo desenvolvimento de funcionalidades baseadas em árvore sintática.
      --  Repositório: https://github.com/nvim-treesitter/nvim-treesitter
      'nvim-treesitter/nvim-treesitter',
      enabled = true,
    },
  },

  config = function()
    local neotest = require('neotest')

    neotest.setup({
      adapters = {
        require('neotest-go')({
          experimental = {
            test_table = true,
          },
          args = { '-count=1', '-timeout=60s' },
        }),
      },
    })

    vim.keymap.set('n', '<leader>rt', function()
      neotest.run.run()
    end, { desc = '[R]un Nearest [T]est' })

    vim.keymap.set('n', '<leader>rf', function()
      neotest.run.run(vim.fn.expand('%'))
    end, { desc = '[R]un [F]ile Tests' })
  end,
}
