return {
  -- NOTE:  Statusline plugin written in Lua for Neovim.
  --  Fast, minimal, and highly customizable with a wide range of components.
  --  Enhances visibility of mode, file info, diagnostics, and plugin states.
  --  Supports themes, extensions, and custom sections with easy configuration.
  --  Repository: https://github.com/nvim-lualine/lualine.nvim
  'nvim-lualine/lualine.nvim',

  enabled = vim.g.opsconfig.plugins.lualine_nvim
    and vim.g.opsconfig.plugins.noice_nvim
    and vim.g.opsconfig.plugins.nvim_web_devicons,

  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
      enabled = true,
    },
    {
      'folke/tokyonight.nvim',
      enabled = vim.g.opsconfig.plugins.tokyonight_nvim,
    },
    {
      'catppuccin/nvim',
      enabled = vim.g.opsconfig.plugins.catppuccin_nvim,
    },
    {
      'AndreM222/copilot-lualine',
      enabled = vim.g.opsconfig.plugins.copilot_lualine,
    },
    {
      'okuuva/auto-save.nvim',
      enabled = vim.g.opsconfig.plugins.auto_save_nvim,
    },
  },

  config = function()
    local lualine = require('lualine')
    local lazy_status = require('lazy.status')
    local setup = {}
    local plugins_updates_color = '#ff9e64'
    --local use = require('opsconfig.plugins.ui.lualine.helper').use

    if vim.g.opsconfig.plugins.tokyonight_nvim then
      setup.options = {
        theme = require('opsconfig.plugins.ui.lualine.themes.tokyonight'),
      }
    end

    if vim.g.opsconfig.plugins.catppuccin_nvim then
      plugins_updates_color = '#fab387'

      setup.options = {
        theme = 'catppuccin',
      }
    end

    local noice = require('noice')

    setup.sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        'diff',
        'diagnostics',
        {
          '',
          color = function()
            if not vim.g.opsconfig.plugins.nvim_dap then
              return { fg = '#98C379' }
            end

            if require('dap').session() then
              return { fg = '#98C379' }
            else
              return { fg = '#5C6370' }
            end
          end,
          cond = function()
            return true
          end,
        },
      },
      lualine_c = {
        {
          'filename',
          path = 1,
          file_status = true,
          newfile_status = true,
          shorting_target = 40,
          symbols = {
            modified = ' ✎',
            readonly = ' ',
            unnamed = '[No Name]',
            newfile = '[New]',
          },
          color = function()
            if vim.bo.modified then
              return { fg = '#f38ba8', gui = 'bold' }
            end

            return nil
          end,
        },
      },
      lualine_x = {
        {
          noice.api.statusline.mode.get,
          cond = noice.api.statusline.mode.has,
          color = { fg = '#ff9e64' },
        },
        {
          lazy_status.updates,
          cond = lazy_status.has_updates,
          color = { fg = plugins_updates_color },
        },
        {
          'copilot',
          symbols = {
            status = {
              icons = {
                enabled = ' ',
                disabled = ' ',
                warning = '',
                error = '',
                loading = ' ',
              },
            },
          },
          show_colors = true,
        },
        'encoding',
        'fileformat',
        {
          'filetype',
          icon = function()
            local ftype = vim.bo.filetype

            if ftype == 'vim' and vim.fn.expand('%:t') == 'vifmrc' then
              return ''
            else
              return require('nvim-web-devicons').get_icon_by_filetype(ftype, { default = true })
            end
          end,
        },
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    }

    lualine.setup(setup)
  end,
}
