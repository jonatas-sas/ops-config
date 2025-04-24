return {
  -- NOTE:  Maximiza e restaura janelas no Neovim com um único comando.
  --  Mantém o layout original ao restaurar a visualização.
  --  Funciona em splits horizontais e verticais sem alterar buffers.
  --  Simples, leve e sem dependências externas.
  --  Repositório: https://github.com/szw/vim-maximizer
  'szw/vim-maximizer',

  enabled = vim.g.opsconfig.plugins.vim_maximizer,

  depends = {
    -- NOTE:  Mostra dicas de atalhos no Neovim em tempo real.
    --  Exibe combinações de teclas disponíveis ao pressionar um prefixo.
    --  Ajuda a memorizar atalhos e melhorar a produtividade.
    --  Totalmente configurável, com suporte a grupos e descrições personalizadas.
    --  Repositório: https://github.com/folke/which-key.nvim
    {
      'folke/which-key.nvim',
      enabled = true,
    },
  },

  config = function()
    vim.g.maximizer_set_default_mapping = 0
    vim.g.maximizer_set_default_keybindings = 0

    local wk = require('which-key')

    wk.add({
      {
        '<F11>',
        '<cmd>MaximizerToggle<CR>',
        desc = 'Toggle Maximize (Alt Binding)',
        icon = { color = 'green', icon = '󰘽' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
    })
  end,
}
