return {
  -- NOTE: ﮩ Integração do ChatGPT com o Neovim.
  --  Permite gerar, completar e refatorar código diretamente no editor.
  --  Auxilia no desenvolvimento com respostas inteligentes e contextuais.
  --  Configurável, com suporte a comandos personalizados e atalhos.
  --  Repositório: https://github.com/jackMort/ChatGPT.nvim
  'jackMort/ChatGPT.nvim',

  enabled = vim.g.opsconfig.plugins.chatgpt_nvim
    and vim.g.opsconfig.plugins.nui_nvim
    and vim.g.opsconfig.plugins.plenary_nvim
    and vim.g.opsconfig.plugins.trouble_nvim
    and vim.g.opsconfig.plugins.telescope_nvim,

  event = 'VeryLazy',

  -- Dependencies {{{

  dependencies = {
    -- NOTE:  Biblioteca para criar interfaces gráficas no Neovim com Lua.
    --  Fornece APIs para janelas, popups, menus e componentes customizados.
    --  Utilizado por diversos plugins como noice.nvim e dressing.nvim.
    --  Flexível, eficiente e fácil de integrar com outras ferramentas.
    --  Repositório: https://github.com/MunifTanjim/nui.nvim
    {
      'MunifTanjim/nui.nvim',
      enabled = true,
    },

    -- NOTE:  Biblioteca auxiliar com funções utilitárias para desenvolvimento em Lua no Neovim.
    --  Fornece manipulação de arquivos, async, paths, jobs e mais.
    --  Dependência essencial para diversos plugins, como Telescope e nvim-lint.
    --  Facilita desenvolvimento de plugins com API unificada e eficiente.
    --  Repositório: https://github.com/nvim-lua/plenary.nvim
    {
      'nvim-lua/plenary.nvim',
      enabled = true,
    },

    -- NOTE:  Exibe diagnósticos, quickfix, LSP references e todo-comments em uma lista organizada.
    --  Interface intuitiva para navegação rápida entre erros e avisos.
    --  Integra-se com LSP, Telescope, todo-comments e outros plugins.
    --  Suporte a atalhos para abrir, fechar e filtrar resultados facilmente.
    --  Repositório: https://github.com/folke/trouble.nvim
    {
      'folke/trouble.nvim',
      enabled = true,
    },

    -- NOTE:  Fuzzy finder altamente extensível para Neovim.
    --  Busca rápida em arquivos, buffers, LSP, comandos e muito mais.
    --  Integra-se com ripgrep, fd, fzf e plugins externos.
    --  Altamente configurável e personalizável com atalhos e extensões.
    --  Repositório: https://github.com/nvim-telescope/telescope.nvim
    {
      'nvim-telescope/telescope.nvim',
      enabled = true,
    },
  },

  -- }}}

  config = function()
    require('chatgpt').setup({
      api_key_cmd = 'pass show api/tokens/openai',
    })
  end,
}
