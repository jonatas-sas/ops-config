local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Highly customizable start screen for Neovim.
  --  Supports keybindings, custom headers, and plugin integrations.
  --  Displays recent sessions, quick links, and useful info at startup.
  --  Lightweight, fast, and easy to configure with built-in themes.
  --  Repository: https://github.com/goolord/alpha-nvim
  'goolord/alpha-nvim',

  enabled = plugins.alpha_nvim and plugins.plenary_nvim,

  event = 'VimEnter',

  dependencies = {
    { 'nvim-lua/plenary.nvim', enabled = true },
    { 'nvim-tree/nvim-web-devicons', enabled = plugins.nvim_web_devicons },
  },

  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    local helpers = require('opsconfig.helpers.keymaps')

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

    local file_explorer_cmd = nil

    if plugins.nvim_tree then
      file_explorer_cmd = '<cmd>NvimTreeToggle<CR>'
    elseif plugins.oil then
      file_explorer_cmd = 'lua: require("opsconfig.helpers.keymaps").oil.open_root'
    end

    dashboard.section.buttons.val = {
      dashboard.button('e', '  > New File', '<cmd>ene<CR>'),
      dashboard.button('SPC ee', '  > File Explorer', file_explorer_cmd),
      dashboard.button('SPC wr', '󰁯  > Restore Session', '<cmd>SessionRestore<CR>'),
      dashboard.button('q', '  > Quit NVIM', '<cmd>qa<CR>'),
    }

    alpha.setup(dashboard.opts)

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
