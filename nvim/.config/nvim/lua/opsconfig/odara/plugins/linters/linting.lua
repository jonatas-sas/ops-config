local config = vim.g.opsconfig
local plugins = config.plugins

return {
  -- NOTE:  Runs asynchronous linters in Neovim without requiring LSP.
  --  Supports multiple linters with file-based or global configuration.
  --  Integrates with autocmds for automatic linting on save.
  --  Extensible and compatible with various programming languages.
  --  Repository: https://github.com/mfussenegger/nvim-lint
  'mfussenegger/nvim-lint',

  enabled = plugins.nvim_lint,

  event = {
    'BufReadPre',
    'BufNewFile',
  },

  config = function()
    local lint = require('lint')

    local linters = {
      go = { 'golangci_lint' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      svelte = { 'eslint_d' },
      python = { 'pylint' },
      php = { 'phpcs', 'phpstan' },
      ['php.config'] = {},
      ['php.template'] = {},
    }

    lint.linters.golangci_lint = require('opsconfig.plugins.linters.go.golangci-lint')
    lint.linters.phpcs = require('opsconfig.plugins.linters.php.php-codesniffer')
    lint.linters.phpstan = require('opsconfig.plugins.linters.php.phpstan')

    lint.linters_by_ft = linters

    -- SECTION: Linting AutoCommand
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({
      'BufEnter',
      'BufWritePost',
      'InsertLeave',
    }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- SECTION: Available Linting Keymaps
    vim.keymap.set('n', '<leader>lf', function()
      lint.try_lint()
    end, { desc = 'Trigger [L]inting for Current [F]ile' })
  end,
}
