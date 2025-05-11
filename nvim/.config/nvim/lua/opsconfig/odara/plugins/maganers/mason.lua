local plugins = vim.g.opsconfig.plugins
local global = vim.g.opsconfig.global

return {
  -- NOTE:  Manages the installation of LSPs, DAPs, linters, and formatters in Neovim.
  --  Provides a simple interface to install and update external tools.
  --  Integrates with lspconfig and null-ls for automatic configuration.
  --  Repository: https://github.com/williamboman/mason.nvim
  'williamboman/mason.nvim',

  enabled = plugins.mason_nvim and plugins.nvim_lspconfig and plugins.mason_lspconfig_nvim,

  dependencies = {
    { 'neovim/nvim-lspconfig', enabled = true },
    { 'williamboman/mason-lspconfig.nvim', enabled = true },
    { 'nvimtools/none-ls.nvim', enabled = true },
    { 'jay-babu/mason-null-ls.nvim', enabled = true },
    { 'jay-babu/mason-nvim-dap.nvim', enabled = vim.g.opsconfig.plugins.nvim_dap },
  },

  config = function()
    local mason = require('mason')

    mason.setup()

    -- SECTION: Available LSP, Linters and Formatters

    -- SUBSECTION: LSP

    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup({
      ensure_installed = {
        'bashls',
        'jsonls',
        'yamlls',
        'lua_ls',
        'cssls',
        'html',
        'pyright',
        'tsp_server',
        'phpactor',
        'eslint',
      },
      automatic_installation = true,
      automatic_enable = true,
    })

    -- SUBSECTION: Formatters & Linters (none-ls)

    local mason_null_ls = require('mason-null-ls')

    mason_null_ls.setup({
      ensure_installed = {
        'stylua',
        'gofmt',
        'goimports',
        'prettier',
        'shfmt',
        'systemd_analyze',
        'php_cs_fixer',
        'taplo',
        'jq',
        'blade_formatter',
      },
      automatic_installation = true,
    })

    -- SUBSECTION: DAP

    if not global.dap.skip and plugins.nvim_dap then
      local mason_dap = require('mason-nvim-dap')

      mason_dap.setup({
        ensure_installed = {
          'php',
          'delve',
        },
        automatic_installation = true,
      })
    end
  end,
}
