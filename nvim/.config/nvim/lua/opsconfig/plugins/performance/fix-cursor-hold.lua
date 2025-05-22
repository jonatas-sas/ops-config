return {
  -- NOTE:  Plugin para corrigir o tempo de espera do CursorHold no Neovim.
  --  Reduz atrasos ao usar eventos baseados em CursorHold.
  --  Melhora a responsividade de plugins como LSP, hover e pré-visualização.
  --  Essencial para evitar travamentos em timeouts longos.
  --  Repositório: https://github.com/antoinemadec/FixCursorHold.nvim
  'antoinemadec/FixCursorHold.nvim',

  enabled = vim.g.opsconfig.plugins.fixcursorhold_nvim,

  config = function()
    vim.g.cursorhold_updatetime = 100
  end,
}
