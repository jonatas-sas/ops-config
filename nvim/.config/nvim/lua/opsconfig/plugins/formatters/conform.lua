return {
  -- NOTE:  Asynchronous and configurable formatting for multiple languages in Neovim.
  --  Supports multiple formatters with automatic fallback.
  --  Integrates with autocmds to format files on save.
  --  Lightweight, no external dependencies, and easy to set up.
  --  Repository: https://github.com/stevearc/conform.nvim
  'stevearc/conform.nvim',

  enabled = vim.g.opsconfig.plugins.conform_nvim,

  event = {
    'BufReadPre',
    'BufNewFile',
  },

  config = function()
    local conform = require('conform')

    -- SECTION: Setup

    local home_path = os.getenv('HOME')
    local config_path = home_path .. '/.opsconfig/applications/config'
    local format_opts = { lsp_fallback = true, async = false, timeout_ms = 1000 }

    -- SUBSECTION: Formatters

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

        formatters['php-cs-fixer-config'] = {
          inherit = false,
          command = 'php-cs-fixer',
          args = {
            'fix',
            '--rules=array_indentation,align_multiline_comment,braces',
            '--using-cache=no',
            '--quiet',
            '$FILENAME',
          },
          stdin = false,
        }

        formatters['php-template'] = {
          inherit = false,
          command = 'prettier',
          args = {
            '--parser=html',
            '--plugin=prettier-plugin-php',
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

    -- SUBSECTION: Formatters by File Type

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
      formatters_by_ft.gotmpl = { 'prettier' }

      if vim.g.opsconfig.global.languages.php.phpcs then
        formatters_by_ft.php = { 'phpcs' }
        formatters_by_ft.phphtml = { 'php-template' } -- compatível com *.php em views
        formatters_by_ft.phtml = { 'php-template' } -- compatível com *.phtml templates
        formatters_by_ft.phpconfig = { 'php-cs-fixer-config' }
        formatters_by_ft.pconf = { 'php-cs-fixer-config' } -- config extra em *.pconf
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
      log_level = vim.log.levels.DEBUG,
      notify_on_error = true,
      formatters = formatters,
      formatters_by_ft = formatters_by_ft,

      format_on_save = function(bufnr)
        conform.format(vim.tbl_extend('force', { bufnr = bufnr }, format_opts))
      end,
    })

    -- SECTION: Keymaps

    vim.keymap.set({ 'n', 'v' }, '<leader>ff', function()
      conform.format(format_opts)
    end, { desc = '[F]ormat [F]ile or Range' })
  end,
}
