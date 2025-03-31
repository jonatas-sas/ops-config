return {
  -- NOTE: Plugin para tradução direta no Neovim.
  -- Permite traduzir textos utilizando comandos ou APIs externas, como Google Translate, translate-shell e DeepL.
  -- Oferece múltiplas formas de exibir os resultados: janela flutuante, divisão de janela, inserção no buffer atual ou substituição do texto original.
  -- Altamente configurável, permitindo adicionar funções personalizadas para tradução.
  -- Repositório: https://github.com/uga-rosa/translate.nvim
  'uga-rosa/translate.nvim',

  enabled = vim.g.opsconfig.plugins.translate_nvim or false,

  config = function()
    require('translate').setup({
      default = {
        command = 'google',
        output = 'replace',
      },
    })

    vim.keymap.set('v', '<leader>tr', '<cmd>Translate<CR>', { desc = 'Traduzir texto selecionado' })
    vim.keymap.set('n', '<leader>tr', '<cmd>Translate<CR>', { desc = 'Traduzir palavra sob o cursor' })
  end,
}
