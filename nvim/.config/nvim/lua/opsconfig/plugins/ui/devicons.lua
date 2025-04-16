local plugins = vim.g.opsconfig.plugins
local global = vim.g.opsconfig.global

return {
  -- NOTE:  Icons for files and directories in Neovim.
  --  Integrates with plugins like nvim-tree, telescope, and lualine.
  --  Supports multiple themes and icon customization.
  --  Requires a Nerd Font for proper display.
  -- 󰛖 Fonts: https://www.nerdfonts.com/cheat-sheet
  --  Repository: https://github.com/nvim-tree/nvim-web-devicons
  'nvim-tree/nvim-web-devicons',

  enabled = plugins.nvim_web_devicons and global.fonts.nerd_font_available,

  config = function()
    require('nvim-web-devicons').setup({
      override = {
        phtml = {
          icon = '',
          color = '#f16529',
          name = 'PHTML',
        },

        phpconfig = {
          icon = '',
          color = '#4F5D95',
          name = 'PHPConfig',
        },

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
