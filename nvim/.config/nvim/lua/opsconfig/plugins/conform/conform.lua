local plugins = vim.g.opsconfig.plugins
local global = vim.g.opsconfig.global

return {
  -- NOTE:  Asynchronous and configurable formatting for multiple languages in Neovim.
  --  Supports multiple formatters with automatic fallback.
  --  Integrates with autocmds to format files on save.
  --  Lightweight, no external dependencies, and easy to set up.
  --  Repository: https://github.com/stevearc/conform.nvim
  'stevearc/conform.nvim',

  enabled = plugins.conform_nvim,

  event = {
    'BufReadPre',
    'BufNewFile',
  },

  config = function()
    local conform = require('conform')

    -- SECTION: Setup

    local format_opts = { lsp_fallback = true, async = false, timeout_ms = 1000 }
    local bin = require('opsconfig.plugins.conform.formatters.bin')
    local is_dev = global.is_dev

    -- SUBSECTION: Formatters

    local formatters = {}

    if is_dev then
      if global.languages.php.phpcs then
        formatters.phpcs = bin.phpcs('default')
        formatters.phpcs_config = bin.phpcs('config')
        formatters.phpcs_template = bin.phpcs('template')
      end

      formatters.kdlfmt = bin.kdlfmt()
    end

    formatters.shfmt = bin.shfmt()
    formatters.systemd_analyze = bin.systemd_analyze()
    formatters.nginxfmt = bin.nginxfmt()

    -- SUBSECTION: Formatters by File Type

    local formatters_by_ft = {}

    if is_dev then
      formatters_by_ft.lua = { 'stylua' }
      formatters_by_ft.go = { 'gofmt', 'goimports' }
      formatters_by_ft.javascript = { 'prettier' }
      formatters_by_ft.typescript = { 'prettier' }
      formatters_by_ft.javascriptreact = { 'prettier' }
      formatters_by_ft.typescriptreact = { 'prettier' }
      formatters_by_ft.css = { 'prettier' }
      formatters_by_ft.html = { 'prettier' }
      formatters_by_ft.python = { 'isort', 'black' }
      formatters_by_ft.toml = { 'taplo' }
      formatters_by_ft.kdl = { 'kdlfmt' }
      formatters_by_ft.gotmpl = { 'prettier' }

      if global.languages.php.phpcs then
        formatters_by_ft['php'] = { 'phpcs' }
        formatters_by_ft['php.template'] = { 'phpcs_template' }
        formatters_by_ft['php.config'] = { 'phpcs_config' }
      end
    end

    formatters_by_ft.nginx = { 'nginxfmt' }
    formatters_by_ft.json = { 'prettier' }
    formatters_by_ft.markdown = { 'prettier' }
    formatters_by_ft.graphql = { 'prettier' }
    formatters_by_ft.sh = { 'shfmt' }
    formatters_by_ft.bash = { 'shfmt' }
    formatters_by_ft.zsh = { 'shfmt' }
    formatters_by_ft.systemd = { 'systemd_analyze' }

    conform.setup({
      log_level = vim.log.levels.WARN,
      notify_on_error = true,
      formatters = formatters,
      formatters_by_ft = formatters_by_ft,

      format_on_save = function(bufnr)
        conform.format(vim.tbl_extend('force', { bufnr = bufnr }, format_opts))
      end,
    })

    -- SECTION: Keymaps

    -- Keymaps Config: ../../core/keymaps.lua
  end,
}
