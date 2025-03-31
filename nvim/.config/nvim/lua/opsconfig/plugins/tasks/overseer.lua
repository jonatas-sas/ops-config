return {
  -- NOTE:   Gerenciador de tarefas assíncronas para Neovim.
  --   Executa, monitora e gerencia comandos e processos dentro do editor.
  --   Integra-se com plugins como nvim-dap e telescope.nvim.
  --   Suporte a logs, histórico e múltiplas estratégias de execução.
  --   Repositório: https://github.com/stevearc/overseer.nvim
  'stevearc/overseer.nvim',

  enabled = vim.g.opsconfig.plugins.overseer_nvim or false,

  dependencies = {
    -- NOTE:  Fuzzy finder altamente extensível para Neovim.
    --  Busca rápida em arquivos, buffers, LSP, comandos e muito mais.
    --  Integra-se com ripgrep, fd, fzf e plugins externos.
    --  Altamente configurável e personalizável com atalhos e extensões.
    --  Repositório: https://github.com/nvim-telescope/telescope.nvim
    {
      'nvim-telescope/telescope.nvim',
      enabled = vim.g.opsconfig.plugins.telescope_nvim or false,
    },
  },

  config = function()
    require('overseer').setup({
      'builtin', -- Habilita templates internos do Overseer
      'go', -- Comandos para Go (build, run, test)
      'make', -- Suporte a Makefile
      'npm', -- Comandos para Node.js
      'cargo', -- Para Rust (caso precise)
      'shell', -- Permite rodar scripts shell/bash
      'php', -- Templates para PHP e Composer
    })

    -- Keymaps {{{

    vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<CR>', { desc = '[O]verseer [R]un Task' })
    vim.keymap.set('n', '<leader>op', '<cmd>OverseerToggle<CR>', { desc = '[O]verseer [P]anel Toggle' })
    vim.keymap.set('n', '<leader>oi', '<cmd>OverseerInfo<CR>', { desc = '[O]verseer [I]nfo' })

    -- }}}

    require('opsconfig.plugins.tasks.templates.go')
  end,
}
