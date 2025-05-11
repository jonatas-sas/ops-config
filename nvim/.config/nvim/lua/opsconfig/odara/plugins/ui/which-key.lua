return {
  -- NOTE:  Mostra dicas de atalhos no Neovim em tempo real.
  --  Exibe combinações de teclas disponíveis ao pressionar um prefixo.
  --  Ajuda a memorizar atalhos e melhorar a produtividade.
  --  Totalmente configurável, com suporte a grupos e descrições personalizadas.
  --  Repositório: https://github.com/folke/which-key.nvim
  'folke/which-key.nvim',

  enabled = vim.g.opsconfig.plugins.which_key_nvim,

  event = 'VimEnter',

  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,

  opts = {
    delay = 0,

    icons = {
      mappings = vim.g.opsconfig.global.fonts.nerd_font_available,

      keys = vim.g.opsconfig.global.fonts.nerd_font_available and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ebug' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
