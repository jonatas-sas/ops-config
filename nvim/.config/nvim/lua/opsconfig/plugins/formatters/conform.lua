return {
  -- NOTE:  Formatação assíncrona e configurável para múltiplas linguagens no Neovim.
  --  Suporte a diversos formatters com fallback automático.
  --  Integração com autocmds para formatação ao salvar arquivos.
  --  Leve, sem dependências externas e fácil de configurar.
  --  Repositório: https://github.com/stevearc/conform.nvim
  'stevearc/conform.nvim',

  enabled = vim.g.opsconfig.plugins.conform_nvim,

  event = {
    'BufReadPre',
    'BufNewFile',
  },

  config = function()
    local conform = require('conform')

    -- Setup {{{

    local home_path = os.getenv('HOME')
    local config_path = home_path .. '/.opsconfig/applications/config'
    local format_opts = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    }

    -- Formatters {{{

    local formatters = {}

    if vim.g.opsconfig.global.is_dev then
      if vim.g.opsconfig.global.languages.php.phpcs then
        formatters.phpcs = {
          inherit = false,
          command = 'php-cs-fixer',
          args = {
            'fix',
            '--config=' .. config_path .. '/phpcs.php',
            '--using-cache=no',
            '--allow-risky=yes',
            '--verbose',
            '$FILENAME',
          },
          stdin = false,
        }
      end

      formatters.kdlfmt = {
        command = home_path .. '/.cargo/bin/kdlfmt',
        args = {
          'format',
          '$FILENAME',
        },
        stdin = false,
      }
    end

    formatters.shfmt = {
      inherit = false,
      command = 'shfmt',
      args = {
        '-i',
        '2',
        '-ci',
        '-s',
      },
      stdin = true,
    }

    formatters.systemd_analyze = {
      command = 'systemd-analyze',
      args = {
        'verify',
      },
      stdin = false,
    }

    formatters.nginxfmt = {
      inherit = false,
      command = 'nginxfmt',
      args = {
        '--indent',
        '2',
        '$FILENAME',
      },
      stdin = false,
    }

    -- }}}

    -- Formatters by File Type {{{

    local formatters_by_ft = {}

    if vim.g.opsconfig.global.is_dev then
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

      if vim.g.opsconfig.global.languages.php.phpcs then
        formatters_by_ft.php = { 'phpcs' }
      end
    end

    formatters_by_ft.nginx = { 'nginxfmt' }
    formatters_by_ft.json = { 'prettier' }
    formatters_by_ft.yaml = { 'yamlfmt' }
    formatters_by_ft.markdown = { 'prettier' }
    formatters_by_ft.graphql = { 'prettier' }
    formatters_by_ft.sh = { 'shfmt' }
    formatters_by_ft.bash = { 'shfmt' }
    formatters_by_ft.zsh = { 'shfmt' }
    formatters_by_ft.systemd = { 'systemd_analyze' }

    -- }}}

    conform.setup({
      log_level = vim.log.levels.DEBUG,
      notify_on_error = true,
      formatters = formatters,
      formatters_by_ft = formatters_by_ft,

      format_on_save = function(bufnr)
        conform.format(vim.tbl_extend('force', { bufnr = bufnr }, format_opts))
      end,
    })

    -- }}}

    vim.keymap.set({ 'n', 'v' }, '<leader>ff', function()
      conform.format(format_opts)
    end, { desc = '[F]ormat [F]ile or Range' })
  end,
}
