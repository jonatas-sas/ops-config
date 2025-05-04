local config = vim.g.opsconfig
local plugins = config.plugins
local global = config.global

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
    local is_dev = global.is_dev

    if is_dev then
      local lint = require('lint')

      local go_linters = {}
      local php_linters = {}
      local enable_go_linter = is_dev and global.languages.go.enabled and global.languages.go.linter
      local enable_php_phpstan = is_dev and global.languages.php.enabled and global.languages.php.phpstan
      local enable_php_codesniffer = is_dev and global.languages.php.enabled and global.languages.php.php_codesniffer

      local linters = {
        go = {},
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        svelte = { 'eslint_d' },
        python = { 'pylint' },
        php = {},
      }

      if enable_go_linter then
        table.insert(go_linters, 'golangci_lint')

        lint.linters.golangci_lint = require('opsconfig.plugins.linters.go.golangci-lint')
      end

      if enable_php_phpstan then
        table.insert(php_linters, 'phpstan')

        lint.linters.phpstan = require('opsconfig.plugins.linters.php.phpstan')
      end

      if enable_php_codesniffer then
        table.insert(php_linters, 'phpcs')

        lint.linters.phpcs = require('opsconfig.plugins.linters.php.php-codesniffer')
      end

      linters.go = go_linters
      linters.php = php_linters

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
    end
  end,
}
