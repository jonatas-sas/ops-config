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
    -- NOTE:  Coleção de configurações prontas para servidores LSP no Neovim.
    --  Facilita a configuração e gerenciamento de LSPs com opções personalizáveis.
    --  Integra-se com mason.nvim para instalação automática de servidores.
    --  Repositório: https://github.com/neovim/nvim-lspconfig
    {
      'neovim/nvim-lspconfig',
      enabled = true,
    },

    -- NOTE:  Integra mason.nvim com lspconfig para configuração automática de LSPs.
    --  Facilita a instalação e ativação de servidores LSP compatíveis.
    --  Garante compatibilidade entre mason.nvim e nvim-lspconfig.
    --  Repositório: https://github.com/williamboman/mason-lspconfig.nvim
    {
      'williamboman/mason-lspconfig.nvim',
      enabled = true,
    },

    -- NOTE:   Ferramenta flexível para integrar linters e formatters no Neovim.
    --   Substitui o null-ls, focando em uma abordagem minimalista e extensível.
    --   Suporte a diversas fontes, incluindo formatação, diagnósticos e ações de código.
    --   Totalmente configurável via Lua, sem dependência de LSP externo.
    --   Repositório: https://github.com/nvimtools/none-ls.nvim
    {
      'nvimtools/none-ls.nvim',
      enabled = true,
    },

    -- NOTE:   Integração entre Mason e none-ls para gerenciamento de linters e formatters.
    --   Facilita a instalação e configuração de ferramentas externas para Neovim.
    --   Compatível com o sistema de fontes do none-ls, automatizando dependências.
    --   Permite configuração declarativa via Lua, simplificando o setup.
    --   Repositório: https://github.com/jay-babu/mason-null-ls.nvim
    {
      'jay-babu/mason-null-ls.nvim',
      enabled = true,
    },

    -- NOTE:   Integração entre Mason e nvim-dap para instalação de depuradores.
    --   Gerencia automaticamente adaptadores de depuração para diversas linguagens.
    --   Facilita a configuração do nvim-dap com suporte a backends populares.
    --   Permite instalação declarativa e atualização simplificada dos depuradores.
    --   Repositório: https://github.com/jay-babu/mason-nvim-dap.nvim
    {
      'jay-babu/mason-nvim-dap.nvim',
      enabled = vim.g.opsconfig.plugins.nvim_dap,
    },
  },

  config = function()
    local mason = require('mason')

    mason.setup()

    -- Language Servers (LSP) {{{

    local mason_lspconfig = require('mason-lspconfig')

    local lsp = {
      'lua_ls',
      'bashls',
      'cssls',
      'html',
      'jsonls',
      'marksman',
      'pyright',
      'tsp_server',
      'eslint',
      'yamlls',
      'intelephense',
      'phpactor',
    }

    if vim.g.opsconfig.global.skip_lsp then
      lsp = {}
    end

    mason_lspconfig.setup({
      ensure_installed = lsp,
      automatic_installation = true,
    })

    -- }}}

    -- Formatters & Linters {{{

    local mason_null_ls = require('mason-null-ls')

    local formatters = {
      -- Linters
      'golangci-lint',
      'markdownlint',
      'eslint_d',
      'phpstan',
      'phpcs',
      'phpmd',

      -- Formatters
      'stylua',
      'gofmt',
      'goimports',
      'prettier',
      'yamlfmt',
      'shfmt',
      'systemd_analyze',
      'php_cs_fixer',
      'taplo',
      'jq',
    }

    if vim.g.opsconfig.global.skip_none_ls then
      formatters = {}
    end

    mason_null_ls.setup({
      ensure_installed = formatters,
      automatic_installation = true,
    })

    -- }}}

    -- DAP {{{

    if vim.g.opsconfig.plugins.nvim_dap then
      local mason_dap = require('mason-nvim-dap')
      local dap = {
        'php',
        'delve',
      }

      mason_dap.setup({
        ensure_installed = dap,
        automatic_installation = true,
      })
    end

    -- }}}
  end,
}
