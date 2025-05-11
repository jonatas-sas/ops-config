local plugins = vim.g.opsconfig.plugins
local global = vim.g.opsconfig.global

return {
  -- NOTE:  Collection of preconfigured settings for LSP servers in Neovim.
  --  Simplifies setup and management of LSPs with customizable options.
  --  Integrates with mason.nvim for automatic server installation.
  --  Repository: https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',

  enabled = plugins.nvim_lspconfig and plugins.mason_nvim and plugins.mason_lspconfig_nvim and plugins.nvim_ufo,

  dependencies = {
    { 'williamboman/mason.nvim', enabled = true },
    { 'williamboman/mason-lspconfig.nvim', enabled = true },
    { 'kevinhwang91/nvim-ufo', enabled = true },
  },

  config = function()
    local lspconfig = require('lspconfig')

    local capabilities, flags = require('opsconfig.plugins.lsp.config.lsp').default_config()

    -- SECTION: LSP Servers
    lspconfig.lua_ls.setup(require('opsconfig.plugins.lsp.servers.luals').config(capabilities, flags))
    lspconfig.gopls.setup(require('opsconfig.plugins.lsp.servers.gopls').config(capabilities, flags))
    lspconfig.bashls.setup(require('opsconfig.plugins.lsp.servers.bashls').config(capabilities, flags))
    lspconfig.cssls.setup(require('opsconfig.plugins.lsp.servers.cssls').config(capabilities, flags))
    lspconfig.html.setup(require('opsconfig.plugins.lsp.servers.htmlls').config(capabilities, flags))
    lspconfig.jsonls.setup(require('opsconfig.plugins.lsp.servers.jsonls').config(capabilities, flags))
    lspconfig.marksman.setup(require('opsconfig.plugins.lsp.servers.marksman').config(capabilities, flags))
    lspconfig.pyright.setup(require('opsconfig.plugins.lsp.servers.pyright').config(capabilities, flags))
    lspconfig.eslint.setup(require('opsconfig.plugins.lsp.servers.eslint').config(capabilities, flags))
    lspconfig.phpactor.setup(require('opsconfig.plugins.lsp.servers.phpactor').config(capabilities, flags))
    lspconfig.intelephense.setup(require('opsconfig.plugins.lsp.servers.intelephense').config(capabilities, flags))

    -- Diagnostic Config {{{

    local diagnostic_config = {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }

    if vim.g.opsconfig.global.fonts.nerd_font_available then
      local signs = {
        ERROR = '',
        WARN = '',
        INFO = '',
        HINT = '',
      }

      local diagnostic_signs = {}

      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end

      diagnostic_config.signs = { text = diagnostic_signs }
    end

    vim.diagnostic.config(diagnostic_config)

    -- SECTION: Inlay Hints and Client Actions
    require('opsconfig.plugins.lsp.events.lsp-attach').setup()
  end,
}
