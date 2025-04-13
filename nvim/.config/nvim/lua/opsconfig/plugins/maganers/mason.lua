local config = vim.g.opsconfig
local plugins = config.plugins
local global = config.global

return {
  -- NOTE:  Gerencia a instalação de LSPs, DAPs, linters e formatters no Neovim.
  --  Fornece uma interface simples para instalar e atualizar ferramentas externas.
  --  Integra-se com lspconfig e null-ls para configuração automática.
  --  Repositório: https://github.com/williamboman/mason.nvim
  'williamboman/mason.nvim',

  enabled = vim.g.opsconfig.plugins.mason_nvim
    and vim.g.opsconfig.plugins.nvim_lspconfig
    and vim.g.opsconfig.plugins.mason_lspconfig_nvim,

  dependencies = {
    {
      'neovim/nvim-lspconfig',
      enabled = true,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      enabled = true,
    },
    {
      'nvimtools/none-ls.nvim',
      enabled = true,
    },
    {
      'jay-babu/mason-null-ls.nvim',
      enabled = true,
    },
    {
      'jay-babu/mason-nvim-dap.nvim',
      enabled = vim.g.opsconfig.plugins.nvim_dap,
    },
  },

  config = function()
    local mason = require('mason')

    mason.setup()

    -- SECTION: Available LSP, Linters and Formatters

    local available_lsp_servers = {
      'bashls',
      'jsonls',
      'yamlls',
      'eslint',
    }
    local available_dap_servers = {}
    local available_linters = {
      'golangci-lint',
      'markdownlint',
      'eslint_d',
      'phpstan',
      'phpcs',
      'phpinsights',
    }
    local available_formatters = {
      'stylua',
      'gofmt',
      'goimports',
      'prettier',
      'shfmt',
      'systemd_analyze',
      'php_cs_fixer',
      'taplo',
      'jq',
    }

    local available_dev_lsp_servers = {
      'lua_ls',
      'cssls',
      'html',
      'pyright',
      'tsp_server',
      'intelephense',
      'phpactor',
    }
    local available_dev_dap_servers = {
      'php',
      'delve',
    }
    local available_dev_linters = {}
    local available_dev_formatters = {}

    local available_srv_lsp_servers = {}
    local available_srv_dap_servers = {}
    local available_srv_linters = {}
    local available_srv_formatters = {}

    -- SECTION: Language Servers (LSP)

    if global.is_dev then
      vim.list_extend(available_lsp_servers, available_dev_lsp_servers)
      vim.list_extend(available_dap_servers, available_dev_dap_servers)
      vim.list_extend(available_linters, available_dev_linters)
      vim.list_extend(available_formatters, available_dev_formatters)
    end

    if global.is_servers then
      vim.list_extend(available_lsp_servers, available_srv_lsp_servers)
      vim.list_extend(available_dap_servers, available_srv_dap_servers)
      vim.list_extend(available_linters, available_srv_linters)
      vim.list_extend(available_formatters, available_srv_formatters)
    end

    -- SECTION: LSP

    if not global.lsp.skip then
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup({
        ensure_installed = available_lsp_servers,
        automatic_installation = global.lsp.auto_install,
      })
    end

    -- SECTION: Formatters & Linters (none-ls)

    local available_none_ls = {}

    if not global.formatters.skip then
      vim.list_extend(available_none_ls, available_formatters)
    end

    if not global.linters.skip then
      vim.list_extend(available_none_ls, available_linters)
    end

    if #available_none_ls > 0 then
      local mason_null_ls = require('mason-null-ls')

      mason_null_ls.setup({
        ensure_installed = available_none_ls,
        automatic_installation = global.formatters.auto_install and global.linters.auto_install,
      })
    end

    -- SECTION: DAP

    if not global.dap.skip and plugins.nvim_dap then
      local mason_dap = require('mason-nvim-dap')

      mason_dap.setup({
        ensure_installed = available_dap_servers,
        automatic_installation = global.dap.auto_install,
      })
    end
  end,
}
