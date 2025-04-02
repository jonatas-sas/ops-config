return {
  -- NOTE:  Configuração avançada do GitHub Copilot para Neovim.
  --  Fornece controle granular sobre comportamento e atalhos do Copilot.
  --  Permite ativar/desativar sugestões por buffer ou modo de inserção.
  --  Integrável com plugins como nvim-cmp para uma experiência personalizada.
  --  Repositório: https://github.com/zbirenbaum/copilot.lua
  'zbirenbaum/copilot.lua',

  enabled = false,

  lazy = false,

  cmd = 'Copilot',

  event = 'InsertEnter',

  -- Dependencies {{{

  dependencies = {
    -- NOTE:  Integra o GitHub Copilot ao nvim-cmp.
    --  Permite usar sugestões do Copilot como fonte de autocomplete.
    --  Melhora a experiência de código com previsões mais naturais e fluídas.
    --  Totalmente configurável, com suporte a prioridades e ajustes finos.
    --  Repositório: https://github.com/zbirenbaum/copilot-cmp
    {
      'zbirenbaum/copilot-cmp',
      enabled = vim.g.opsconfig.plugins.copilot_cmp,
    },

    -- NOTE:  Exibe o status do GitHub Copilot na Lualine.
    --  Indica se o Copilot está ativo e funcionando no Neovim.
    --  Ajuda a visualizar o estado da IA sem sair do fluxo de trabalho.
    --  Configurável, permitindo ajustar a exibição conforme a necessidade.
    --  Repositório: https://github.com/AndreM222/copilot-lualine
    {
      'AndreM222/copilot-lualine',
      enabled = vim.g.opsconfig.plugins.copilot_lualine,
    },
  },

  -- }}}

  config = function()
    require('copilot').setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<Tab>',
          next = '<C-l>',
          prev = '<C-h>',
          dismiss = '<C-]>',
        },
      },

      panel = { enabled = true },

      filetypes = {
        yaml = false,
        json = false,
        toml = false,
        markdown = false,
        help = false,
        nerdtree = false,
        NvimTree = false,
        telescope = false,
        TelescopePrompt = false,
        fzf = false,
        gitcommit = true,
        gitrebase = true,
      },
    })
  end,
}
