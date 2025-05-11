return {
  -- NOTE:  Melhora a interface de seleção e entrada de comandos no Neovim.
  --  Substitui `vim.ui.select` e `vim.ui.input` por janelas customizáveis.
  --  Integra-se com Telescope e fzf para uma experiência aprimorada.
  --  Leve, configurável e compatível com diversos plugins.
  --  Repositório: https://github.com/stevearc/dressing.nvim
  'stevearc/dressing.nvim',

  enabled = vim.g.opsconfig.plugins.dressing_nvim,

  event = 'VeryLazy',
}
