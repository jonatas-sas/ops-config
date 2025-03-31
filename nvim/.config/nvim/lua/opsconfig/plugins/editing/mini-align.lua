return {
  -- NOTE:  Plugin leve para alinhamento de texto no Neovim.
  --  Permite alinhar rapidamente código, tabelas e listas por caracteres específicos.
  --  Simples e eficiente, sem dependências externas.
  --  Configurável, com suporte a alinhamento interativo e regras personalizadas.
  --  Repositório: https://github.com/echasnovski/mini.align
  'echasnovski/mini.align',

  version = false,

  enable = vim.g.opsconfig.plugins.mini_align,

  config = function()
    require('mini.align').setup({
      mappings = {
        start = 'ga',
        start_with_preview = 'gA',
      },

      options = {
        split_pattern = '',
        justify_side = 'left',
        merge_delimiter = '',
      },

      steps = {
        pre_split = {},
        split = nil,
        pre_justify = {},
        justify = nil,
        pre_merge = {},
        merge = nil,
      },

      silent = false,
    })
  end,
}
