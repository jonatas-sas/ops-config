return {
  -- NOTE:  Integração do Lazygit com Neovim para gerenciamento eficiente de Git.
  --  Permite abrir o Lazygit diretamente no Neovim via comandos.
  --  Suporte a atalhos personalizados para navegação rápida.
  --  Leve e fácil de configurar, requer o Lazygit instalado.
  --  Repositório: https://github.com/kdheepak/lazygit.nvim
  'kdheepak/lazygit.nvim',

  enabled = vim.g.opsconfig.plugins.lazygit_nvim,

  dependencies = {
    -- NOTE:  Biblioteca auxiliar com funções utilitárias para desenvolvimento em Lua no Neovim.
    --  Fornece manipulação de arquivos, async, paths, jobs e mais.
    --  Dependência essencial para diversos plugins, como Telescope e nvim-lint.
    --  Facilita desenvolvimento de plugins com API unificada e eficiente.
    --  Repositório: https://github.com/nvim-lua/plenary.nvim
    {
      'nvim-lua/plenary.nvim',
      enabled = true,
    },
  },

  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },

  keys = {
    { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'Opens [L]azy [G]it' },
  },
}
