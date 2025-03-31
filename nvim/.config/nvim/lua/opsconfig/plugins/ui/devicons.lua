return {
  -- NOTE:  Ícones para arquivos e diretórios no Neovim.
  --  Integra-se com plugins como nvim-tree, telescope e lualine.
  --  Suporte a múltiplos temas e personalização de ícones.
  --  Requer uma fonte Nerd Font para exibição correta.
  --  Repositório: https://github.com/nvim-tree/nvim-web-devicons
  -- 󰛖 Fontes: https://www.nerdfonts.com/cheat-sheet
  'nvim-tree/nvim-web-devicons',

  enabled = vim.g.opsconfig.plugins.nvim_web_devicons and vim.g.have_nerd_font,

  config = function()
    require('nvim-web-devicons').setup({
      override = {
        nginx = {
          icon = '',
          color = '#009639',
          name = 'Nginx',
        },
        ['*.nginx'] = {
          icon = '',
          color = '#009639',
          name = 'NginxCustom',
        },
      },
    })
  end,
}
