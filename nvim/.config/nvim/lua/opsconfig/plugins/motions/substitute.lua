return {
  -- NOTE:  Fornece novos operadores e movimentos para substituição e troca rápida de texto no Neovim.
  --  Inclui operadores de substituição, substituição em intervalo e troca de texto.
  --  Inspirado nos plugins vim-subversive e vim-exchange, reescrito em Lua para melhor desempenho.
  --  Repositório: https://github.com/gbprod/substitute.nvim
  'gbprod/substitute.nvim',

  enabled = vim.g.opsconfig.plugins.substitute_nvim,

  event = { 'BufReadPre', 'BufNewFile' },

  config = function()
    local substitute = require('substitute')

    substitute.setup({
      on_substitute = nil,
      yank_substituted_text = false,
      preserve_cursor_position = false,
      modifiers = nil,
      highlight_substituted_text = {
        enabled = true,
        timer = 500,
      },
      range = {
        prefix = 's',
        prompt_current_text = false,
        confirm = false,
        complete_word = false,
        subject = nil,
        range = nil,
        suffix = '',
        auto_apply = false,
        cursor_position = 'end',
      },
      exchange = {
        motion = false,
        use_esc_to_cancel = true,
        preserve_cursor_position = false,
      },
    })

    local wk = require('which-key')

    wk.add({
      {
        's',
        require('substitute').operator,
        desc = 'Substitute with motion',
        icon = { color = 'azure', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        'ss',
        require('substitute').line,
        desc = 'Substitute line',
        icon = { color = 'azure', icon = '󰈚' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        'S',
        require('substitute').eol,
        desc = 'Substitute to end of line',
        icon = { color = 'azure', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        's',
        require('substitute').visual,
        desc = 'Substitute in visual selection',
        icon = { color = 'azure', icon = '' },
        mode = 'x',
        noremap = true,
        silent = true,
      },
    })
  end,
}
