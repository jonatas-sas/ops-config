return {
  -- NOTE:  Biblioteca auxiliar com funções utilitárias para desenvolvimento em Lua no Neovim.
  --  Fornece manipulação de arquivos, async, paths, jobs e mais.
  --  Dependência essencial para diversos plugins, como Telescope e nvim-lint.
  --  Facilita desenvolvimento de plugins com API unificada e eficiente.
  --  Repositório: https://github.com/nvim-lua/plenary.nvim
  'nvim-lua/plenary.nvim',

  enabled = vim.g.opsconfig.plugins.plenary_nvim,
}
