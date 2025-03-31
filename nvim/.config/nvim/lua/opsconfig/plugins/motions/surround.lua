return {
  -- NOTE:  Manipula pares de caracteres como parênteses, aspas e colchetes no Neovim.
  --  Adiciona, remove e substitui delimitadores de forma intuitiva.
  --  Inspirado no vim-surround, reescrito em Lua para melhor desempenho.
  --  Suporte a mapeamentos personalizados e integração com motions.
  --  Repositório: https://github.com/kylechui/nvim-surround
  'kylechui/nvim-surround',

  enabled = vim.g.opsconfig.plugins.nvim_surround,

  event = { 'BufReadPre', 'BufNewFile' },

  version = '*',

  config = function()
    require('nvim-surround').setup({
      keymaps = {
        insert = '<C-g>s',
        insert_line = '<C-g>S',
        normal = 'ys',
        normal_cur = 'yss',
        normal_line = 'yS',
        normal_cur_line = 'ySS',
        visual = 'S',
        visual_line = 'gS',
        delete = 'ds',
        change = 'cs',
        change_line = 'cS',
      },

      surrounds = {
        ['('] = {
          add = { '(', ')' },
        },
        ['{'] = {
          add = { '{', '}' },
        },
        ['['] = {
          add = { '[', ']' },
        },
        ['<'] = {
          add = { '<', '>' },
        },
        ['"'] = {
          add = { '"', '"' },
        },
        ['\''] = {
          add = { '\'', '\'' },
        },
        ['`'] = {
          add = { '`', '`' },
        },
      },
    })
  end,
}
