return {
  -- NOTE:  Tela inicial altamente customizável para o Neovim.
  --  Suporte a atalhos, cabeçalhos personalizados e integração com plugins.
  --  Exibe sessões recentes, atalhos rápidos e informações úteis no startup.
  --  Leve, rápido e fácil de configurar com temas prontos.
  --  Repositório: https://github.com/goolord/alpha-nvim
  'goolord/alpha-nvim',

  enabled = vim.g.opsconfig.plugins.alpha_nvim and vim.g.opsconfig.plugins.plenary_nvim,

  event = 'VimEnter',

  dependencies = {
    -- NOTE:  Biblioteca auxiliar com funções utilitárias para desenvolvimento em Lua no Neovim.
    --  Fornece manipulação de arquivos, async, paths, jobs e mais.
    --  Dependência essencial para diversos plugins, como Telescope e nvim-lint.
    --  Facilita desenvolvimento de plugins com API unificada e eficiente.
    --  Repositório: https://github.com/nvim-lua/plenary.nvim
    {
      'nvim-lua/plenary.nvim',
      enabled = true,
    },

    -- NOTE:  Ícones para arquivos e diretórios no Neovim.
    --  Integra-se com plugins como nvim-tree, telescope e lualine.
    --  Suporte a múltiplos temas e personalização de ícones.
    --  Requer uma fonte Nerd Font para exibição correta.
    --  Repositório: https://github.com/nvim-tree/nvim-web-devicons
    {
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.opsconfig.plugins.nvim_web_devicons or false,
    },
  },

  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    dashboard.section.header.val = {
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
    }

    dashboard.section.buttons.val = {
      dashboard.button('e', '  > New File', '<cmd>ene<CR>'),

      dashboard.button(
        'SPC ee',
        '  > Toggle File [E]xplor[e]r',
        '<cmd>NvimTreeToggle<CR>',
        { desc = 'Toggle File [E]xplor[e]r' }
      ),

      -- dashboard.button('SPC wr', '󰁯  > Restore Session For Current Directory', '<cmd>SessionRestore<CR>'),

      dashboard.button('q', '  > Quit NVIM', '<cmd>qa<CR>'),
    }

    alpha.setup(dashboard.opts)

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
