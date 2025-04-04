return {
  -- NOTE:  Integração entre Neovim e o terminal multiplexador Zellij.
  --  Permite enviar comandos e interagir com painéis do Zellij diretamente do Neovim.
  --  Melhora a produtividade ao unificar editor e terminal no mesmo fluxo.
  --  Configurável, com suporte a atalhos e scripts personalizados.
  --  Repositório: https://github.com/fresh2dev/zellij.vim
  'fresh2dev/zellij.vim',

  lazy = false,

  init = function()
    -- Options:
    vim.g.zelli_navigator_move_focus_or_tab = 1
    vim.g.zellij_navigator_no_default_mappings = 1

    vim.keymap.set('n', '<C-h>', ':ZellijNavigateLeft<CR>', { desc = 'zMove focus to the left window' })
    vim.keymap.set('n', '<C-j>', ':ZellijNavigateDown<CR>', { desc = 'zMove focus to the lower window' })
    vim.keymap.set('n', '<C-k>', ':ZellijNavigateUp<CR>', { desc = 'zMove focus to the upper window' })
    vim.keymap.set('n', '<C-l>', ':ZellijNavigateRight<CR>', { desc = 'zMove focus to the right window' })
  end,
}
