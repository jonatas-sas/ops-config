return {
  -- NOTE: 墳 Barra de status altamente customizável para Neovim.
  --  Suporte a separadores, temas e integração com LSP, buffers e git.
  --  Leve e otimizada para desempenho sem comprometer a estética.
  --  Fácil de configurar e compatível com nvim-web-devicons.
  --  Repositório: https://github.com/nvim-lualine/lualine.nvim
  'nvim-lualine/lualine.nvim',

  enabled = vim.g.opsconfig.plugins.lualine_nvim
    and vim.g.opsconfig.plugins.noice_nvim
    and vim.g.opsconfig.plugins.nvim_web_devicons,

  -- Dependencies {{{

  dependencies = {
    -- NOTE:  Ícones para arquivos e diretórios no Neovim.
    --  Integra-se com plugins como nvim-tree, telescope e lualine.
    --  Suporte a múltiplos temas e personalização de ícones.
    --  Requer uma fonte Nerd Font para exibição correta.
    --  Repositório: https://github.com/nvim-tree/nvim-web-devicons
    {
      'nvim-tree/nvim-web-devicons',
      enabled = true,
    },

    -- NOTE:  Tema moderno e vibrante para Neovim com suporte a LSP e Treesitter.
    --  Oferece variações como Night, Storm, Day e Moon.
    --  Integra-se com diversos plugins para uma experiência visual coesa.
    --  Personalizável via configurações para cores e transparência.
    --  Repositório: https://github.com/folke/tokyonight.nvim
    {
      'folke/tokyonight.nvim',
      enabled = vim.g.opsconfig.plugins.tokyonight_nvim,
    },

    -- NOTE:   Tema elegante e altamente personalizável para Neovim.
    --   Fornece paleta suave e consistente para diferentes ambientes.
    --   Suporte nativo para LSP, Treesitter, Telescope e mais.
    --   Variantes de cores configuráveis para diferentes estilos visuais.
    --   Repositório: https://github.com/catppuccin/nvim
    {
      'catppuccin/nvim',
      enabled = vim.g.opsconfig.plugins.catppuccin_nvim,
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

    -- NOTE:  Salvamento automático de arquivos no Neovim.
    --  Detecta mudanças e salva buffers automaticamente em segundo plano.
    --  Evita perda de progresso e melhora o fluxo de trabalho contínuo.
    --  Altamente configurável, com suporte a condições, eventos e exceções.
    --  Repositório: https://github.com/okuuva/auto-save.nvim
    {
      'okuuva/auto-save.nvim',
      enabled = vim.g.opsconfig.plugins.auto_save_nvim,
    },
  },

  -- }}}

  config = function()
    local lualine = require('lualine')
    local lazy_status = require('lazy.status')
    local setup = {}
    local plugins_updates_color = '#ff9e64'

    -- Tokio Night Theme {{{

    if vim.g.opsconfig.plugins.tokyonight_nvim then
      setup.options = {
        theme = require('opsconfig.plugins.ui.lualine.themes.tokyonight'),
      }
    end

    -- }}}

    if vim.g.opsconfig.plugins.catppuccin_nvim then
      plugins_updates_color = '#fab387'

      setup.options = {
        theme = 'catppuccin',
      }
    end

    local registry = require('mason-registry')

    local function mason_updates()
      local outdated = 0
      for _, pkg in ipairs(registry.get_installed_packages()) do
        if pkg:is_outdated() then
          outdated = outdated + 1
        end
      end
      return outdated > 0 and ('󰇚 ' .. outdated) or ''
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
          mason_updates,
          cond = function()
            return pcall(require, 'mason-registry')
          end,
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
        {
          function()
            return _G.autosave_statusline()
          end,
          icon = '󱂬',
          color = { fg = '#98be65' }, -- verde
        },
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    }

    lualine.setup(setup)
  end,
}
