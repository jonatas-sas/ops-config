return {
  -- NOTE:  Autocompletar código com IA no Neovim.
  --  Sugestões em tempo real para diversas linguagens de programação.
  --  Acelera o desenvolvimento com previsões contextuais e inteligentes.
  --  Configurável, com suporte a atalhos e preferências personalizadas.
  --  Repositório: https://github.com/Exafunction/codeium.vim
  'Exafunction/codeium.vim',

  enabled = vim.g.opsconfig.plugins.codeium_vim,

  event = 'BufEnter',

  config = function()
    vim.keymap.set('i', '<C-g>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<c-;>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<c-,>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<c-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true })
  end,
}
